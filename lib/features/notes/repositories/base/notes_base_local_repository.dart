import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/features/notes/models/notes_model.dart';

abstract class NotesBaseLocalRepository {
  Future<Either<Failure, List<NotesModel>>> getNotes(NotesGetParams params);
  Future<Either<Failure, void>> addNote(NoteAddingParams params);
  Future<Either<Failure, void>> updateNote(NoteUpdateParams params);
  Future<Either<Failure, void>> deleteNoteById(NoteDeleteParams params);
  Future<Either<Failure, bool>> getActiceTheme(ActiveThemeParams params);
  Future<Either<Failure, void>> setActiveTheme(ActiveThemeSetParams params);
}

class ActiveThemeParams extends Equatable {
  final String key;
  const ActiveThemeParams(this.key);
  @override
  List<Object?> get props => [key];
}

class ActiveThemeSetParams extends Equatable {
  final String key;
  final bool value;
  const ActiveThemeSetParams(this.key, this.value);
  @override
  List<Object?> get props => [key, value];
}

class NotesGetParams extends Equatable {
  final String tableName;
  const NotesGetParams(this.tableName);

  @override
  List<Object?> get props => [tableName];
}

class NoteAddingParams extends Equatable {
  final String tableName;
  final String noteTitle;
  final String noteBody;
  final String noteColor;
  final String noteDate;
  final int myId;
  const NoteAddingParams({
    required this.tableName,
    required this.noteTitle,
    required this.noteColor,
    required this.noteDate,
    required this.noteBody,
    required this.myId,
  });

  @override
  List<Object?> get props =>
      [tableName, noteTitle, noteBody, noteColor, noteDate, myId];
}

class NoteUpdateParams extends Equatable {
  final int databaseId;
  final String tableName;
  final String noteTitle;
  final String noteBody;
  final String noteColor;
  const NoteUpdateParams(
      {required this.databaseId,
      required this.tableName,
      required this.noteTitle,
      required this.noteBody,
      required this.noteColor});

  @override
  List<Object?> get props => [
        databaseId,
        tableName,
        noteBody,
        noteColor,
        noteTitle,
      ];
}

class NoteDeleteParams extends Equatable {
  final int databaseId;
  final String tableName;

  const NoteDeleteParams(
    this.databaseId,
    this.tableName,
  );

  @override
  List<Object?> get props => [
        databaseId,
        tableName,
      ];
}
