import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'cust.dart';

class PreviewSalesDetails extends StatelessWidget {
  String name,date, drop,paid,totprice,totpaid,totweight,person;
  double tweight;
  double tprice;
  PreviewSalesDetails (this.person,this.tprice,this.tweight,this.name,this.drop,this.paid,this.date,this.totprice,this.totweight,this.totpaid  );
 
  @override
  Widget build(BuildContext context) {
    final db = Firestore.instance;
   double  doublePaid=double.parse(paid)+double.parse(totpaid);
  double totalp=tprice+double.parse(totprice);
  double totalw=tweight+double.parse(totweight);
 
  //double unpaid=totalp-totalpaid;
    return Scaffold(
        appBar: AppBar(
          title: Text("Sales Details"),
          
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20.0, left: 15.0, right: 20.0, bottom: 40.0),
            child: Card(
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 25.0, left: 85.0, right: 10.0),
                    child: Row(children: <Widget>[
                      Text("Sales Details",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0)),
                    ]),
                  ),
                 /* Padding(
                    padding: EdgeInsets.only(top: 45.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Reference Number :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$ref",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),*/
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Customer Name :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Expanded(
                          child: Text("$name",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0))),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Total Weight(in KG):  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$totalw",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Total Price(in INR):  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$totalp",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Payment Mode :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$drop",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Last Payment Date :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$date",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Amount Paid(in INR) :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$doublePaid",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 15.0, left: 15.0, right: 5.0, bottom: 30.0),
                    child: Row(children: <Widget>[
                      Text("Unpaid Amount(in INR) :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("${totalp-doublePaid}",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 35.0, right: 35.0),
                    child: RaisedButton(
                        padding: EdgeInsets.only(
                            top: 15.0, bottom: 15.0, left: 5.0, right: 15.0),
                        child: Text(
                          "SUBMIT",
                          textScaleFactor: 1.5,
                        ),
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed : ()async {
                          await db
                                .collection('sales')
                                .document('sales')
                                .collection(date)
                                .document(name).collection('temp').document('temp')
                                .setData({
                              'Customer Name': name,
                              //'Reference': refer,
                              'Total Weight': totalw.toString(),
                              'Total price': totalp.toString(),
                             
                              'Payment Mode': drop,
                              'Amount Paid':doublePaid.toString(),
                              'unpaid':(totalp-doublePaid).toString(),
                              'Payment Date': date
                            });
                             await db
                                .collection('sales')
                                .document('sales')
                                .collection(date)
                                .document(name)
                                .setData({
                              'Customer Name': name,
                              //'Reference': refer,
                              'Total Weight': totalw.toString(),
                              'Total price': totalp.toString(),
                             
                              'Payment Mode': drop,
                              'Amount Paid':doublePaid.toString(),
                              'unpaid':(totalp-doublePaid).toString(),
                              'Payment Date': date
                            });
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {


                              return CustList(person);
                            }),
                          );
                        }),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}