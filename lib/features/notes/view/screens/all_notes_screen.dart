import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/core/theme/app_theme.dart';

import '../../view_model/cubit/notes_cubit.dart';
import '../widgets/all_notes_widgets/note_widget.dart';
import '../widgets/sync_data_widget.dart';
import 'edit_add_note_screen.dart';

class AllNotesScreen extends StatefulWidget {
  const AllNotesScreen({super.key, this.signedIn = false});
  final bool signedIn;

  @override
  State<AllNotesScreen> createState() => _AllNotesScreenState();
}

class _AllNotesScreenState extends State<AllNotesScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);
    return BlocBuilder<NotesCubit, NoteState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Theme.of(context).scaffoldBackgroundColor,
              statusBarIconBrightness: state.themeModeValue.index == 0
                  ? Brightness.dark
                  : Brightness.light,
            ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              AppStrings.notes,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            actions: [
              IconButton(
                onPressed: () {
                  if (state.themeModeValue.index == 0) {
                    notesCubit.changeActiceTheme(AppTheme.lightMode);
                    notesCubit.cacheThemeMode(
                        key: AppStrings.isDarkThemeModeKey, isDark: true);
                  } else {
                    notesCubit.changeActiceTheme(AppTheme.darkMode);
                    notesCubit.cacheThemeMode(
                        key: AppStrings.isDarkThemeModeKey, isDark: false);
                  }
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.background),
                icon: Center(
                  child: Icon(
                    Icons.light_mode,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
              FutureBuilder<bool>(
                future: InternetConnectionChecker().hasConnection,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SyncDataWidget(hasInternet: snapshot.data!);
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              navigatePushTo(
                  navigateTO: const AddEditNoteScreen(isEdit: false),
                  context: context);
            },
            backgroundColor: Theme.of(context).colorScheme.background,
            child: Icon(
              Icons.add,
              size: 30,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          body: const Padding(
            padding: EdgeInsets.only(right: 15, left: 15),
            child: MainNoteWidget(),
          ),
        );
      },
    );
  }

  Future<bool> checkInternet() async {
    var result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
