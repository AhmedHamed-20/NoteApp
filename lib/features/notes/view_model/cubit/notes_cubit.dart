import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/theme/app_theme.dart';
import 'package:notes/core/utls/utls.dart';
import 'package:notes/features/notes/repositories/base/notes_base_local_repository.dart';
import 'package:notes/features/notes/repositories/base/notes_remote_repository.dart';

import '../../../../core/services/service_locator.dart';
import '../../models/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NoteState> {
  NotesCubit(this.notesBaseRepository, this.baseRemoteNotesRepository)
      : super(const NoteState());

  final NotesBaseLocalRepository notesBaseRepository;
  final BaseRemoteNotesRepository baseRemoteNotesRepository;
  void changeActiveColorIndex(int index) {
    emit(state.copyWith(activeColorIndex: index));
  }

  void resetStatus() {
    emit(
      state.copyWith(
        notesAddStatus: AddNotesRequestStatus.loading,
        notesDeleteStatus: DeleteNotesByIdRequestStatus.loading,
        notesUpdateStatus: UpdateNotesRequestStatus.loading,
      ),
    );
  }

  Future<void> getNotes() async {
    final result = await notesBaseRepository
        .getNotes(const NotesGetParams(AppStrings.tableName));
    result.fold((l) {
      emit(state.copyWith(
          notesStatus: GetNotesRequestStatus.failure, errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          notesStatus: GetNotesRequestStatus.success,
          notes: r,
          errorMessage: ''));
    });
  }

  Future<void> deleteNoteFromDatabaseById(int databaseId, int myId) async {
    final result = await notesBaseRepository
        .deleteNoteById(NoteDeleteParams(databaseId, AppStrings.tableName));
    result.fold((l) {
      emit(state.copyWith(
          notesDeleteStatus: DeleteNotesByIdRequestStatus.failure,
          errorMessage: l.message));
    }, (r) {
      deleteNoteFromFirebaseIfSignedInAndHaveInternet(myId);
      emit(
        state.copyWith(
            notesDeleteStatus: DeleteNotesByIdRequestStatus.success,
            errorMessage: ''),
      );
    });
  }

  Future<void> addNoteToDatabase({
    required String noteTitle,
    required String noteBody,
    required String noteColor,
    required String noteDate,
    int? myId,
  }) async {
    final result = await notesBaseRepository.addNote(NoteAddingParams(
        noteBody: noteBody,
        noteColor: noteColor,
        noteDate: noteDate,
        myId: myId ?? state.notes.length + 1,
        noteTitle: noteTitle,
        tableName: AppStrings.tableName));
    result.fold((l) {
      emit(state.copyWith(
          notesAddStatus: AddNotesRequestStatus.failure,
          errorMessage: l.message));
    }, (r) {
      saveNoteToFirebaseIfSignedIn(
        NotesModel(
          dataBaseId: state.notes.length + 1,
          color: noteColor,
          title: noteTitle,
          myId: state.notes.length + 1,
          body: noteBody,
          date: DateTime.parse(noteDate),
        ),
      );
      emit(state.copyWith(
          notesAddStatus: AddNotesRequestStatus.success, errorMessage: ''));
    });
  }

  Future<void> updateNoteToDatabase(
      {required String noteBody,
      required String noteColor,
      required String noteTitle,
      required int databaseId}) async {
    final result = await notesBaseRepository.updateNote(NoteUpdateParams(
        databaseId: databaseId,
        tableName: AppStrings.tableName,
        noteBody: noteBody,
        noteColor: noteColor,
        noteTitle: noteTitle));
    result.fold((l) {
      emit(state.copyWith(
          notesUpdateStatus: UpdateNotesRequestStatus.failure,
          errorMessage: l.message));
    }, (r) {
      updateNoteToFirebaseIfSignedInAndHaveInternet(
        NotesModel(
          dataBaseId: databaseId,
          color: noteColor,
          title: noteTitle,
          myId: state.notes[databaseId - 1].myId,
          body: noteBody,
          date: state.notes[databaseId - 1].date,
        ),
      );
      emit(state.copyWith(
          notesUpdateStatus: UpdateNotesRequestStatus.success,
          errorMessage: ''));
    });
  }

  void changeActiceTheme(ThemeData currentTheme) {
    currentTheme == AppTheme.lightMode
        ? emit(state.copyWith(themeModeValue: ThemeModeValue.dark))
        : emit(state.copyWith(themeModeValue: ThemeModeValue.light));
  }

  Future<void> cacheThemeMode(
      {required String key, required bool isDark}) async {
    final result = await notesBaseRepository
        .setIsDarkThemValue(ActiveThemeSetParams(key, isDark));

    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  void getCachedThemeMode({required String key}) async {
    final result =
        await notesBaseRepository.getIsDarkThemeValue(ActiveThemeParams(key));
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      if (r) {
        emit(state.copyWith(
            errorMessage: '', themeModeValue: ThemeModeValue.dark));
      } else {
        emit(state.copyWith(
            errorMessage: '', themeModeValue: ThemeModeValue.light));
      }
    });
  }

  Future<void> saveNoteToFirebase(SaveUserNotesToFirestoreParams params) async {
    final result = await baseRemoteNotesRepository.saveUserNotes(params);
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  void saveNoteToFirebaseIfSignedIn(NotesModel notesModel) async {
    if (serviceLocator<FirebaseAuth>().currentUser != null) {
      await saveNoteToFirebase(
        SaveUserNotesToFirestoreParams(
          notesModel: notesModel,
          userId: serviceLocator<FirebaseAuth>().currentUser!.uid,
        ),
      );
    }
  }

  Future<void> updateNoteToFirebase(UpdateNoteDateParams params) async {
    final result = await baseRemoteNotesRepository.updateNoteDate(params);
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  void updateNoteToFirebaseIfSignedInAndHaveInternet(
      NotesModel notesModel) async {
    if (serviceLocator<FirebaseAuth>().currentUser != null) {
      final firebaseId = await serviceLocator<FirebaseFirestore>()
          .collection(AppStrings.collectionUsers)
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .collection(AppStrings.collectionNotes)
          .where('myId', isEqualTo: notesModel.myId)
          .get()
          .then((value) => value.docs[0].id);
      await updateNoteToFirebase(
        UpdateNoteDateParams(
          note: notesModel,
          userId: serviceLocator<FirebaseAuth>().currentUser!.uid,
          firebaseId: firebaseId,
        ),
      );
    }
  }

  Future<void> deleteNoteFromFirebase(DeleteNoteDataParams params) async {
    final result = await baseRemoteNotesRepository.deleteNoteData(params);
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  void deleteNoteFromFirebaseIfSignedInAndHaveInternet(int myId) async {
    if (serviceLocator<FirebaseAuth>().currentUser != null) {
      final firebaseId = await serviceLocator<FirebaseFirestore>()
          .collection(AppStrings.collectionUsers)
          .doc(serviceLocator<FirebaseAuth>().currentUser!.uid)
          .collection(AppStrings.collectionNotes)
          .where('myId', isEqualTo: myId)
          .get()
          .then((value) => value.docs[0].id);
      await deleteNoteFromFirebase(
        DeleteNoteDataParams(
          userId: serviceLocator<FirebaseAuth>().currentUser!.uid,
          firebaseId: firebaseId,
        ),
      );
    }
  }

  Future<void> getNotesFromFirebase({required String userId}) async {
    emit(state.copyWith(
        readNotesFromFirebaseAndStoreItInDatabaseRequestStatus:
            ReadNotesFromFirebaseAndStoreItInDatabaseRequestStatus.loading));
    final result = await baseRemoteNotesRepository
        .getNotesFromFirebase(GetNotesFromFirebaseParams(userId: userId));

    result.fold((l) {
      emit(state.copyWith(
          readNotesFromFirebaseAndStoreItInDatabaseRequestStatus:
              ReadNotesFromFirebaseAndStoreItInDatabaseRequestStatus.failure,
          errorMessage: l.message));
    }, (r) {
      if (r.isNotEmpty) {
        insertListOfNotesToDatabase(r);
      }
      emit(state.copyWith(
          readNotesFromFirebaseAndStoreItInDatabaseRequestStatus:
              ReadNotesFromFirebaseAndStoreItInDatabaseRequestStatus.success,
          errorMessage: ''));
    });
  }

  Future<void> insertListOfNotesToDatabase(List<NotesModel> notes) async {
    final List<Map<String, dynamic>> listOfNotes =
        notes.map((e) => NotesModel.toDataBaseMap(e)).toList();
    final result = await notesBaseRepository
        .insertNotes(InsertNotesToDatabaseParams(listOfNotes));
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      getNotes();
    });
  }

  Future<void> deleteAllLocalNotes() async {
    final result = await notesBaseRepository
        .deleteAllNotes(const DeleteAllNotesParams(AppStrings.tableName));
    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(errorMessage: '', notes: List.from([])));
    });
  }

  void syncNotesToFirebase(String userId) {
    for (var element in state.notes) {
      saveNoteToFirebaseIfSignedIn(element);
    }
  }
}
