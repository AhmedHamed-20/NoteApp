import 'package:notes/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dartz/dartz.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/features/auth/repositories/base/base_auth_remote_repository.dart';

import '../../../../core/services/authService/auth_service.dart';

class AuthRemoteRepositoryImpl extends BaseRemoteAuthRepository {
  @override
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      SignInParams params) async {
    try {
      final result = await serviceLocator<AuthFirbaseService>()
          .signInWithEmailAndPassword(
              email: params.email, password: params.password);
      return Right(result);
    } on FirebaseAuthMultiFactorException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'error occured'));
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword(
      SignUpParams params) async {
    try {
      final result = await serviceLocator<AuthFirbaseService>()
          .signUpWithEmailAndPassword(
              email: params.email, password: params.password);
      return Right(result);
    } on FirebaseAuthMultiFactorException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'error occured'));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await serviceLocator<AuthFirbaseService>().signOut();
      return const Right(null);
    } on FirebaseAuthMultiFactorException catch (e) {
      return Left(ServerFailure(message: e.message ?? 'error occured'));
    }
  }
}
