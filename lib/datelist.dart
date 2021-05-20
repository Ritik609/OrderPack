import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Screen1.dart';
import 'dateref.dart';

DateTime _currentdate = new DateTime.now();
String str = new DateFormat.yMMMd().format(_currentdate);
String name = '';

class DateList extends StatefulWidget {
  DateList({Key key}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return DateListState();
  }
}

class DateListState extends State<DateList> {
  bool isLogin = false;

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
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text("View Date"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => Screen1()),
                  (Route<dynamic> route) => false,
                );
              },
              child: Text("Main Screen"),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance.collection('Date').snapshots(),
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
                        title: new Text('${document['Date']}'),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          size: 25.0,
                        ),
                        contentPadding: EdgeInsets.all(20.0),
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return DateListRef(
                              document['Date'].toString(),
                            );
                          }));
                        },
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
