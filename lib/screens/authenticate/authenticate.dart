import 'package:flutter/material.dart';
import 'package:belajarflutter/screens/authenticate/sign_in.dart';
import 'package:belajarflutter/screens/authenticate/sign_up.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){ //buat kondisi tampilan authenticate
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn){
      return SignIn(toggleView: toggleView); //shoSignIn true maka dipanggil SignIn
    }else{
      return SignUp(toggleView: toggleView);//shoSignIn false maka dipanggil SignUp
    }
  }
}