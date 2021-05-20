import 'package:flutter/material.dart';

import 'Screen1.dart';

class Y extends StatelessWidget {
  String name, item, weight, price, ref, size;
  Y(this.ref, this.name, this.item, this.size, this.price, this.weight);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Screen1();
                }));
              },
              child: Text("Sign Out"),
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text("Reference Number:$ref"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text("Name:$name"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text("Item:$item"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text("Packing Size:$size"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text("Price:$price"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
              child: Text("Weight:$weight"),
            ),
           
          ],
        ));
  }
}
