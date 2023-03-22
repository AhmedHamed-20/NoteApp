import 'package:dartz/dartz.dart';
import 'package:notes/core/error/failure.dart';
import 'package:notes/features/auth/repositories/base/base_auth_local_repository.dart';

import '../../../../core/cache/chache_setup.dart';

class AuthLocalRepositoryImpl extends BaseAuthLocalRepository {
  final CacheHelper _cacheHelper;

  AuthLocalRepositoryImpl(this._cacheHelper);
  @override
  Future<Either<Failure, void>> cacheSkipSignIn(
      CacheOfflineModeParams params) async {
    try {
      await _cacheHelper.setData(key: params.key, value: params.skipSignIn);
      return const Right(null);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> getCachedSkipSignValue(
      GetCachedOfflineModeValueParams params) async {
    try {
      final result = await _cacheHelper.getData(
        key: params.key,
      );
      return Right(result ?? true);
    } on Exception catch (e) {
      return Left(CacheFailure(message: e.toString()));
    }
  }
}
