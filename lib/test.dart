import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  //OrderLogin();
  @override
  State<StatefulWidget> createState() {
    return TestPage();
  }
}



class TestPage extends State<Test> {
 String tpd,tp,tw;


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(body: Column(children: <Widget>[
RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'ADD ITEMS',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: ()  {StreamSubscription<DocumentSnapshot> subscription;
                                  final db = Firestore.instance;
                              final DocumentReference field = Firestore.instance
                                  .document("data/Moriya kirana");
                              void _fetch() {
                                field.get().then((datasnapshot) {
                                  if (datasnapshot.exists) {
                                    setState(() {
                                      tp = datasnapshot.data['Total price'];
                                      tw = datasnapshot.data['Total Weight'];
                                      tpd = datasnapshot.data['Amount Paid'];
                                      
                                    });
                                  }
                                });
                              }

                              @override
                              void initState() {
                                super.initState();
                                subscription =
                                    field.snapshots().listen((datasnapshot) {
                                  if (datasnapshot.exists) {
                                    setState(() {
                                 tp = datasnapshot.data['Total price'];
                                      tw = datasnapshot.data['Total Weight'];
                                      tpd = datasnapshot.data['Amount Paid'];
                                    });
                                  }
                                });
                              }

                              @override
                              void dispose() {
                                super.dispose();
                                subscription?.cancel();
                              }
                              debugPrint(tp);
                              debugPrint(tw);
                              debugPrint(tpd);
                             }) ]));
  }
}