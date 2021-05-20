import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'cust.dart';

class OrderLogin extends StatefulWidget {
  OrderLogin();
  @override
  State<StatefulWidget> createState() {
    return OrderLoginPage();
  }
}

var email = '';
var password = '';
bool isLogin = false;

class OrderLoginPage extends State<OrderLogin> {
  var _formkey = GlobalKey<FormState>();
  var emailControlled = TextEditingController();
  var passwordControlled = TextEditingController();

  StreamSubscription<DocumentSnapshot> subscription;

  final db = Firestore.instance;

  String customer, date, mobile, address,person;
  static var role, uid, pass;
  @override
  final DocumentReference documentReference =
      Firestore.instance.document("Login/Santosh");
  void _fetch() {
    documentReference.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          role = datasnapshot.data['role'];
          uid = datasnapshot.data['userName'];
          pass = datasnapshot.data['password'];
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    subscription = documentReference.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          role = datasnapshot.data['role'];
          uid = datasnapshot.data['userName'];
          pass = datasnapshot.data['password'];
        });
      }
    });
    _cekLogin();
  }

  Future _cekLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getBool("isLogin") == true) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) {
          return CustList(pref.getString("username"));
        }),
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text('Order Pack(Seller)'),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          child: Center(
            child: Form(
              key: _formkey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: emailControlled,
                      validator: (String value) {
                        if (value.isEmpty)
                          return 'Please Enter the Username';
                        else if (emailControlled.text != uid &&
                            passwordControlled.text != pass)
                          return 'Enter valid Username';
                        else if (emailControlled.text != uid ||
                            passwordControlled.text != pass)
                          return 'Enter valid Username';
                      },
                      decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.email,
                            color: Colors.pink,
                          ),
                          labelText: "UserID",
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                    ),
                  ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: TextFormField(
                      style: textStyle,
                      controller: passwordControlled,
                      validator: (value) {
                        if (value.isEmpty)
                          return 'Please Enter the Passwor';
                        else if (emailControlled.text != uid &&
                            passwordControlled.text != pass)
                          return 'Please Enter valid Password';
                        else if (emailControlled.text != uid ||
                            passwordControlled.text != pass)
                          return 'Enter valid Password';
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.pink,
                        ),
                        labelText: "Password",
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      obscureText: true,
                    ),
                  ),
                  SizedBox(height: 30.0),
                  Container(
                      padding: EdgeInsets.only(
                        left: 20.0,
                        right: 20.0,
                      ),
                      height: 50.0,
                      child: RaisedButton(
                          color: Colors.pink[400],
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(8.0),
                              side: BorderSide(color: Colors.red)),
                          child: Text(
                            'Sign In',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formkey.currentState.validate()) {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setBool("isLogin", true);
                              pref.setString("username", emailControlled.text);
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) {
                                  return CustList(emailControlled.text);
                                }),
                              );
                            } else {
                              SharedPreferences pref =
                                  await SharedPreferences.getInstance();
                              pref.setBool("isLogin", false);
                            }

                            emailControlled.clear();
                            passwordControlled.clear();
                          })),
                ],
              ),
            ),
          ),
        ));
  }
}