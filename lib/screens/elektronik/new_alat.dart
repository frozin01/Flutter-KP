import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:belajarflutter/models/alat.dart';

class NewAlat extends StatefulWidget {
  final Alat alat;
  NewAlat(this.alat);

  @override
  State<StatefulWidget> createState() => new _NewAlatState();
}

final alatReference = FirebaseDatabase.instance.reference().child('alat');

class _NewAlatState extends State<NewAlat> {
  TextEditingController _titleController;

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.alat.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah Alat"),
        backgroundColor: Colors.black87,
      ),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            RaisedButton(
              child: Text('Add'),
              onPressed: () {
                alatReference.push().set({
                  'title': _titleController.text,
                  'description': ''
                }).then((_) {
                  Navigator.pop(context);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
