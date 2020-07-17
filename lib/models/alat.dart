import 'package:firebase_database/firebase_database.dart';

class Alat {
  String _id;
  String _title;
  String _description;

  Alat(this._id, this._title, this._description);

  Alat.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
  }

  String get id => _id;
  String get title => _title;
  String get description => _description;

  Alat.fromSnapshot(DataSnapshot snapshot) {
    _id = snapshot.key;
    _title = snapshot.value['title'];
    _description = snapshot.value['description'];
  }
}
