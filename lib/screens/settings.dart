import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tollpay/services/auth.dart';
import 'package:tollpay/services/database.dart';
import 'package:tollpay/shared/user.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  Settings({Key key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool notifications = false;
  String username= 'user';

  var uid = User();
 
  File profilePic;

  DatabaseMethods data = new DatabaseMethods();
  

  Future getImage() async {
    var profileImage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      profilePic = profileImage;
      dynamic result = uploadPhoto(context);
      if (result == true) {
        setState(() {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
            'Picture has been uploaded successfully',
            style: TextStyle(color: Colors.green),
          )));
        });
      } else {
        setState(() {
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text(
            'Picture upload failed',
            style: TextStyle(color: Colors.red),
          )));
        });
      }
    });
  }

  Future<String> createAlertDialog(BuildContext context) {
    TextEditingController userName = TextEditingController();

    return showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Change Name!'),
            content: TextField(
              controller: userName,
              //   onChanged: (val) => username = val,
            ),
            actions: <Widget>[
              MaterialButton(
                  child: Text('submit'),
                  onPressed: () {
                    Navigator.of(context).pop(userName.text.toString());
                  })
            ],
          );
        });
  }

  Future uploadPhoto(BuildContext context) async {
    StorageReference firebaseProfPic =
        FirebaseStorage.instance.ref().child('profilepics/${uid.toString()}.jpg');
    StorageUploadTask uploadTask = firebaseProfPic.putFile(profilePic);
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    if(taskSnapshot != null){
    print('successful');
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
  

    return Scaffold(
      body: ListView(
        children: <Widget>[
          new Container(
            height: 250.0,
            color: Colors.indigo,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                          image: (profilePic != null)
                              ? Image.file(
                                  profilePic,
                                  fit: BoxFit.fill,
                                )
                              : AssetImage('assets/profile.png'),
                          fit: BoxFit.fill),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                  child: GestureDetector(
                    onTap: () {
                      getImage();
                    },
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
               username,
                  style: TextStyle(
                      // fontFamily: 'Pacifico',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Container(
                  height: 30.0,
                  width: 95.0,
                  child: Material(
                    borderRadius: BorderRadius.circular(20.0),
                    shadowColor: Colors.black,
                    color: Colors.indigo,
                    elevation: 7.0,
                    child: GestureDetector(
                      onTap: () async {
                        createAlertDialog(context).then((onValue) {
                          setState(() {
                            this.username = onValue;
                            data.updateUserName(username);
                          });
                        });
                      },
                      child: Center(
                        child: Text(
                          'Edit Name',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'Pacofico'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SwitchListTile(
            title: Text('Notifications'),
            value: notifications,
            onChanged: (bool value) {
              setState(() {
                notifications = value;
                if (notifications == true) {
                  print('enable notifications');
                } else {
                  print('disable notifications');
                }
              });
            },
            secondary: const Icon(Icons.notifications),
          ),
          ListTile(
            leading: Icon(Icons.phone),
            title: Text('Contact Us'),
            onTap: () => launch("tel://0973288957"),
          ),
          ListTile(
            leading: Icon(Icons.arrow_back),
            title: Text('Sign Out'),
            onTap: () {
              AuthService().signOut();
            },
          )
        ],
      ),
    );
  }
}
