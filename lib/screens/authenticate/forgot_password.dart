import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:belajarflutter/screens/loading.dart';
import 'package:belajarflutter/services/auth_services.dart';

class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  
  final AuthServices _auth = AuthServices();//class dari auth_services.dart buat panggil forgotPassword
  TextEditingController emailController = TextEditingController(text: "");//initial state kosong dari form email
  String notif = '';
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 120),
                      ),
                      Text(
                        "Reset Password",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w900),
                      ),
                      Text(
                        "Smart Housemaid",
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.w900),
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
                              SizedBox(
                                width: 190,
                                height: 50,
                                child: RaisedButton(
                                  color: Colors.grey[500],
                                  child: Text(
                                    "SUBMIT",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900),
                                  ),
                                  onPressed: () async {
                                    await _auth.forgotPassword(
                                        emailController.text);
                                    setState(() {
                                      loading = false;
                                      notif =
                                          "A password reset link has been sent to ${emailController.text}"; //munculin notif
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                notif,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                              ),
                              SizedBox(height: 12),
                              RaisedButton(
                                color: Colors.grey[500],
                                child: Text(
                                  "BACK",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w900),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
