import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/core/services/firestore_service/firestore_service.dart';
import 'package:notes/features/notes/models/notes_model.dart';
import 'package:notes/features/notes/repositories/base/notes_remote_repository.dart';

class NotesRemoteRepositoryImpl extends BaseRemoteNotesRepository {
  final FirestoreService _firestoreService;

  NotesRemoteRepositoryImpl(this._firestoreService);
  @override
  Future<Either<Failure, DocumentReference<Map<String, dynamic>>>>
      saveUserNotes(SaveUserNotesToFirestoreParams params) async {
    try {
      final result = await _firestoreService.saveUserNotes(
          notesModel: params.notesModel, userId: params.userId);
      return Right(result);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNoteDate(
      UpdateNoteDateParams params) async {
    try {
      await _firestoreService.updateNoteDate(
          note: params.note,
          userId: params.userId,
          firebaseId: params.firebaseId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNoteData(
      DeleteNoteDataParams params) async {
    try {
      await _firestoreService.removeNote(
          userId: params.userId, firebaseId: params.firebaseId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotesModel>>> getNotesFromFirebase(
      GetNotesFromFirebaseParams params) async {
    try {
      final result =
          await _firestoreService.getNotesFromFirebase(userId: params.userId);
      return Right(result.docs
          .map((e) => NotesModel.fromMap(map: e.data(), isFromFirebase: true))
          .toList());
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
