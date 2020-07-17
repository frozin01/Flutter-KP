import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:belajarflutter/models/alat.dart';

class UpdateAlat extends StatefulWidget {
  final Alat alat;
  UpdateAlat(this.alat);

  @override
  State<StatefulWidget> createState() => new _UpdateAlatState();
}

final alatReference = FirebaseDatabase.instance.reference().child('alat');

class _UpdateAlatState extends State<UpdateAlat> {
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
        title: Text("Update Alat"),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                    child: Text('ON'),
                    onPressed: () {
                      alatReference.child(widget.alat.id).set({
                        'title': _titleController.text,
                        'description': 'ON'
                      }).then((_) {
                    Navigator.pop(context);
                  });
                    }),
                RaisedButton(
                    child: Text('OFF'),
                    onPressed: () {
                      alatReference.child(widget.alat.id).set({
                        'title': _titleController.text,
                        'description': 'OFF'
                      }).then((_) {
                    Navigator.pop(context);
                  });
                    }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
