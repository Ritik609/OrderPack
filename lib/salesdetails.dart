import 'package:flutter/material.dart';
import 'package:updatedop/editpay.dart';

import 'Screen1.dart';

class SalesRefDetails extends StatelessWidget {
  String name, mode, amount, unpaid, weight, price,  date, paymentDt,address;
  SalesRefDetails(this.name,  this.weight, this.price, this.mode,
      this.amount, this.unpaid, this.paymentDt, this.date,this.address);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Sales Details"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return Screen1();
                  }),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("Main Screen"),
            ),
          ],
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
                      Text("Address :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Expanded(
                          child: Text("$address",
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
                      Text("$weight",
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
                      Text("$price",
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
                      Text("$mode",
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
                      Text("$paymentDt",
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
                      Text("$amount",
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
                      Text("$unpaid",
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
                          "Pay Unpaid Amount",
                          textScaleFactor: 1.5,
                        ),
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return EditPay( name, weight, price, amount,
                                  unpaid, date, paymentDt,address);
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
