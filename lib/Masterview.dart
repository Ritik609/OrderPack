import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Screen1.dart';

class MasterBookList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BookListState();
  }
}

class BookListState extends State<MasterBookList> {
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
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Order Details"),
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
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('sales')
              .document('sales')
              .collection('Mar 14, 2020')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return new Text('Loading...');
              default:
                return new ListView(
                  children:
                      snapshot.data.documents.map((DocumentSnapshot document) {
                    return Card(
                      elevation: 8.0,
                      child: new ListTile(
                        title: new Text('Reference Number:' + document['date']),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 25.0,
                        ),
                        contentPadding: EdgeInsets.all(20.0),
                        onTap: () {},
                      ),
                    );
                  }).toList(),
                );
            }
          },
        ),
      ),
    );
  }
}
