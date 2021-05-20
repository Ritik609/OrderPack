import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:updatedop/MasterLogin.dart';
import 'package:updatedop/saleslogin.dart';
import 'package:updatedop/screen2.dart';
import 'package:updatedop/viewlogin.dart';

int refer;
String ref;

class Screen1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return Screen1State();
  }
}

class Screen1State extends State<Screen1> {
  bool isLogin = false;

  Future _cekLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin") == false) {
      Navigator.pop(context, true);
    }
  }

  Future _cekLogout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setBool("isLogin", false);
    Navigator.pop(context, true);
  }

  String name = "";
  Future _cekUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString("username") != null) {
      setState(() {
        name = pref.getString("username");
      });
    }
  }

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
                    _cekLogout();
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          appBar: AppBar(
            title: Text("Order Pack"),
            backgroundColor: Colors.indigo,
            automaticallyImplyLeading: false,
          ),
          body: ListView(children: <Widget>[
            Container(
              padding: EdgeInsets.only(top: 120.0, left: 50.0),
              child: Text(
                "ORDER PACK",
                textScaleFactor: 3.0,
              ),
            ),
            SizedBox(height: 50.0),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: RaisedButton(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          "Order",
                          textScaleFactor: 1.5,
                        ),
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return OrderLogin();
                            }),
                          );
                        })),
                SizedBox(
                  width: 10.0,
                ),
                Expanded(
                    child: RaisedButton(
                        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text(
                          "Sales",
                          textScaleFactor: 1.5,
                        ),
                        color: Theme.of(context).accentColor,
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return SalesLogin();
                            }),
                          );
                        })),
                SizedBox(width: 10.0),
              ],
            ),
            SizedBox(
              height: 30.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(width: 10.0),
                Expanded(
                  child: RaisedButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "Add",
                        textScaleFactor: 1.5,
                      ),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return MasterLogin();
                          }),
                        );
                      }),
                ),
                SizedBox(width: 10.0),
                Expanded(
                  child: RaisedButton(
                      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text(
                        "View",
                        textScaleFactor: 1.5,
                      ),
                      color: Theme.of(context).accentColor,
                      textColor: Colors.white,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return ViewLogin();
                          }),
                        );
                      }),
                ),
                SizedBox(width: 10.0),
              ],
            ),
          ])),
    );
  }
}
