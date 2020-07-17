import 'dart:ui';
import 'package:belajarflutter/screens/loading.dart';
import 'package:belajarflutter/services/auth_services.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {

  final Function toggleView;
  SignUp({this.toggleView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthServices _auth = AuthServices();//class dari auth_services.dart buat panggil signUp
  TextEditingController emailController = TextEditingController(text: "");//initial state kosong dari form email
  TextEditingController passwordController = TextEditingController(text: "");//initial state kosong dari form password
  String error ='';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      body: Container(
        decoration: BoxDecoration(color: Colors.grey[400]),
        child: ListView(
          padding: EdgeInsets.all(0),
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 120),
                ),
                Text(
                  "Register to Smart",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900),
                ),
                Text(
                  "Housemaid",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900),
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
                        Padding(
                          padding: EdgeInsets.all(10),
                        ),
                        SizedBox(
                          width: 190,
                          height: 50,
                          child: RaisedButton(
                            color: Colors.grey[500],
                            child: Text(
                              "REGISTER",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w900),
                            ),
                            onPressed: () async {
                              setState(() => loading = true);
                              dynamic result = await _auth.signUp(emailController.text,
                                  passwordController.text);
                              if (result == null) { //isi email dan password tidak benar
                                setState(() {
                                  loading = false;
                                  error = 'Please supply a valid email and password';
                                });
                              }
                            },
                          ),
                        ),
                        SizedBox(height: 12),
                        Text(error, style: TextStyle(color: Colors.red, fontSize: 14),),
                        SizedBox(height: 12),
                        RaisedButton(
                         color: Colors.grey[500],
                            child: Text(
                              "BACK",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w900),
                            ),
                            onPressed: () => widget.toggleView(), //panggil void toogleView()
                        ),
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
