// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

class AuthState extends Equatable {
  final AuthRequestStatus signInRequestStatus;
  final AuthRequestStatus signUpRequestStatus;

  final String errorMessage;
  final int statusCode;
  const AuthState({
    this.signInRequestStatus = AuthRequestStatus.idle,
    this.signUpRequestStatus = AuthRequestStatus.idle,
    this.errorMessage = '',
    this.statusCode = 0,
  });

  AuthState copyWith({
    AuthRequestStatus? signInRequestStatus,
    AuthRequestStatus? signUpRequestStatus,
    String? errorMessage,
    int? statusCode,
  }) {
    return AuthState(
      signInRequestStatus: signInRequestStatus ?? this.signInRequestStatus,
      signUpRequestStatus: signUpRequestStatus ?? this.signUpRequestStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      statusCode: statusCode ?? this.statusCode,
    );
  }

  @override
  List<Object> get props => [
        signInRequestStatus,
        signUpRequestStatus,
        errorMessage,
        statusCode,
      ];
}
