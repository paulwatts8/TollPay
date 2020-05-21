import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tollpay/services/auth.dart';
import 'package:tollpay/shared/header.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String phoneNum, verificationId, smsCode;
  bool codeSent = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.fromLTRB(0.0, 120.0, 0.0, 0.0),
              child: Column(
                children: <Widget>[
                  Text(
                    'Toll',
                    style: headerstyle,
                  ),
                  Text('Pay!', style: headerstyle)
                ],
              )),
          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
            child: Column(
              children: <Widget>[
                codeSent
                    ? TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (val) {
                          setState(() => phoneNum = val);
                        },
                        decoration:
                            textDecoration.copyWith(labelText: 'Enter OTP'))
                    : TextField(
                        keyboardType: TextInputType.phone,
                        onChanged: (val) {
                          setState(() => phoneNum = val);
                        },
                        decoration:
                            textDecoration.copyWith(labelText: 'Phone Number')),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: 60.0,
                  height: 60.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(50.0),
                    elevation: 7.0,
                    color: Colors.indigo[600],
                    child: GestureDetector(
                      onTap: () async {
                        try {
                          codeSent
                              ? AuthService()
                                  .signInWithOTP(smsCode, verificationId)
                              : verifyPhone(phoneNum);
                        } catch (e) {
                          print('login screen error $e');
                        }
                      },
                      child: Center(
                          child: Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                      )),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  //Firebase phone signin
  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult);
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeOut = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: const Duration(seconds: 10),
        verificationCompleted: verified,
        verificationFailed: verificationFailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeOut);
  }
}
