import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/features/notes/models/notes_model.dart';

class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<DocumentReference<Map<String, dynamic>>> saveUserNotes({
    required NotesModel notesModel,
    required String userId,
  }) async {
    if (await InternetConnectionChecker().hasConnection) {
      return await _firestore
          .collection(AppStrings.collectionUsers)
          .doc(userId)
          .collection(AppStrings.collectionNotes)
          .add(notesModel.toMap());
    } else {
      return _firestore
          .collection(AppStrings.collectionUsers)
          .doc(userId)
          .collection(AppStrings.collectionNotes)
          .add(notesModel.toMap());
    }
  }

  Future<void> updateNoteDate(
      {required NotesModel note,
      required String userId,
      required String firebaseId}) async {
    if (await InternetConnectionChecker().hasConnection) {
      return await _firestore
          .collection(AppStrings.collectionUsers)
          .doc(userId)
          .collection(AppStrings.collectionNotes)
          .doc(firebaseId)
          .update(note.toMap());
    } else {
      return _firestore
          .collection(AppStrings.collectionUsers)
          .doc(userId)
          .collection(AppStrings.collectionNotes)
          .doc(firebaseId)
          .update(note.toMap());
    }
  }

  Future<void> removeNote(
      {required String userId, required String firebaseId}) async {
    if (await InternetConnectionChecker().hasConnection) {
      return await _firestore
          .collection(AppStrings.collectionUsers)
          .doc(userId)
          .collection(AppStrings.collectionNotes)
          .doc(firebaseId)
          .delete();
    } else {
      return _firestore
          .collection(AppStrings.collectionUsers)
          .doc(userId)
          .collection(AppStrings.collectionNotes)
          .doc(firebaseId)
          .delete();
    }
  }
}