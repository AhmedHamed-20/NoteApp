import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/theme/app_theme.dart';
import 'package:notes/core/utls/utls.dart';
import 'package:notes/features/notes/repositories/base/notes_base_repository.dart';

import '../../models/notes_model.dart';

part 'notes_state.dart';

class NotesCubit extends Cubit<NoteState> {
  NotesCubit(this.notesBaseRepository) : super(const NoteState());

  final NotesBaseRepository notesBaseRepository;

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
    final result =
        await notesBaseRepository.getNotes(const NotesGetParams('notes'));
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

  Future<void> deleteNoteFromDatabaseById(int databaseId) async {
    final result = await notesBaseRepository
        .deleteNoteById(NoteDeleteParams(databaseId, 'notes'));
    result.fold((l) {
      emit(state.copyWith(
          notesDeleteStatus: DeleteNotesByIdRequestStatus.failure,
          errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(
          notesDeleteStatus: DeleteNotesByIdRequestStatus.success,
          errorMessage: ''));
    });
  }

  Future<void> addNoteToDatabase(
      {required String noteTitle,
      required String noteBody,
      required String noteColor,
      required String noteDate}) async {
    final result = await notesBaseRepository.addNote(NoteAddingParams(
        noteBody: noteBody,
        noteColor: noteColor,
        noteDate: noteDate,
        noteTitle: noteTitle,
        tableName: 'notes'));
    result.fold((l) {
      emit(state.copyWith(
          notesAddStatus: AddNotesRequestStatus.failure,
          errorMessage: l.message));
    }, (r) {
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
        tableName: 'notes',
        noteBody: noteBody,
        noteColor: noteColor,
        noteTitle: noteTitle));
    result.fold((l) {
      emit(state.copyWith(
          notesUpdateStatus: UpdateNotesRequestStatus.failure,
          errorMessage: l.message));
    }, (r) {
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
        .setActiveTheme(ActiveThemeSetParams(key, isDark));

    result.fold((l) {
      emit(state.copyWith(errorMessage: l.message));
    }, (r) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  void getCachedThemeMode({required String key}) async {
    final result =
        await notesBaseRepository.getActiceTheme(ActiveThemeParams(key));
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
}
