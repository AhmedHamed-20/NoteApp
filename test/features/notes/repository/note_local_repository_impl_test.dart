import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/core/cache/chache_setup.dart';
import 'package:notes/core/database/database_setup.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/features/notes/repositories/base/notes_base_local_repository.dart';
import 'package:notes/features/notes/repositories/impl/notes_local_repository_impl.dart';

import 'note_repository_dumy_data_test.dart';

class MockDataBaseProvider extends Mock implements DatabaseProvider {}

class MockCacheHelper extends Mock implements CacheHelper {}

void main() {
  late MockDataBaseProvider mockDataBaseProvider;
  late NotesLocalRepositoryImpl notesLocalRepositoryImpl;
  late MockCacheHelper mockCacheHelper;
  setUp(() {
    mockDataBaseProvider = MockDataBaseProvider();
    mockCacheHelper = MockCacheHelper();
    notesLocalRepositoryImpl =
        NotesLocalRepositoryImpl(mockDataBaseProvider, mockCacheHelper);
  });
  group('test note local repository', () {
    test('addNote should return database failure when error occurs', () async {
      // arrange
      when(() => mockDataBaseProvider.insertIntoDataBase(
            data: any(named: 'data'),
            query: any(named: 'query'),
          )).thenThrow(Exception());
      // act
      final result =
          (await notesLocalRepositoryImpl.addNote(tNotesAddingParams))
              .fold((l) => l, (r) => null);
      // assert
      expect(
        result,
        isA<DatabaseFailure>(),
      );
      verify(() => mockDataBaseProvider.insertIntoDataBase(
            data: any(named: 'data'),
            query: any(named: 'query'),
          )).called(1);
    });
    test('deleteNoteById should return database failure when error occurs',
        () async {
      // arrange
      when(() => mockDataBaseProvider.deleteDataFromDatabaseById(
            tableName: any(named: 'tableName'),
            id: any(named: 'id'),
          )).thenThrow(Exception());
      // act
      final result = (await notesLocalRepositoryImpl
              .deleteNoteById(const NoteDeleteParams(0, 'test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(
        result,
        isA<DatabaseFailure>(),
      );
      verify(() => mockDataBaseProvider.deleteDataFromDatabaseById(
            tableName: any(named: 'tableName'),
            id: any(named: 'id'),
          )).called(1);
    });
    test('getNotes should return list<NotesModel> on righ when success',
        () async {
      // arrange
      when(() => mockDataBaseProvider.getAllDataFromDatabase(any()))
          .thenAnswer((_) async => [tNotesMap]);

      // act
      final result = (await notesLocalRepositoryImpl
              .getNotes(const NotesGetParams('test')))
          .fold((l) => null, (r) => r);
      // assert
      expect(
        result,
        [tNotesModel],
      );
      verify(() => mockDataBaseProvider.getAllDataFromDatabase(any()))
          .called(1);
    });
    test('getNotes should return database failure when error occurs', () async {
      // arrange
      when(() => mockDataBaseProvider.getAllDataFromDatabase(any()))
          .thenThrow(Exception());
      // act
      final result = (await notesLocalRepositoryImpl
              .getNotes(const NotesGetParams('test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(
        result,
        isA<DatabaseFailure>(),
      );
      verify(() => mockDataBaseProvider.getAllDataFromDatabase(any()))
          .called(1);
    });
    test('updateNote should return database failure when error occurs',
        () async {
      // arrange
      when(() => mockDataBaseProvider.updateDataBase(
            any(),
            any(),
          )).thenThrow(Exception());
      // act
      final result =
          (await notesLocalRepositoryImpl.updateNote(tNotesUpdateParams))
              .fold((l) => l, (r) => null);
      // assert
      expect(
        result,
        isA<DatabaseFailure>(),
      );
      verify(() => mockDataBaseProvider.updateDataBase(
            any(),
            any(),
          )).called(1);
    });
    test('getIsDarkThemeValue should return bool on success', () async {
      // arrange
      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenAnswer((_) async => true);
      // act
      final result = (await notesLocalRepositoryImpl
              .getIsDarkThemeValue(const ActiveThemeParams('test')))
          .fold((l) => null, (r) => r);
      // assert
      expect(result, true);
      verify(() => mockCacheHelper.getData(key: any(named: 'key'))).called(1);
    });
    test('getIsDarkThemeValue should return cache failure when error occurs',
        () async {
      // arrange
      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenThrow(Exception());
      // act
      final result = (await notesLocalRepositoryImpl
              .getIsDarkThemeValue(const ActiveThemeParams('test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<CacheFailure>());
      verify(() => mockCacheHelper.getData(key: any(named: 'key'))).called(1);
    });
    test('setIsDarkThemeValue should return cache failure when error occurs',
        () async {
      // arrange
      when(() => mockCacheHelper.setData(
            key: any(named: 'key'),
            value: any(named: 'value'),
          )).thenThrow(Exception());
      // act
      final result = (await notesLocalRepositoryImpl
              .setIsDarkThemValue(const ActiveThemeSetParams('test', true)))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<CacheFailure>());
      verify(() => mockCacheHelper.setData(
            key: any(named: 'key'),
            value: any(named: 'value'),
          )).called(1);
    });
    test(
        'insert notes should return database failure on left when error occurs',
        () async {
      // arrange
      when(() => mockDataBaseProvider.insertListToDatabase(
            [tNotesMap],
          )).thenThrow(Exception());
      // act
      final result = (await notesLocalRepositoryImpl
              .insertNotes(const InsertNotesToDatabaseParams([tNotesMap])))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<DatabaseFailure>());
      verify(() => mockDataBaseProvider.insertListToDatabase(
            [tNotesMap],
          )).called(1);
    });
    test(
        'delete all notes should return datebase failure on left when error occurs',
        () async {
      // arrange
      when(() => mockDataBaseProvider.deleteAllDataFromDatabase(
          tableName: any(named: 'tableName'))).thenThrow(Exception());
      // act
      final result = (await notesLocalRepositoryImpl
              .deleteAllNotes(const DeleteAllNotesParams('test')))
          .fold((l) => l, (r) => null);
      // assert
      expect(result, isA<DatabaseFailure>());
      verify(() => mockDataBaseProvider.deleteAllDataFromDatabase(
          tableName: any(named: 'tableName'))).called(1);
    });
  });
}
