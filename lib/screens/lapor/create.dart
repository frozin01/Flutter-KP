import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BuatLaporan extends StatefulWidget {
  @override
  _BuatLaporanState createState() => _BuatLaporanState();
}

class _BuatLaporanState extends State<BuatLaporan> {
  String uid;
  final title = TextEditingController();
  final body = TextEditingController();

  @override
  void initState() {
    getUID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Firestore.instance
                .collection('userData')
                .document(uid)
                .collection('laporan')
                .document()
                .setData({'title': title.text, 'body': body.text}).then((_) {
              Navigator.pop(context);
            });
          },
          child: Icon(Icons.check),
        ),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            color: Colors.black,
            height: 80,
          ),
        ),
        backgroundColor: Color(0xff121212),
        appBar: AppBar(
          title: Text("Buat Laporan"),
          backgroundColor: Colors.black,
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(9)),
                          color: Color(0xa1ffffff)),
                      child: TextField(
                        controller: title,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                            fillColor: Colors.white,
                            focusColor: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(9)),
                        color: Color(0xa1ffffff),
                      ),
                      child: TextField(
                        maxLines: 5,
                        controller: body,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Body',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  //get User ID
  getUID() async {
    final FirebaseUser userw = await FirebaseAuth.instance.currentUser();
    final String uide = userw.uid.toString();
    setState(() {
      uid = uide;
    });
  }
}
