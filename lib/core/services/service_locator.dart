import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/core/authService/auth_service.dart';
import 'package:notes/features/auth/repositories/base/base_auth_local_repository.dart';
import 'package:notes/features/auth/repositories/base/base_auth_remote_repository.dart';
import 'package:notes/features/auth/repositories/impl/aut_local_repository_impl.dart';
import 'package:notes/features/auth/view_model/cubit/auth_cubit.dart';
import 'package:notes/features/notes/repositories/local/notes_local_repository_impl.dart';
import 'package:notes/features/notes/view_model/cubit/notes_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/auth/repositories/impl/auth_repository_impl.dart';
import '../../features/notes/repositories/base/notes_base_repository.dart';
import '../cache/chache_setup.dart';

var serviceLocator = GetIt.instance;

class ServiceLocator {
  static void init() {
    // cubits
    serviceLocator
        .registerFactory<NotesCubit>(() => NotesCubit(serviceLocator()));
    serviceLocator.registerFactory<AuthCubit>(
        () => AuthCubit(serviceLocator(), serviceLocator()));

//repository
    serviceLocator.registerLazySingleton<NotesBaseRepository>(
        () => NotesLocalRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseRemoteAuthRepository>(
        () => AuthRemoteRepositoryImpl());
    serviceLocator.registerLazySingleton<BaseAuthLocalRepository>(
        () => AuthLocalRepositoryImpl());
//firbaseInstance
    serviceLocator
        .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    serviceLocator.registerLazySingleton<AuthFirbaseService>(
        () => AuthFirbaseService(serviceLocator()));
  }

  static Future initCache() async {
    await getSharedPref();

    serviceLocator.registerLazySingleton<CacheHelper>(
        () => CacheHelper(sharedPreferences: serviceLocator()));
  }

  static Future getSharedPref() async {
    final prefs = await SharedPreferences.getInstance();
    serviceLocator.registerLazySingleton<SharedPreferences>(() => prefs);
  }
}
