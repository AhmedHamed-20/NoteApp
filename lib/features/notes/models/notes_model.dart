// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

//CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT, Color TEXT,time TEXT
class NotesModel extends Equatable {
  final int? id;
  final String title;
  final String body;
  final DateTime date;
  final String color;

  const NotesModel({
    required this.color,
    this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'body': body,
      'date': date.millisecondsSinceEpoch,
      'color': color,
    };
  }

  factory NotesModel.fromMap(Map<String, dynamic> map) {
    return NotesModel(
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
      date: DateTime.parse(map['time'] as String),
      color: map['color'] as String,
    );
  }

  factory NotesModel.fromJson(String source) =>
      NotesModel.fromMap(json.decode(source) as Map<String, dynamic>);
  @override
  List<Object?> get props => [id, title, body, date, color];
}
