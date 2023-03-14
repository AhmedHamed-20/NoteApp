import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes/core/error/failure.dart';

abstract class BaseRemoteAuthRepository {
  Future<Either<Failure, UserCredential>> signInWithEmailAndPassword(
      SignInParams params);
  Future<Either<Failure, UserCredential>> signUpWithEmailAndPassword(
      SignUpParams params);
}

class SignInParams extends Equatable {
  final String email;
  final String password;

  const SignInParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpParams extends Equatable {
  final String email;
  final String password;

  const SignUpParams({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
