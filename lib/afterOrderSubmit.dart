
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:updatedop/preview.dart';




class SaleUpdateList extends StatefulWidget {
  double tprice,tweight;
  String name,drop,date,paid,person;
  SaleUpdateList(this.person,this.tprice,this.tweight,this.name,this.drop,this.paid,this.date);
  @override
  State<StatefulWidget> createState() {
    return SaleUpdateListState(this.person,this.tprice,this.tweight,this.name,this.drop,this.paid,this.date);
  }
}

class SaleUpdateListState extends State<SaleUpdateList> {
  double tprice,tweight;
  String name,drop,date,paid,person;
 
SaleUpdateListState(this.person,this.tprice,this.tweight,this.name,this.drop,this.paid,this.date);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sales Query"),
        automaticallyImplyLeading: false,
       
      ),
      body: 
      Center(
        child: Column(
          children: <Widget>[Padding(
                      padding: EdgeInsets.only(left: 35.0, right: 35.0,top:35.0,bottom:75.0),
                      child: RaisedButton(
                          padding: EdgeInsets.only(
                              top: 15.0, bottom: 15.0, left: 5.0, right: 10.0),
                          child: Text(
                            "Proceed",
                            textScaleFactor: 1.5,
                          ),
                          color: Theme.of(context).accentColor,
                          textColor: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return PreviewSalesDetails(person,tprice,tweight,name,drop,paid,date,
                                  '0','0','0'
                                
                                  );
                              }),
                            );
                          }),
                    ),
            Padding(
              padding: const EdgeInsets.only(bottom:18.0),
              child: Text("Generating Sale's Report ...........",
              style: TextStyle(fontWeight:FontWeight.bold,fontSize: 20.0 ),),
            ),        
            Flexible(
                    child: StreamBuilder<QuerySnapshot>(
                
                stream: Firestore.instance.collection('sales/sales/$date/$name/temp').snapshots(),
                builder:
                    (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return new Text("Loading......");
                    default:
                     

                      return new ListView(
                        children:
                            snapshot.data.documents.map((DocumentSnapshot document) {
                          return Card(
                            elevation: 8.0,
                            child: new ListTile(
                              title: new Text("      CONTINUE BY TAPPING", style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15.0 ),),
                              //subtitle: new Text("${document['Total price']}"),
                              trailing: Icon(
                                Icons.arrow_forward_ios,
                                size: 25.0,
                              ),
                              contentPadding: EdgeInsets.all(20.0),
                             onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  if(document['Total Price']==null)
                                  // return PreviewSalesDetails(tprice,tweight,name,drop,paid,date,'0','0','0');
                                   return PreviewSalesDetails(person,tprice,tweight,name,drop,paid,date,
                                  document['Total price'].toString(),document['Total Weight'].toString(),document['Amount Paid'].toString()
                                   ,
                                  );
                                  else     
                                   return PreviewSalesDetails(person,tprice,tweight,name,drop,paid,date,
                                   document['Total Price'].toString(),document['Total Weight'].toString(),document['Amount Paid'].toString()
                                   ,
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
          ],
        ),
      ),
    );
  }
}
