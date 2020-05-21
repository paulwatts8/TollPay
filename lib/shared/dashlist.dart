import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tollpay/screens/loading.dart';
import 'package:tollpay/services/database.dart';

class DashList extends StatefulWidget {
  DashList({Key key}) : super(key: key);

  @override
  _DashListState createState() => _DashListState();
}

class _DashListState extends State<DashList> {
 var toll;
  DatabaseMethods fireData = new DatabaseMethods();

  @override
  void initState() {
    fireData.getToll().then((results) {
      setState(() {
        toll = results;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (toll != null) {
      return StreamBuilder<QuerySnapshot>(
          stream: toll,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: new ListTile(
                  title: new Text(''),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                padding: EdgeInsets.all(5.0),
                itemBuilder: (context, i) {
                  return new Card(
                      margin: EdgeInsets.only(top: 2.0),
                      child: new ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.indigo,
                          radius: 25.0,
                        ),
                        title: new Text(
                            'Toll Gate: ' + snapshot.data.documents[i].data['toll Number']),
                        subtitle: new Text(
                            'Plate Number: ' +snapshot.data.documents[i].data['Plate Number']),
                        trailing:
                            new Text(
                              'K'+snapshot.data.documents[i].data['Amount']),
                      ));
                },
              );
            }
          });
    } else {
      return Loading();
    }
    
    
  }
}
