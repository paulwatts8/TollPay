import 'package:flutter/material.dart';
import 'package:tollpay/services/database.dart';

class Amount extends StatefulWidget {
  Amount({Key key}) : super(key: key);

  @override
  _DashListState createState() => _DashListState();
}

class _DashListState extends State<Amount> {
  var fireAmount;
  DatabaseMethods fireData = new DatabaseMethods();
  String amount;
  

  @override
  void initState() {
    fireData.getAmount().then((results) {
      setState(() {
        fireAmount = results;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (fireAmount != null) {
      return StreamBuilder(
          stream: fireAmount,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text("K0.00");
            } else {
              return Text('K '+snapshot.data.documents[0].data['Amount'],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
              )
              );
              
            }
          });
    } else {
      return Text('no amount');
    }
  }
}
