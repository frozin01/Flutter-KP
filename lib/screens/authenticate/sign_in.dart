import 'dart:ui';
import 'package:belajarflutter/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:belajarflutter/screens/loading.dart';
import 'package:belajarflutter/screens/authenticate/forgot_password.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthServices _auth = AuthServices(); //class dari auth_services.dart buat panggil signIn
  TextEditingController emailController = TextEditingController(text: "");//initial state kosong dari form email
  TextEditingController passwordController = TextEditingController(text: "");//initial state kosong dari form password
  String error = '';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: Container(
              decoration: BoxDecoration(color: Colors.grey[400]),
              child: ListView(
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 120),
                      ),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Let's welcome the future with:",
                              style: TextStyle(
                                  fontStyle: FontStyle.italic,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900),
                            ),
                            Text(
                              "Smart Housemaid",
                              style: TextStyle(
                                  fontFamily: "Aguellera",
                                  fontSize: 60,
                                  fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 100),
                      ),
                      Container(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: InputDecoration(
                                    fillColor: Colors.grey[500],
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.email,
                                      color: Colors.black,
                                    ),
                                    hintText: "Email",
                                    hintStyle: TextStyle(color: Colors.black45),
                                    border: InputBorder.none),
                                controller: emailController,
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              TextFormField(
                                obscureText: true,
                                decoration: InputDecoration(
                                    fillColor: Colors.grey[500],
                                    filled: true,
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: Colors.black,
                                    ),
                                    hintText: "Password",
                                    hintStyle: TextStyle(color: Colors.black45),
                                    border: InputBorder.none),
                                controller: passwordController,
                              ),
                              FlatButton(
                                child: Text("Forgot Password?"),
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ForgotPassword();
                                  }));
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.all(10),
                              ),
                              SizedBox(
                                width: 190,
                                height: 50,
                                child: RaisedButton(
                                  color: Colors.grey[500],
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  onPressed: () async {
                                    setState(() => loading = true);
                                    dynamic result = await _auth.signIn(
                                        emailController.text,
                                        passwordController.text);
                                    if (result == null) { //isi email dan password tidak benar
                                      setState(() {
                                        loading = false;
                                        error =
                                            'Please supply a valid email and password';
                                      });
                                    }
                                  },
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                error,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text("Don't have an account?"),
                                  FlatButton(
                                    child: Text("Register here"),
                                    onPressed: () => widget.toggleView(), //panggil void toogleView()
                                  ),
                                ],
                              )
                            ],
                          ))
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
