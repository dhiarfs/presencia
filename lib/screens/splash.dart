import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:presencia/screens/auth/login.dart';
import 'package:presencia/screens/home.dart';
import 'package:presencia/screens/style/color.dart';
import 'package:presencia/widgets/widgets.dart';
import 'package:presencia/main.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    AuthenticationWrapper();
    // _checkUserSementara(false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cGreen,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Presencia',
              style: TextStyle(
                  color: cWhite, fontSize: 36, fontWeight: FontWeight.w800),
            ),
            Text(
              'Modern Presence App',
              style: TextStyle(
                  color: cWhite, fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }

  void _checkUserSementara(bool user) async {
    await Future.delayed(Duration(seconds: 2));

    //navigator
    //Push & Push Replacement

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => user ? HomePage() : LoginPage(),
      ),
    );
  }
}

