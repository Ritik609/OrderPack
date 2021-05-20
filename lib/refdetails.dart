import 'package:flutter/material.dart';

class RefDetails extends StatefulWidget {
  String name, item, weight,person, price, size, address, mobile, scheme;
  RefDetails(this.person, this.name, this.item, this.size, this.price, this.weight,
      this.address, this.mobile, this.scheme);
  @override
  State<StatefulWidget> createState() {
    return RefDetailsState(this.person, this.name, this.item, this.size,
        this.price, this.weight, this.address, this.mobile, this.scheme);
  }
}

class RefDetailsState extends State<RefDetails> {
  String name, item, weight, price, size, address,person, mobile, scheme;
  RefDetailsState(this.person, this.name, this.item, this.size, this.price,
      this.weight, this.address, this.mobile, this.scheme);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.only(
                top: 70.0, left: 15.0, right: 20.0, bottom: 100.0),
            child: Card(
              elevation: 15.0,
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding:
                        EdgeInsets.only(top: 25.0, left: 85.0, right: 10.0),
                    child: Row(children: <Widget>[
                      Text("Order Details",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 22.0)),
                    ]),
                  ),
                  /*Padding(
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
                      Text("Sales person :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Expanded(
                          child: Text("$person",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 18.0))),
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
                      Text("$address",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Mobile :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$mobile",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Item :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$item",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Packing Size :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$size",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, left: 15.0, right: 5.0),
                    child: Row(children: <Widget>[
                      Text("Price(in INR):  ",
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
                      Text("Weight(in KG) :  ",
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
                      Text("Scheme(in KG) :  ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18.0)),
                      Text("$scheme",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18.0)),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}