import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/cache/chache_setup.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/database/database_setup.dart';
import 'package:notes/core/theme/app_theme.dart';
import 'package:notes/features/auth/repositories/base/base_auth_local_repository.dart';
import 'package:notes/features/notes/view/screens/all_notes_screen.dart';
import 'package:notes/firebase_options.dart';

import 'core/services/service_locator.dart';
import 'features/auth/view/screens/auth_screen.dart';
import 'features/auth/view_model/cubit/auth_cubit.dart';
import 'features/notes/view_model/cubit/notes_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ServiceLocator.initCache();
  await initializeDefaultFirebaseOptions();
  ServiceLocator.init();
  final skipAuth =
      await serviceLocator<CacheHelper>().getData(key: AppStrings.skipSignIn) ??
          false;
  serviceLocator<DatabaseProvider>().init(
      databasesName: '${AppStrings.tableName}.db',
      query: AppStrings.createDataBaseQuery,
      version: 1);
  runApp(MyApp(
    skipAuth: skipAuth,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.skipAuth});
  final bool skipAuth;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<NotesCubit>()
            ..getNotes()
            ..getCachedThemeMode(key: AppStrings.isDarkThemeModeKey),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AuthCubit>()
            ..getCachedSkipSignInValue(const GetCachedOfflineModeValueParams(
              key: AppStrings.skipSignIn,
            )),
        ),
      ],
      child: BlocBuilder<NotesCubit, NoteState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Note App',
            themeMode: state.themeModeValue.index == 0
                ? ThemeMode.light
                : ThemeMode.dark,
            theme: AppTheme.lightMode,
            darkTheme: AppTheme.darkMode,
            home: skipAuth
                ? const AllNotesScreen()
                : const AuthScreen(
                    isFirstTime: true,
                  ),
          );
        },
      ),
    );
  }
}
