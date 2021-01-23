import 'package:flutter/material.dart';
import 'package:presencia/screens/auth/authentication_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text('Home'),
            RaisedButton(
              onPressed: () {
                context.read<AuthenticationService>().signOut();
              },
            ),
          ],
        ),
      ),
    );
  }
}
