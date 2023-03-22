import 'package:notes/core/cache/chache_setup.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/database/database_setup.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/features/notes/models/notes_model.dart';
import 'package:notes/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/features/notes/repositories/base/notes_base_local_repository.dart';

class NotesLocalRepositoryImpl extends NotesBaseLocalRepository {
  final DatabaseProvider _databaseProvider;
  final CacheHelper _cacheHelper;
  NotesLocalRepositoryImpl(this._databaseProvider, this._cacheHelper);
  @override
  Future<Either<Failure, void>> addNote(NoteAddingParams params) async {
    try {
      final result = await _databaseProvider.insertIntoDataBase(
        data: [
          params.noteTitle,
          params.noteBody,
          params.noteColor,
          params.noteDate,
          params.myId
        ],
        query: AppStrings.insertIntoDataBaseQuery,
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNoteById(NoteDeleteParams params) async {
    try {
      await _databaseProvider.deleteDataFromDatabaseById(
          tableName: params.tableName, id: params.databaseId);
      return const Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<NotesModel>>> getNotes(
      NotesGetParams params) async {
    try {
      final result = await _databaseProvider.getAllDataFromDatabase(
        params.tableName,
      );
      return Right(List.from(result
          .map((e) => NotesModel.fromMap(map: e, isFromFirebase: false))));
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteUpdateParams params) async {
    try {
      await _databaseProvider.updateDataBase(AppStrings.updateDataBaseQuer, [
        params.noteTitle,
        params.noteBody,
        params.noteColor,
        params.databaseId
      ]);
      return const Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getIsDarkThemeValue(
      ActiveThemeParams params) async {
    try {
      final result = await _cacheHelper.getData(key: params.key);
      return Right(result ?? false);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setIsDarkThemValue(
      ActiveThemeSetParams params) async {
    try {
      _cacheHelper.setData(key: params.key, value: params.value);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Object?>>> insertNotes(
      InsertNotesToDatabaseParams params) async {
    try {
      final result = await _databaseProvider.insertListToDatabase(params.notes);
      return Right(result);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllNotes(
      DeleteAllNotesParams params) async {
    try {
      await _databaseProvider.deleteAllDataFromDatabase(
          tableName: params.tableName);
      return const Right(null);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }
}
