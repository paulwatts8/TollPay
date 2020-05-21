import 'package:flutter/material.dart';
import 'package:tollpay/shared/amount.dart';
import 'package:tollpay/shared/dashlist.dart';
import 'package:tollpay/shared/topup.dart';

class TollDash extends StatefulWidget {
  @override
  _TollDashState createState() => _TollDashState();
}

class _TollDashState extends State<TollDash> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.indigoAccent,
          ),
          height: 130.0,
          child: Row(
            children: <Widget>[
              SizedBox(
                width: 15.0,
              ),
              Amount(),
              Spacer(),
              Container(
                height: 30.0,
                width: 95.0,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.black,
                  color: Colors.white,
                  elevation: 7.0,
                  child: GestureDetector(
                    onTap: () {
                      TopUp().dialogTrigger(context);
                    },
                    child: Center(
                      child: Text(
                        'Top Up',
                        style: TextStyle(
                            color: Colors.indigo,
                            fontFamily: 'Pacofico',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: DashList(),
        )
      ],
    );
  }
}
