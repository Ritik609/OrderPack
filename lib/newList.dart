import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'cust.dart';
import 'myscreen4.dart';

class ListsNew extends StatefulWidget {
  String customer, mobile, address, person;

  ListsNew(this.person, this.customer, this.mobile, this.address);
  @override
  State<StatefulWidget> createState() {
    return ListNewState(this.person, this.customer, this.mobile, this.address);
  }
}

class ListNewState extends State<ListsNew> {
  static var fields;
  StreamSubscription<DocumentSnapshot> subs;
  final DocumentReference field = Firestore.instance.document("Field/temp");
  void _fetch() {
    field.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          fields = datasnapshot.data['date'];
        });
      }
    });
  }

  StreamSubscription<DocumentSnapshot> subscription;

  String customer, mobile, address, priceSum, weightSum;

  int refNum;
  String refer, person;
  int referint;
  double doubleWeight, doublePrice;
  ListNewState(this.person, this.customer, this.mobile, this.address);

  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
          appBar: AppBar(
            title: Text("Items List"),
            automaticallyImplyLeading: false,
            actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () async {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(
                              "\t\t\t\t\t\t\t\t\t! WARNING !\n\nTransaction not done successfully\n\nRecommended :Complete the Transaction.",
                              style: TextStyle(color: Colors.red),
                            ),
                            actions: <Widget>[
                              FlatButton(
                                child: Text("No"),
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                              ),
                              FlatButton(
                                child: Text("Yes"),
                                onPressed: () async {
                                  await db
                                      .collection('Field')
                                      .document('temp')
                                      .updateData({
                                    'price': '0',
                                    'weight': '0',
                                  });
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return CustList(person);
                                  }));
                                },
                              )
                            ],
                          ));
                },
                child: Text("Customer"),
              ),
            ],
          ),
          body: ListView(children: <Widget>[
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Urad Dal"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Urad Dal", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Khari Urad"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Khari Urad", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Kali Urad Dal"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "Kali Urad Dal", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Urad Dhuli "),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Urad Dal", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Tuar Dal"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Tuar DAl", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Moong Dhuli Dal"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "Moong Dhuli Dal", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Mix Dal"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Mix Dal", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Hara Chana"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Hara Chana", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Mix Sattu"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Mix Sattu", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Poha"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Poha", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Jaw Atta"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Jaw atta", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Desi Atta"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Desi Ata", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Makka Ata"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Makka Ata", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Multigrain Ata"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "Multigrain Ata", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Chana Dal"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Chana Dal", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Masur Dal"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Masur Dal", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Moong Chilka"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "Moong Chilka", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Matar"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Matar", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Soyabean Dana"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "Soyabean Dana", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Chawale"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Chawale", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Desi Chana"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Desi Chana", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Khari Masur"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Khari Masur", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Khari Moong"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Khari Moong", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Kabali Chana"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "kabali Chana", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Besan"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Besan", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Golden Besan"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "Golden Besan", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Chana Sattu"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Chana Sattu", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Kabali Chana Bold"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(
                      person, "Kabali Chana Bold", customer, mobile, address);
                }));
              },
            ),
            ListTile(
              leading: Icon(Icons.cloud_circle),
              title: Text("Rajma"),
              subtitle: Text("Best Quality"),
              trailing: Icon(Icons.arrow_right),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return New4(person, "Rajma", customer, mobile, address);
                }));
              },
            )
          ])),
    );
  }
}