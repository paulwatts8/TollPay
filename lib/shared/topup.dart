import 'package:flutter/material.dart';
import 'package:tollpay/services/database.dart';

class TopUp {
  String uid;
  String amount;
  var thisInstant = new DateTime.now();

  DatabaseMethods fireData = new DatabaseMethods();

  Future<bool> dialogTrigger(BuildContext context) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Input Toll Data'),
            content: Container(
              height: 150,
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: 'Input Amount'),
                    onChanged: (val) => amount = val,
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text('TopUp'),
                  onPressed: () {
                    fireData.updateAmount(amount);
                    Navigator.of(context).pop();
                  return true;
                  })
            ],
          );
        });
  }
}
