import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'orderpay.dart';

DateTime _currentdate = new DateTime.now();
String str = new DateFormat.yMMMd().format(_currentdate);

class New4 extends StatefulWidget {
  String appbardetail, customer, mobile, address,person;
 
 

  New4(this.person,this.appbardetail, this.customer, this.mobile, this.address);
  @override
  State<StatefulWidget> createState() {
    return New4States(this.person,
        this.appbardetail, this.customer, this.mobile, this.address);
  }
}

class New4States extends State<New4> {
  double totprice,totweight,totpaid;
  String person;
  var _formkey = GlobalKey<FormState>();
  StreamSubscription<DocumentSnapshot> subscription;

  final db = Firestore.instance;

  String fields, customer, date, mobile, address, reference, price, weight;
  int nums;
  double pricedouble, weightdouble,doublePrice,doubleWeight;

  static var count, countNew,priceSum,weightSum;
  final DocumentReference field = Firestore.instance.document("Field/temp");
  void _fetch() {
    field.get().then((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          fields = datasnapshot.data['date'];
          count = datasnapshot.data['count'];
         // reference = datasnapshot.data['reference'];
          //referint = int.parse(reference);
          countNew = int.parse(count);
          price = datasnapshot.data['price'];
          pricedouble = double.parse(price);
          weight = datasnapshot.data['weight'];
          weightdouble = double.parse(weight);
        });
      }
    });
  }
  
  @override
  void initState() {
    super.initState();
    subscription = field.snapshots().listen((datasnapshot) {
      if (datasnapshot.exists) {
        setState(() {
          fields = datasnapshot.data['date'];
          count = datasnapshot.data['count'];
         // reference = datasnapshot.data['reference'];
          //referint = int.parse(reference);
          countNew = int.parse(count);
          price = datasnapshot.data['price'];
          pricedouble = double.parse(price);
          weight = datasnapshot.data['weight'];
          weightdouble = double.parse(weight);
           
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription?.cancel();
  }

  String _currentSelectedValue = '250 GM';
  var _size = ['250 GM', '500 GM', '1 KG','Khula'];

  TextEditingController priceController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  TextEditingController schemeController = TextEditingController();
  String appbardetail;
  New4States(this.person,this.appbardetail, this.customer, this.mobile, this.address);

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
        appBar: AppBar(
          title: Text(appbardetail),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: Form(
                key: _formkey,
                child: ListView(children: <Widget>[
                  // Second Element

                  //element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextFormField(
                      controller: priceController,
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) return 'Please Enter the Price';
                      },
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Something changed in Price Text Field');
                      },
                      decoration: InputDecoration(
                          labelText: 'Price(in INR)',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  //Second Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 20.0),
                    child: TextFormField(
                      controller: weightController,
                      style: textStyle,
                      keyboardType: TextInputType.number,
                      validator: (String value) {
                        if (value.isEmpty) return 'Please Enter the Weight';
                      },
                      onChanged: (value) {
                        debugPrint('Something changed in Weight Text Field');
                      },
                      decoration: InputDecoration(
                          labelText: 'Weight in KG',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                  //Third Element

                  Card(
                      elevation: 3.0,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 8.0, top: 3.0),
                            child: Text(
                              "Select Packaging Size",
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w500),
                            ),
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              items: _size.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              iconSize: 38.0,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.w500),
                              onChanged: (String newValueSelected) {
                                setState(() {
                                  this._currentSelectedValue = newValueSelected;
                                });
                              },
                              value: _currentSelectedValue,
                            ),
                          ),
                        ],
                      )),

                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: TextFormField(
                      controller: schemeController,
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      onChanged: (value) {
                        debugPrint('Something changed in Scheme Text Field');
                      },
                      decoration: InputDecoration(
                          labelText: 'Scheme',
                          labelStyle: textStyle,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),

                  // Fourth Element
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'ADD ITEMS',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                db.collection('Date').document(str).setData(
                                  {
                                    'Date': str,
                                  },
                                );

                                if (str == fields) {
                                  countNew++;
                                  db
                                      .collection('Field')
                                      .document('temp')
                                      .updateData(
                                    {
                                      'count': countNew.toString(),
                                    },
                                  );

                                  await db
                                      .collection(str)
                                      .document(reference)
                                      .setData({
                                   // 'reference': reference,
                                    'date': str
                                  });
                                  await db
                                      .collection('suscom')
                                      .document(str)
                                      .collection(customer)
                                      .document(countNew.toString())
                                      .setData(
                                    {
                                      //'Customer Name': nameController.text,
                                      'Date': str,
                                     // 'Reference Number:': referint.toString(),
                                      'Item Count': countNew.toString(),
                                      'Customer': customer,
                                      'Mobile Number': mobile,
                                      'Address': address,
                                      'Item:': appbardetail,
                                      'Price': priceController.text,
                                      'Weight': weightController.text,
                                      'Packing Size': _currentSelectedValue,
                                      'Scheme': schemeController.text,
                                      'Sales Person':person.toString(),
                                    },
                                  );
                                } else {
                                  //referint = 1;
                                  countNew++;
                                  db
                                      .collection('Field')
                                      .document('temp')
                                      .setData(
                                    {
                                    //  'reference': referint.toString(),
                                      'count': countNew.toString(),
                                    },
                                  );

                                  await db
                                      .collection(str)
                                      .document(customer)
                                      .setData({
                                    //'reference': referint.toString(),
                                    'date': str
                                  });
                                  await db
                                      .collection('suscom')
                                      .document(str)
                                      .collection(customer)
                                      .document(countNew.toString())
                                      .setData(
                                    {
                                      //'Customer Name': nameController.text,
                                      'Date': str,
                                     // 'Reference Number:': referint.toString(),
                                      'Item Count': countNew.toString(),
                                      'Customer': customer,
                                      'Mobile Number': mobile,
                                      'Address': address,
                                      'Item:': appbardetail,
                                      'Price': priceController.text,
                                      'Weight': weightController.text,
                                      'Packing Size': _currentSelectedValue,
                                      'Scheme': schemeController.text,
                                       'Sales Person':person.toString(),
                                    },
                                  );
                                }

                                String tprice = (pricedouble +
                                        (double.parse(priceController.text) *
                                            double.parse(
                                                weightController.text)))
                                    .toString();
                                String tweight = (weightdouble +
                                        double.parse(weightController.text))
                                    .toString();

                                db.collection('Field').document('temp').setData(
                                  {
                                    'count': countNew.toString(),
                                    //'reference': referint.toString(),
                                    'date': str,
                                    'price': tprice,
                                    'weight': tweight,
                                  },
                                );
                                await db
                                    .collection('sales')
                                    .document('sales')
                                    .collection(str)
                                    .document(customer)
                                    .setData({
                                  'Customer Name': customer,
                                 // 'Reference': referint.toString(),
                                  'Total Weight': tweight,
                                  'Total price': tprice,
                                  'Payment Mode': '0',
                                  'Amount Paid': '0',
                                  'unpaid': tprice,
                                });
                                Navigator.pop(context);
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

//Submit Button button
                  Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: RaisedButton(
                            color: Theme.of(context).primaryColorDark,
                            textColor: Theme.of(context).primaryColorLight,
                            child: Text(
                              'SUBMIT',
                              textScaleFactor: 1.5,
                            ),
                            onPressed: () async {
                              if (_formkey.currentState.validate()) {
                                db.collection('Date').document(str).setData(
                                  {
                                    'Date': str,
                                  },
                                );

                                if (str == fields) {
                                  countNew++;
                                  db
                                      .collection('Field')
                                      .document('temp')
                                      .updateData(
                                    {
                                      'count': countNew.toString(),
                                    },
                                  );

                                  await db
                                      .collection(str)
                                      .document(customer)
                                      .setData({
                                    'name': customer,
                                    'date': str
                                  });
                                  await db
                                      .collection('suscom')
                                      .document(str)
                                      .collection(customer)
                                      .document(countNew.toString())
                                      .setData(
                                    {
                                      'Date': str,
                                      //'Reference Number:': referint.toString(),
                                      'Item Count': countNew.toString(),
                                      'Customer': customer,
                                      'Mobile Number': mobile,
                                      'Address': address,
                                      'Item:': appbardetail,
                                      'Price': priceController.text,
                                      'Weight': weightController.text,
                                      'Packing Size': _currentSelectedValue,
                                      'Scheme': schemeController.text,
                                        'Sales Person':person.toString(),
                                    },
                                  );
                                } else {
                                 // referint = 1;
                                  countNew++;
                                  db
                                      .collection('Field')
                                      .document('temp')
                                      .setData(
                                    {
                                     // 'reference': referint.toString(),
                                      'count': countNew.toString(),
                                    },
                                  );
                                  await db
                                      .collection(str)
                                      .document(customer)
                                      .setData({
                                    'name': customer,
                                    'date': str
                                  });
                                  await db
                                      .collection('suscom')
                                      .document(str)
                                      .collection(customer)
                                      .document(countNew.toString())
                                      .setData(
                                    {
                                      'Date': str,
                                      //'Reference Number:': referint.toString(),
                                      'Item Count': countNew.toString(),
                                      'Customer': customer,
                                      'Mobile Number': mobile,
                                      'Address': address,
                                      'Item:': appbardetail,
                                      'Price': priceController.text,
                                      'Weight': weightController.text,
                                      'Packing Size': _currentSelectedValue,
                                      'Scheme': schemeController.text,
                                        'Sales Person':person.toString(),
                                    },
                                  );

                                  db
                                      .collection('Field')
                                      .document('temp')
                                      .setData(
                                    {
                                      'date': str,
                                    },
                                  );
                                }
                                String tprice = (pricedouble + 
                                        (double.parse(priceController.text) *
                                            double.parse(
                                                weightController.text)))
                                    .toString();
                                String tweight = (weightdouble +
                                        double.parse(weightController.text))
                                    .toString();

                                db
                                    .collection('sales')
                                    .document('sales')
                                    .collection(str)
                                    .document(customer)
                                    .setData(
                                  {
                                    'Total price': tprice,
                                    'Total Weight': (weightdouble +
                                            double.parse(weightController.text))
                                        .toString(),
                                   'Amount Paid': '0',
                                  },
                                );
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderPay(person,customer,
                                          str,tweight, tprice)),
                                  (Route<dynamic> route) => false,
                                );

                             //   referint++;
                                db.collection('Field').document('temp').setData(
                                  {
                                    'count': countNew.toString(),
                                   // 'reference': referint.toString(),
                                    'date': str,
                                    'price': '0',
                                    'weight': '0',
                                  },
                                );
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]))));
  }
}