import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//import 'Screen3.dart';
import 'refdetails.dart';

class ItemListRef extends StatefulWidget {
  String date, name;

  ItemListRef(this.name, this.date);
  // DateListRef({Key key}) : super(key :key);
  @override
  State<StatefulWidget> createState() {
    return ItemListRefState(this.name, this.date);
  }
}

class ItemListRefState extends State<ItemListRef> {
  String date, name;
  ItemListRefState(this.name, this.date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Item Ordered"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('suscom')
            .document(date)
            .collection(name)
            .snapshots(),
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
                      title: new Text(document['Item:']),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 25.0,
                      ),
                      contentPadding: EdgeInsets.all(20.0),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return RefDetails(
                             // document['Reference Number:'].toString(),
                             document['Sales Person'],
                              document['Customer'].toString(),
                              document['Item:'].toString(),
                              document['Packing Size'],
                              document['Price'],
                              document['Weight'],
                              document['Address'],
                              document['Mobile Number'],
                              document['Scheme']);
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