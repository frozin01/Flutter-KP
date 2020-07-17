import 'package:belajarflutter/screens/elektronik/electronics.dart';
import 'package:belajarflutter/screens/lapor/laporan.dart';
import 'package:belajarflutter/screens/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:belajarflutter/screens/home/home.dart';
import 'package:belajarflutter/services/auth_services.dart';
import 'package:belajarflutter/screens/loading.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final AuthServices _auth = AuthServices(); //class dari auth_services.dart buat panggil signOut
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : SizedBox(
      width: MediaQuery.of(context).size.width * 0.7,
      child: Drawer(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
          ),

          //Home
          ListTile(
            leading: Icon(
              Icons.home,
              size: 30,
            ),
            title: Text(
              "Home",
              style: TextStyle(fontSize: 25),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Home();
              }));
            },
          ),

          //Electronics
          ListTile(
            leading: Icon(
              Icons.power,
              size: 30,
            ),
            title: Text(
              "Electronics",
              style: TextStyle(fontSize: 25),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Electronics();
              }));
            },
          ),

          //Lapor
          ListTile(
            leading: Icon(
              Icons.speaker_notes,
              size: 30,
            ),
            title: Text(
              "Lapor",
              style: TextStyle(fontSize: 25),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Laporan();
              }));
            },
          ),

          //Settings
          ListTile(
            leading: Icon(
              Icons.settings,
              size: 30,
            ),
            title: Text(
              "Settings",
              style: TextStyle(fontSize: 25),
            ),
            trailing: Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                return Settings();
              }));
            },
          ),

          //Logout
          Divider(),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ListTile(
                leading: Icon(
                  Icons.exit_to_app,
                  size: 30,
                ),
                title: Text(
                  "Logout",
                  style: TextStyle(fontSize: 25),
                ),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () async {
                  setState(() => loading = true);
                  await _auth.signOut();
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
