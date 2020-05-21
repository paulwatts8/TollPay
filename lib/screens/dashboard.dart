import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tollpay/screens/payments.dart';
import 'package:tollpay/screens/settings.dart';
import 'package:tollpay/screens/tolldash.dart';
import 'package:tollpay/services/database.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key key, FirebaseUser user}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _selectedIndex = 0;
  final _children = [TollDash(), Settings()];
  QuerySnapshot toll;

  DatabaseMethods fireData = new DatabaseMethods();
  Payments payment = new Payments();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    fireData.getToll().then((results) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            // payment.dialogTrigger(context);
            Navigator.of(context).pushNamed('/payments');
          },
          backgroundColor: Colors.indigo[900],
          child: Icon(Icons.payment),
        ),
        bottomNavigationBar: BottomNavigationBar(
          elevation: 10.0,
          backgroundColor: Colors.indigoAccent[600],
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard), title: Text('Dashboard')),
            BottomNavigationBarItem(
                backgroundColor: Colors.indigoAccent,
                icon: Icon(Icons.settings),
                title: Text('Settings')),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent[600],
          onTap: _onItemTapped,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: _children[_selectedIndex],
      ),
    );
  }
}
