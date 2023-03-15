import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/error/failure.dart';

import '../../models/notes_model.dart';

abstract class BaseRemoteNotesRepository {
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      saveUserNotes(SaveUserNotesToFirestoreParams params);

  Future<Either<Failure, void>> updateNoteDate(UpdateNoteDateParams params);
  Future<Either<Failure, void>> deleteNoteData(DeleteNoteDataParams params);
  Future<Either<Failure, List<NotesModel>>> getNotesFromFirebase(
      GetNotesFromFirebaseParams params);
}

class SaveUserNotesToFirestoreParams extends Equatable {
  final NotesModel notesModel;
  final String userId;
  const SaveUserNotesToFirestoreParams({
    required this.notesModel,
    required this.userId,
  });

  @override
  List<Object?> get props => [notesModel, userId];
}

class UpdateNoteDateParams extends Equatable {
  final NotesModel note;
  final String userId;
  final String firebaseId;
  const UpdateNoteDateParams({
    required this.note,
    required this.userId,
    required this.firebaseId,
  });

  @override
  List<Object?> get props => [note, userId, firebaseId];
}

class DeleteNoteDataParams extends Equatable {
  final String userId;
  final String firebaseId;
  const DeleteNoteDataParams({
    required this.userId,
    required this.firebaseId,
  });

  @override
  List<Object?> get props => [userId, firebaseId];
}

class GetNotesFromFirebaseParams extends Equatable {
  final String userId;
  const GetNotesFromFirebaseParams({
    required this.userId,
  });

  @override
  List<Object?> get props => [userId];
}
