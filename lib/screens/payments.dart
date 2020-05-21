import 'package:flutter/material.dart';
import 'package:tollpay/shared/header.dart';

class Payments extends StatefulWidget {
  Payments({Key key}) : super(key: key);

  @override
  _PaymentsState createState() => _PaymentsState();
}

class _PaymentsState extends State<Payments> {
  String tollNum, plateNumber, amount;
  String _valToll;

  List<String> tolls = [
    'NDLKTW(Ndola to Kitwe)',
    'KTWNDL(Kitwe to Ndl)',
    'KTWCHG(Kitwe To Chingola)'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Padding(
          padding: EdgeInsets.fromLTRB(90.0, 0.0, 0.0, 0.0),
          child: Text('Payments')),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              "Input Toll Data below",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
            ),
            SizedBox(
              height: 100.0,
            ),
            DropdownButton(
                hint: Text('Select the Toll Gate'),
                value: _valToll,
                items: tolls.map((value) {
                  return new DropdownMenuItem(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _valToll = value;
                  });
                }),
            SizedBox(height: 20.0),
            TextField(
              decoration: textDecoration.copyWith(
                labelText: 'Input Plate Number',
              ),
              onChanged: (val) => plateNumber = val,
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: textDecoration.copyWith(labelText: 'Input Amount'),
              onChanged: (val) => amount = val,
            ),
            SizedBox(
              height: 60.0,
            ),
             Container(
               width: 90,
                  height: 60.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    elevation: 7.0,
                    color: Colors.indigo[600],
                    child: GestureDetector(
                      
                      onTap: () async {
                                           },
                      child: Center(
                        child: Text(
                          'SUBMIT',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
