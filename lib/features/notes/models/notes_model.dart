// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

//CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT, Color TEXT,time TEXT
class NotesModel extends Equatable {
  final int? dataBaseId;
  final int myId;
  final String title;
  final String body;
  final DateTime date;
  final String color;

  const NotesModel({
    required this.color,
    this.dataBaseId,
    required this.title,
    required this.myId,
    required this.body,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'dataBaseId': dataBaseId,
      'title': title,
      'myId': myId,
      'body': body,
      'date': date,
      'color': color,
    };
  }

  static Map<String, dynamic> toDataBaseMap(NotesModel notesModel) {
    return <String, dynamic>{
      'dataBaseId': notesModel.dataBaseId,
      'title': notesModel.title,
      'myId': notesModel.myId,
      'body': notesModel.body,
      'date': notesModel.date.toString(),
      'color': notesModel.color,
    };
  }

  factory NotesModel.fromMap(
      {required Map<String, dynamic> map, bool? isFromFirebase = false}) {
    return NotesModel(
      dataBaseId: map['dataBaseId'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      myId: map['myId'] as int,
      date: isFromFirebase == true
          ? (map['date'] as Timestamp).toDate()
          : DateTime.parse(map['date'] as String),
      color: map['color'] as String,
    );
  }

  @override
  List<Object?> get props => [dataBaseId, title, body, date, color, myId];
}
