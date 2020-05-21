import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  final String uid;
  DatabaseMethods({this.uid});

  //collecting the firebase collections
  CollectionReference userData = Firestore.instance.collection('Users');
  CollectionReference tollData = Firestore.instance.collection('Toll');
  CollectionReference amountData = Firestore.instance.collection('Amount');

  //updating Users Amount
  Future fireAmount(String amount) async {
    try {
      amountData.document(uid).setData({
        'Amount': amount,
      });
      return true;
    } catch (e) {
      print('updating payment error $e');
      return false;
    }
  }

  //adding user data
  Future updateUser(
      String username, String phoneNumber, String photoURL) async {
    return await userData.document(uid).setData({
      'username': username,
      'phoneNumber': phoneNumber,
      'photoUrl': photoURL,
      'uid': uid
    }).catchError((e) {
      print('updating user error $e');
    });
  }

  //updating userName
  Future updateUserName(String username) async {
    await userData
        .document(uid)
        .setData({'username': username}).catchError((e) {
      print('unable to update user: $e');
    });
  }

  //check if user is loged in
  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  //adding data to firestore
  Future<void> addData(tollData) async {
    if (isLoggedIn()) {
      tollData.add(tollData).catchError((e) {
        print('error retrieving data');
        print('error code $e');
      });
    } else {
      print('user needs to be logged in');
    }
  }

  //updating amount
  Future updateAmount(String newAmount) async {
    return await amountData.document(uid).updateData({
      'Amount': newAmount,
    }).catchError((e) {
      print('updating user error $e');
    });
  }

//get data from Firestore
  getToll() async {
    return tollData.snapshots();
  }

  //get user amount
  getAmount() async {
    return amountData.snapshots();
  }
}
