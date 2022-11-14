import 'package:get_it/get_it.dart';
import 'package:notes/features/notes/repositories/local/notes_local_repository_impl.dart';
import 'package:notes/features/notes/view_model/cubit/notes_cubit.dart';

import '../../features/notes/repositories/base/notes_base_repository.dart';

var serviceLocator = GetIt.instance;

class ServiceLocator {
  static void init() {
    // cubits
    serviceLocator
        .registerFactory<NotesCubit>(() => NotesCubit(serviceLocator()));

//repository
    serviceLocator.registerLazySingleton<NotesBaseRepository>(
        () => NotesLocalRepositoryImpl());
  }
}
