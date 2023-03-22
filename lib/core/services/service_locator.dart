import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:notes/core/services/authService/auth_service.dart';
import 'package:notes/core/services/firestore_service/firestore_service.dart';
import 'package:notes/features/auth/repositories/base/base_auth_local_repository.dart';
import 'package:notes/features/auth/repositories/impl/aut_local_repository_impl.dart';
import 'package:notes/features/auth/view_model/cubit/auth_cubit.dart';
import 'package:notes/features/notes/repositories/base/notes_remote_repository.dart';
import 'package:notes/features/notes/repositories/impl/notes_local_repository_impl.dart';
import 'package:notes/features/notes/repositories/impl/notes_remote_repository_impl.dart';
import 'package:notes/features/notes/view_model/cubit/notes_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/notes/repositories/base/notes_base_local_repository.dart';
import '../cache/chache_setup.dart';
import '../database/database_setup.dart';

var serviceLocator = GetIt.instance;

class ServiceLocator {
  static void init() {
    // DatabaseProvider
    serviceLocator
        .registerLazySingleton<DatabaseProvider>(() => DatabaseProvider());
    // cubits
    serviceLocator.registerFactory<NotesCubit>(
        () => NotesCubit(serviceLocator(), serviceLocator()));
    serviceLocator.registerFactory<AuthCubit>(
        () => AuthCubit(serviceLocator(), serviceLocator()));

//repository
    serviceLocator.registerLazySingleton<NotesBaseLocalRepository>(
        () => NotesLocalRepositoryImpl(serviceLocator(), serviceLocator()));

    serviceLocator.registerLazySingleton<BaseAuthLocalRepository>(
        () => AuthLocalRepositoryImpl(serviceLocator()));
    serviceLocator.registerLazySingleton<BaseRemoteNotesRepository>(
        () => NotesRemoteRepositoryImpl(
              serviceLocator(),
            ));
//firbaseInstance
    serviceLocator
        .registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
    serviceLocator.registerLazySingleton<AuthFirbaseService>(
        () => AuthFirbaseService(serviceLocator()));

    //firebaseFireStore
    serviceLocator.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);

    serviceLocator.registerLazySingleton<FirestoreService>(
        () => FirestoreService(serviceLocator()));
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
