import 'package:belajarflutter/screens/drawer/drawer.dart';
import 'package:belajarflutter/screens/elektronik/new_alat.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:belajarflutter/models/alat.dart';
import 'package:belajarflutter/screens/elektronik/update_alat.dart';
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Electronics extends StatefulWidget {
  @override
  _ElectronicsState createState() => _ElectronicsState();
}

var uid;
final alatReference = FirebaseDatabase.instance.reference().child('alat');

class _ElectronicsState extends State<Electronics> with SingleTickerProviderStateMixin {
  bool isLoading = false;

  List<Alat> items;
  StreamSubscription<Event> _onNoteAddedSubscription;
  StreamSubscription<Event> _onNoteChangedSubscription;

  
  //Get User ID
  getUID() async {
    final FirebaseUser userw = await FirebaseAuth.instance.currentUser();
    final String uide = userw.uid.toString();
    setState(() {
      uid = uide;
    });
  }

  @override
  void initState() {
    super.initState();
     getUID();
     print(uid);
    items = new List();

    _onNoteAddedSubscription = alatReference.onChildAdded.listen(_onNoteAdded);
    _onNoteChangedSubscription = alatReference.onChildChanged.listen(_onNoteUpdated);
  }

  @override
  void dispose() {
    _onNoteAddedSubscription.cancel();
    _onNoteChangedSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Electronics", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black87,
      ),
      drawer: MyDrawer(),
      backgroundColor: Colors.grey[400],
      body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return 
                  ListTile(
                      title: Text(
                        '${items[position].title}',
                        style: TextStyle(color: Colors.black,fontSize: 26, fontWeight: FontWeight.w900),
                      ),
                      subtitle: Text(
                        '${items[position].description}',
                        style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w600),
                      ),
                      trailing: 
                          IconButton(
                            color: Colors.red,
                              icon: const Icon(Icons.delete),
                              onPressed: () => _deleteNote(context, items[position], position)),
                      onTap: () => _navigateToNote(context, items[position]),
                    );
                
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
    );
  }
  void _onNoteAdded(Event event) {
    setState(() {
      items.add(new Alat.fromSnapshot(event.snapshot));
    });
  }

  void _onNoteUpdated(Event event) {
    var oldNoteValue = items.singleWhere((alat) => alat.id == event.snapshot.key);
    setState(() {
      items[items.indexOf(oldNoteValue)] = new Alat.fromSnapshot(event.snapshot);
    });
  }

  void _deleteNote(BuildContext context, Alat alat, int position) async {
    await alatReference.child(alat.id).remove().then((_) {
      setState(() {
        items.removeAt(position);
      });
    });
  }

  void _navigateToNote(BuildContext context, Alat alat) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UpdateAlat(alat)),
    );
  }

  void _createNewNote(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewAlat(Alat(null, '', ''))),
    );
  }
}
