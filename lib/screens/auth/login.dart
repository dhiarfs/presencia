import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:presencia/screens/auth/register.dart';
import 'package:presencia/screens/style/color.dart';
import 'authentication_services.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Widget _authTitle() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 150),
      padding: EdgeInsets.only(bottom: 48),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hey,',
            style: TextStyle(
                fontSize: 36, color: cGreen, fontWeight: FontWeight.w800),
          ),
          Text(
            'Login Now!',
            style: TextStyle(
                fontSize: 36, color: cGreen, fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }

  Widget _inputEmail() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: emailController,
        style: TextStyle(color: cGrey, fontWeight: FontWeight.w500),
        cursorColor: cGrey,
        decoration: InputDecoration(
          filled: true,
          hintText: 'E-Mail',
          hintStyle: TextStyle(
              fontSize: 16, color: cGrey, fontWeight: FontWeight.w500),
          fillColor: cLightGrey,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _inputPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: passwordController,
        style: TextStyle(color: cGrey, fontWeight: FontWeight.w500),
        cursorColor: cGrey,
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Password',
          hintStyle: TextStyle(
              fontSize: 16, color: cGrey, fontWeight: FontWeight.w500),
          fillColor: cLightGrey,
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget _buttonLogin() {
    return RaisedButton(
      color: cGreen,
      onPressed: () {
        context.read<AuthenticationService>().signIn(
              email: emailController.text.trim(),
              password: passwordController.text.trim(),
            );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: 50,
        width: 295,
        child: Center(
          child: Text(
            'LOGIN',
            style: TextStyle(
                color: cWhite, fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Widget _textRegister() {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Dont have an account yet ? '),
          GestureDetector(
            child: Container(
              padding: EdgeInsets.all(1),
              color: Colors.transparent,
              child: Text(
                'Register',
                style: TextStyle(color: cGreen, fontWeight: FontWeight.w800),
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RegisterPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 32),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _authTitle(),
              _inputEmail(),
              SizedBox(height: 18),
              _inputPassword(),
              SizedBox(height: 32),
              _buttonLogin(),
              _textRegister()
            ],
          ),
        ),
      ),
    );
  }
}
