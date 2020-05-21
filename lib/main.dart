import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tollpay/screens/dashboard.dart';
import 'package:tollpay/screens/loading.dart';
import 'package:tollpay/screens/login.dart';
import 'package:tollpay/screens/payments.dart';
import 'package:tollpay/services/auth.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
       home: AuthService().handleAuth(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/dashboard': (BuildContext context) => new Dashboard(),
        '/loading': (BuildContext context) => new Loading(),
        // '/profile': (BuildContext context) => new Profile(),
        '/payments': (BuildContext context) => new Payments()
      },
    );
  }
}
