import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tollpay/screens/dashboard.dart';
import 'package:tollpay/screens/login.dart';
import 'package:tollpay/services/database.dart';
import 'package:tollpay/shared/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  

  //setting the uid for current user
   User _firebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //checking if user has already logged in
  handleAuth() {
    return StreamBuilder(
        stream: _auth.onAuthStateChanged,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return Dashboard();
          } else {
            return Login();
          }
        });
  }

  //phone sign in
  signIn(AuthCredential authCreds) async {
    try {
      AuthResult result = await _auth.signInWithCredential(authCreds);
      FirebaseUser user = result.user;

      //creates database for user
      DatabaseMethods(uid: user.uid)
          .updateUser('username', user.phoneNumber, null);

          DatabaseMethods(uid: user.uid).fireAmount('0.00');

      return _firebaseUser(user);
    } catch (e) {
      print('Log in error: $e');
    }
  }

  //verifying the OTP
  signInWithOTP(smsCode, verId) {
    AuthCredential authCreds = PhoneAuthProvider.getCredential(
        verificationId: verId, smsCode: smsCode);
    signIn(authCreds);
  }

  //signout
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print('Sign out failed');
      print(e);
    }
  }
}
