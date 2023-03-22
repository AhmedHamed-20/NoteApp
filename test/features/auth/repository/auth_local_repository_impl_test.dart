import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:notes/core/cache/chache_setup.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/features/auth/repositories/base/base_auth_local_repository.dart';
import 'package:notes/features/auth/repositories/impl/aut_local_repository_impl.dart';

class MockCacheHelper extends Mock implements CacheHelper {}

void main() {
  late MockCacheHelper mockCacheHelper;
  late AuthLocalRepositoryImpl authLocalRepositoryImpl;
  setUp(() {
    mockCacheHelper = MockCacheHelper();
    authLocalRepositoryImpl = AuthLocalRepositoryImpl(mockCacheHelper);
  });

  group('test auth local repository', () {
    test(
        'cacheSkipSignIn should return cache failure on left when error occurs',
        () async {
      //arrange
      when(() => mockCacheHelper.setData(
          key: any(named: 'key'),
          value: any(named: 'value'))).thenThrow(Exception());
      //act
      final result = (await authLocalRepositoryImpl.cacheSkipSignIn(
              const CacheOfflineModeParams(key: 'key', skipSignIn: true)))
          .fold((l) => l, (r) => null);
      //assert
      expect(result, isA<CacheFailure>());
      verify(() => mockCacheHelper.setData(
          key: any(named: 'key'), value: any(named: 'value'))).called(1);
    });
    test('getCachedSkipSignValue should return bool on success', () async {
      //arrange
      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenAnswer((_) async => true);

      //act
      final result = (await authLocalRepositoryImpl.getCachedSkipSignValue(
              const GetCachedOfflineModeValueParams(key: 'key')))
          .fold((l) => null, (r) => r);

      //assert
      expect(result, true);
      verify(() => mockCacheHelper.getData(key: any(named: 'key'))).called(1);
    });

    test(
        'getCachedSkipSignValue should return cache failure on left when error occurs',
        () {
      //arrange
      when(() => mockCacheHelper.getData(key: any(named: 'key')))
          .thenThrow(Exception());
      //act
      final result = (authLocalRepositoryImpl.getCachedSkipSignValue(
              const GetCachedOfflineModeValueParams(key: 'key')))
          .then((value) => value.fold((l) => l, (r) => null));
      //assert
      expect(result, completion(isA<CacheFailure>()));
      verify(() => mockCacheHelper.getData(key: any(named: 'key'))).called(1);
    });
  });
}
