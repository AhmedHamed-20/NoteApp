import 'package:notes/core/cache/chache_setup.dart';
import 'package:notes/core/database/database_setup.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/features/notes/models/notes_model.dart';
import 'package:notes/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/features/notes/repositories/base/notes_base_local_repository.dart';

class NotesLocalRepositoryImpl extends NotesBaseLocalRepository {
  @override
  Future<Either<Failure, void>> addNote(NoteAddingParams params) async {
    try {
      final result = await DatabaseProvider.insertIntoDataBase(
        data: [
          params.noteTitle,
          params.noteBody,
          params.noteColor,
          params.noteDate,
          params.myId
        ],
        query:
            'INSERT INTO notes(title, body, color,time, myId) VALUES(?, ?, ?, ?, ?)',
      );
      return Right(result);
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNoteById(NoteDeleteParams params) async {
    try {
      await DatabaseProvider.deleteDataFromDatabaseById(
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
      final result = await DatabaseProvider.getAllDataFromDatabase(
        params.tableName,
      );
      return Right(List.from(result.map((e) => NotesModel.fromMap(e))));
    } on Exception catch (e) {
      return Left(DatabaseFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateNote(NoteUpdateParams params) async {
    try {
      await DatabaseProvider.updateDataBase(
          'UPDATE ${params.tableName} SET  title= ?, body = ? ,color= ? WHERE dataBaseId = ?',
          [
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
  Future<Either<Failure, bool>> getActiceTheme(ActiveThemeParams params) async {
    try {
      final result =
          await serviceLocator<CacheHelper>().getData(key: params.key);
      return Right(result ?? false);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setActiveTheme(
      ActiveThemeSetParams params) async {
    try {
      serviceLocator<CacheHelper>()
          .setData(key: params.key, value: params.value);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
