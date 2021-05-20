import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:updatedop/salesref.dart';


final db = Firestore.instance;
DateTime currentdate = new DateTime.now();
String str = new DateFormat.yMMMd().format(currentdate);

class EditPay extends StatefulWidget {

  String unpaid, paid, tprice, tweight, name, date,paymentDt,address;
  EditPay( this.name, this.tweight, this.tprice, this.paid,
      this.unpaid, this.date,this.paymentDt,this.address);
  @override
  State<StatefulWidget> createState() {
    return EditPayState( this.name, this.tweight, this.tprice,
        this.paid, this.unpaid, this.date,this.paymentDt,this.address);
  }
}

var totalprice, totalunpaid;
TextEditingController payController = TextEditingController();

class EditPayState extends State<EditPay> {
  var _formkey = GlobalKey<FormState>();
  String unpaid, paid, tprice, tweight,  name,paymentDt, date,address;
  EditPayState( this.name, this.tweight, this.tprice, this.paid,
      this.unpaid, this.date,this.paymentDt,this.address);
  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Do You Really want to exit the App"),
              actions: <Widget>[
                FlatButton(
                  child: Text("No"),
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                ),
                FlatButton(
                  child: Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop:()=>Future.value(false),
        child: Scaffold(
            appBar: AppBar(
              title: Text("Pending Bill"),
              automaticallyImplyLeading: false,
            
            ),
            body: Padding(padding: EdgeInsets.only(left:20.0,top:15.0,right:40.0),
                          child: Form(
                  key: _formkey,
                  child: ListView(children: <Widget>[
                   // Text("Reference Number:$refer"),
                    Text("Customer Name:$name"),
                    Text("Address:$address"),
                    Text("Total Price(in INR):$tprice"),
                    Text("Total Weight(in KG):$tweight"),
                    Text("Total Paid (in INR):$paid"),
                    Text("Total Unpaid(in INR):$unpaid"),
                    Text("Last Payment Date:$paymentDt"),
                   Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                        child: TextFormField(
                          controller: payController,
                         // style: textStyle,
                          keyboardType: TextInputType.number,
                          validator: (String value) {
                            if (value.isEmpty) return 'Please Enter the Amount given by Customer';
                            
                             else if (double.parse(payController.text)>double.parse(unpaid))                           
                               return 'Paid Amount must not exceed the total Amount';

                          },
                          onChanged: (value) {
                            debugPrint('Something changed in Weight Text Field');
                          },
                          decoration: InputDecoration(
                              labelText: 'Pay Unpaid Amount',
                           //   labelStyle: textStyle,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0))),
                        ),
                      ),
                      
                         Padding(padding: EdgeInsets.only(left:80.0,right:80.0),
                                                  child: RaisedButton(padding: EdgeInsets.only(top:10.0,bottom:10.0),
                              child: Text(
                                "PAY BILL",
                                textScaleFactor: 1.5,
                              ),
                              color: Theme.of(context).accentColor,
                              textColor: Colors.white,
                              onPressed: () {
                             totalprice=double.parse(paid)+double.parse(payController.text);
                             totalunpaid=double.parse(unpaid)-double.parse(payController.text);
                           db.collection('sales').document('sales').collection(date).document(name).updateData(
                                      {
                                        'unpaid':totalunpaid.toString(),
                                        'Amount Paid':totalprice.toString(),
                                        'Payment Date':str
                                        
                                                                          },
                                    );
                                   payController.clear();
                                 //  Navigator.pop(context);
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return SalesListRef(date);
                                    }),
                                    (Route<dynamic>route)=>false,
                                  );
                              }),
                         )
                  ])
                  ),
            )));
  }
}
