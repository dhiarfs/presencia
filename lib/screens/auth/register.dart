import 'package:flutter/material.dart';
import 'package:presencia/screens/auth/authentication_services.dart';
import 'package:presencia/screens/auth/login.dart';
import 'package:presencia/screens/home.dart';
import 'package:presencia/screens/style/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  bool _isLoading = false;

  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // GlobalKey
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            'Register Now!',
            style: TextStyle(
                fontSize: 36, color: cGreen, fontWeight: FontWeight.w800),
          )
        ],
      ),
    );
  }

  Widget _inputNama() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        controller: namaController,
        style: TextStyle(color: cGrey, fontWeight: FontWeight.w500),
        cursorColor: cGrey,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Nama Lengkap',
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

  Widget _inputConfirmPassword() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        style: TextStyle(color: cGrey, fontWeight: FontWeight.w500),
        cursorColor: cGrey,
        obscureText: true,
        decoration: InputDecoration(
          filled: true,
          hintText: 'Confirm Password',
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

  Widget _buttonRegister() {
    return RaisedButton(
      color: cGreen,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Container(
        height: 50,
        width: 295,
        child: Center(
          child: Text(
            'Register',
            style: TextStyle(
                color: cWhite, fontSize: 18, fontWeight: FontWeight.w800),
          ),
        ),
      ),
      onPressed: () async {
        if (_formKey.currentState.validate()) {
          setState(() => _isLoading = true);
          try {
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);
            await context
                .read<AuthenticationService>()
                .addUserToDB(
                  uid: auth.currentUser.uid,
                  namalengkap: namaController.text,
                  email: emailController.text,
                  password: passwordController.text,
                )
                .then((value) => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => HomePage())));
          } on FirebaseAuthException catch (e) {
            setState(() => _isLoading = false);
            final snackbar = SnackBar(content: Text(e.message));
            _scaffoldKey.currentState.showSnackBar(snackbar);
          }
        }
      },
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
              _inputNama(),
              SizedBox(height: 18),
              _inputEmail(),
              SizedBox(height: 18),
              _inputPassword(),
              SizedBox(height: 18),
              // _inputConfirmPassword(),
              SizedBox(height: 32),
              _buttonRegister(),
            ],
          ),
        ),
      ),
    );
  }
}
