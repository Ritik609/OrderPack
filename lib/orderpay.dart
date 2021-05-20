import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:updatedop/afterOrderSubmit.dart';



final db = Firestore.instance;

class OrderPay extends StatefulWidget {
 
  int referint;
  String date, tprice, tweight, name,person;
  OrderPay(this.person,this.name, this.date, this.tweight, this.tprice);
  @override
  State<StatefulWidget> createState() {
    return OrderPayState(this.person,
        this.name, this.date, this.tweight, this.tprice);
  }
}

double cash, unpaid, upi;
TextEditingController payPriceController = TextEditingController();

class OrderPayState extends State<OrderPay> {
  double totprice,totweight,totpaid;
  var _formkey = GlobalKey<FormState>();
  int referint;
  String date, tweight, tprice, name,person;
  OrderPayState(this.person,this.name, this.date, this.tweight, this.tprice);

  String _currentSelectedValue = '';
  var _size = ['Cash', 'UPI', 'Unpaid'];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Payment Portal"),
            automaticallyImplyLeading: false,
          ),
          body: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
               
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 5.0),
                  child: Row(children: <Widget>[
                    Text("Customer Name :  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    Text("$name",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 5.0),
                  child: Row(children: <Widget>[
                    Text("Total Price ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    Text("$tprice",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 5.0),
                  child: Row(children: <Widget>[
                    Text("Total Weight :  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    Text("$tweight",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0)),
                  ]),
                ),
                Card(
                    elevation: 3.0,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0, top: 13.0),
                          child: Text(
                            "Select Payment Mode",
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w500),
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            items: _size.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            iconSize: 38.0,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 22.0,
                                fontWeight: FontWeight.w500),
                            onChanged: (String newValueSelected) {
                              setState(() {
                                this._currentSelectedValue = newValueSelected;
                              });
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(top: 25.0, left: 15.0, right: 5.0),
                  child: Row(children: <Widget>[
                    Text("Payment Method :  ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0)),
                    Text("$_currentSelectedValue",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 18.0)),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: 15.0, bottom: 20.0, left: 20.0, right: 40.0),
                  child: TextFormField(
                    controller: payPriceController,
                    keyboardType: TextInputType.number,
                    validator: (String value) {
                      if (value.isEmpty)
                        return 'Please Enter the Amount given by Customer';
                      else if (_currentSelectedValue == 'Unpaid' &&
                          payPriceController.text != '0')
                        return 'Paid Amount must Be 0';
                      else if (double.parse(payPriceController.text) >
                          double.parse(tprice))
                        return 'Paid Amount must not exceed the total Amount';
                       else if(!(_currentSelectedValue=='Unpaid' || _currentSelectedValue=='Cash' ||_currentSelectedValue=='UPI'))
                        return 'Enter the Payment Method'; 
                    },
                    onChanged: (value) {
                      debugPrint('Something changed in Weight Text Field');
                    },
                    decoration: InputDecoration(
                        labelText: 'Pay Amount in Rs',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 90.0, right: 90.0),
                  child: RaisedButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'SUBMIT',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () async {
                        if (_formkey.currentState.validate()) {
                          if (_currentSelectedValue == 'Cash') {
                            cash = double.parse(payPriceController.text);
                            unpaid = double.parse(tprice) - cash;
                            await db
                                .collection('sales')
                                .document('sales')
                                .collection(date)
                                .document(name)
                                .setData({
                              'Customer Name': name,
                              //'Reference': refer,
                              'Total Weight':tweight.toString(),
                              'Total price': tprice.toString(),
                              'Payment Mode': _currentSelectedValue,
                              'Amount Paid': cash.toString(),
                              'unpaid': unpaid.toString(),
                              'Payment Date': date
                            });
                          } else if (_currentSelectedValue == 'UPI') {
                            await db
                                .collection('sales')
                                .document('sales')
                                .collection(date)
                                .document(name)
                                .setData({
                              'Customer Name': name,
                             // 'Reference': refer,
                              'Total Weight':tweight.toString(),
                              'Total price': tprice.toString(),
                              'Payment Mode': _currentSelectedValue,
                              'Amount Paid': payPriceController.text,
                              'Payment Date': date,
                              'unpaid': (double.parse(tprice) -
                                      double.parse(payPriceController.text))
                                  .toString()
                            });
                          } else if(_currentSelectedValue == 'Unpaid') {
                            unpaid = double.parse(tprice);
                            await db
                                .collection('sales')
                                .document('sales')
                                .collection(date)
                                .document(name)
                                .setData({
                              'Customer Name': name,
                              //'Reference': refer,
                              'Total Weight':  tweight,
                              'Total price':  tprice,
                             
                              'Payment Mode': _currentSelectedValue,
                              'Amount Paid':'0',
                              'unpaid': unpaid.toString(),
                              'Payment Date': date
                            });
                          }
                         
                          String paid=payPriceController.text;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SaleUpdateList(person,double.parse(tprice),double.parse(tweight)
                            ,name,_currentSelectedValue.toString(),paid,date)),
                          );
                          payPriceController.clear();
                        }
                      }),
                ),
              ],
            ),
          )),
    );
  }
}