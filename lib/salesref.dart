import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:updatedop/salesdate.dart';
import 'package:updatedop/salesdetails.dart';

DateTime _currentdate = new DateTime.now();
String dt = new DateFormat.d().format(_currentdate);


class SalesListRef extends StatefulWidget {
  String date;

  SalesListRef(this.date);

  @override
  State<StatefulWidget> createState() {
    return SalesListRefState(this.date);
  }
}

class SalesListRefState extends State<SalesListRef> {
  String date;
  SalesListRefState(this.date);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sales Reference"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            FlatButton(
              textColor: Colors.white,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SalesDateList()),
                );
              },
              child: Text("Date List"),
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: Firestore.instance
              .collection('sales')
              .document('sales')
              .collection(date)
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
                      child: new ListTile(
                          title: new Text(
                              document['Customer Name']),
                          subtitle: Text(document['Address']),
                          trailing: Icon(
                            Icons.arrow_forward_ios,
                            size: 25.0,
                          ),
                          contentPadding: EdgeInsets.all(20.0),
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return SalesRefDetails(
                                  document['Customer Name'].toString(),
                                  //document['Reference'].toString(),
                                  document['Total Weight'].toString(),
                                  document['Total price'],
                                  document['Payment Mode'],
                                  document['Amount Paid'],
                                  document['unpaid'],
                                  document['Payment Date'],
                                  date,
                                  document['Address']
                                );
                              }),
                            );
                          }),
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
