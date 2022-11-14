import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/cache/chache_setup.dart';
import 'package:notes/core/database/database_setup.dart';
import 'package:notes/core/theme/app_theme.dart';
import 'package:notes/features/notes/view/screens/all_notes_screen.dart';

import 'core/services/service_locator.dart';
import 'features/notes/view_model/cubit/notes_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  ServiceLocator.init();
  await DatabaseProvider.init(
      databasesName: 'notes.db',
      query:
          'CREATE TABLE notes (id INTEGER PRIMARY KEY, title TEXT, body TEXT, color TEXT,time TEXT)',
      version: 1);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<NotesCubit>()
            ..getNotes()
            ..getCachedThemeMode(key: 'isDark'),
        )
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
              home: const AllNotesScreen());
        },
      ),
    );
  }
}
