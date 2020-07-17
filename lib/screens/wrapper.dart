import 'package:belajarflutter/screens/authenticate/authenticate.dart';
import 'package:belajarflutter/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:belajarflutter/models/user.dart';


class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context); //panggil user id

    return (user == null) ? Authenticate() : Home();
  }
}