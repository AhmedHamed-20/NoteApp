import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:notes/core/utls/utls.dart';
import 'package:notes/features/auth/repositories/base/base_auth_local_repository.dart';
import 'package:notes/features/auth/repositories/base/base_auth_remote_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.baseAuthRepository, this.baseAuthLocalRepository)
      : super(const AuthState());

  final BaseRemoteAuthRepository baseAuthRepository;
  final BaseAuthLocalRepository baseAuthLocalRepository;
  Future<void> signInWithEmailAndPassword(SignInParams params) async {
    emit(state.copyWith(signInRequestStatus: AuthRequestStatus.loading));
    final result = await baseAuthRepository.signInWithEmailAndPassword(params);
    result.fold(
        (failure) => emit(
              state.copyWith(
                signInRequestStatus: AuthRequestStatus.failure,
                errorMessage: failure.message,
                statusCode: failure.statusCode,
              ),
            ), (userCredential) {
      emit(
        state.copyWith(
          signInRequestStatus: AuthRequestStatus.success,
          errorMessage: '',
          statusCode: 0,
        ),
      );
    });
  }

  Future<void> signUpWithEmailAndPassword(SignUpParams params) async {
    emit(state.copyWith(signInRequestStatus: AuthRequestStatus.loading));
    final result = await baseAuthRepository.signUpWithEmailAndPassword(params);
    result.fold(
        (failure) => emit(
              state.copyWith(
                signUpRequestStatus: AuthRequestStatus.failure,
                errorMessage: failure.message,
                statusCode: failure.statusCode,
              ),
            ), (userCredential) {
      emit(
        state.copyWith(
          signUpRequestStatus: AuthRequestStatus.success,
          errorMessage: '',
          statusCode: 0,
        ),
      );
    });
  }

  Future<void> cacheSkipSignInValue(CacheOfflineModeParams params) async {
    final result = await baseAuthLocalRepository.cacheSkipSignIn(params);
    result
        .fold((failure) => emit(state.copyWith(errorMessage: failure.message)),
            (value) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  Future<void> getCachedSkipSignInValue(
      GetCachedOfflineModeValueParams params) async {
    final result = await baseAuthLocalRepository.getCachedSkipSignValue(params);
    result
        .fold((failure) => emit(state.copyWith(errorMessage: failure.message)),
            (value) {
      emit(state.copyWith(errorMessage: ''));
    });
  }

  Future<void> signOut() async {
    final result = await baseAuthRepository.signOut();
    result
        .fold((failure) => emit(state.copyWith(errorMessage: failure.message)),
            (value) {
      emit(state.copyWith(errorMessage: ''));
    });
  }
}
