import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/error/failure.dart';

abstract class BaseAuthLocalRepository {
  Future<Either<Failure, void>> cacheSkipSignIn(CacheOfflineModeParams params);
  Future<Either<Failure, bool>> getCachedSkipSignValue(
      GetCachedOfflineModeValueParams params);
}

class CacheOfflineModeParams extends Equatable {
  final bool skipSignIn;
  final String key;
  const CacheOfflineModeParams({required this.skipSignIn, required this.key});

  @override
  List<Object?> get props => [skipSignIn, key];
}

class GetCachedOfflineModeValueParams extends Equatable {
  final String key;
  const GetCachedOfflineModeValueParams({required this.key});

  @override
  List<Object?> get props => [key];
}
