import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:updatedop/ItemRefList.dart';

DateTime _currentdate = new DateTime.now();
String str = new DateFormat.yMMMd().format(_currentdate);

class DateListRef extends StatefulWidget {
  String date;

  DateListRef(this.date);

  @override
  State<StatefulWidget> createState() {
    return DateListRefState(this.date);
  }
}

class DateListRefState extends State<DateListRef> {
  String date;
  DateListRefState(this.date);
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Reference Lists"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance.collection(date).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                      title:
                          new Text(document['Customer']),
                          subtitle: Text(document['Address']),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                      contentPadding: EdgeInsets.all(20.0),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ItemListRef(document['Customer'],date);
                        }));
                      },
                    ),
                  );
                }).toList(),
              );
          }
        },
      ),
    );
  }
}
