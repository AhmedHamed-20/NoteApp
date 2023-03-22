import 'package:notes/features/notes/models/notes_model.dart';
import 'package:notes/features/notes/repositories/base/notes_base_local_repository.dart';

final NotesModel tNotesModel = NotesModel(
  body: 'body',
  color: 'color',
  date: DateTime(2000, 1, 1),
  dataBaseId: 0,
  myId: 0,
  title: 'title',
);

const Map<String, dynamic> tNotesMap = {
  'dataBaseId': 0,
  'title': 'title',
  'body': 'body',
  'color': 'color',
  'date': '2000-01-01 00:00:00.000',
  'myId': 0,
};

const NoteAddingParams tNotesAddingParams = NoteAddingParams(
  myId: 0,
  noteBody: 'test',
  noteTitle: 'test',
  noteColor: 'test',
  noteDate: 'test',
  tableName: 'test',
);
const NoteUpdateParams tNotesUpdateParams = NoteUpdateParams(
    databaseId: 0,
    noteBody: 'test',
    noteColor: 'test',
    noteTitle: 'test',
    tableName: 'test');
