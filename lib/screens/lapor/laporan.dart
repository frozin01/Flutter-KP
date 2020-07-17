import 'package:belajarflutter/screens/drawer/drawer.dart';
import 'package:belajarflutter/screens/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:belajarflutter/screens/lapor/create.dart';
import 'package:firebase_auth/firebase_auth.dart';


class Laporan extends StatefulWidget {
  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  String id;
  String uid;

  @override
  void initState() {
    getUID();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return BuatLaporan();
          }));
        },
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          color: Colors.black87,
          height: 50,
        ),
      ),
      appBar: AppBar(
        title: Text("Laporan"),
        backgroundColor: Colors.black87,
      ),
      drawer: MyDrawer(),
      body: StreamBuilder<QuerySnapshot>(
        stream: Firestore.instance
            .collection('userData')
            .document(uid)
            .collection('laporan')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return new Loading();
            default:
              return new ListView(
                children:
                    snapshot.data.documents.map((DocumentSnapshot document) {
                  return ListTile(
                      title: new Text(
                        document['title'],
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.w900),
                      ),
                      subtitle: new Text(
                        document['body'],
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing:     
                          IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () => deleteData(document),
                          ),
                        );
                }).toList(),
              );
          }
        },
      ),
    );
  }

  //Get User ID
  getUID() async {
    final FirebaseUser userw = await FirebaseAuth.instance.currentUser();
    final String uide = userw.uid.toString();
    setState(() {
      uid = uide;
    });
  }
  
  //delete data
  void deleteData(DocumentSnapshot document) async {
    await Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('laporan')
        .document(document.documentID)
        .delete();
    setState(() => id = null);
  }
}
