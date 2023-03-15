import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/features/notes/view/screens/edit_add_note_screen.dart';

import 'note.dart';
import '../../../view_model/cubit/notes_cubit.dart';
import '../delete_note_alert_dialog_widget.dart';

class MainNoteWidget extends StatelessWidget {
  const MainNoteWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);

    return BlocBuilder<NotesCubit, NoteState>(
      builder: (context, state) {
        return state.notes.isEmpty
            ? Center(
                child: Text(
                  AppStrings.noNotesToshow,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              )
            : StaggeredGridView.countBuilder(
                staggeredTileBuilder: (int index) => const StaggeredTile.fit(1),
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                itemCount: state.notes.length,
                itemBuilder: (BuildContext context, int index) =>
                    GestureDetector(
                  onTap: () {},
                  onLongPress: () {
                    HapticFeedback.mediumImpact();
                    showDialog(
                      context: context,
                      builder: (_) => DeleteNoteAlertDoalogWidget(
                        databaseId: state.notes[index].dataBaseId!,
                        myId: state.notes[index].myId,
                      ),
                    );
                  },
                  child: GestureDetector(
                    onTap: () {
                      final colorindex = colors
                          .indexOf(Color(int.parse(state.notes[index].color)));
                      notesCubit.changeActiveColorIndex(colorindex);
                      navigatePushTo(
                          navigateTO: AddEditNoteScreen(
                            isEdit: true,
                            note: state.notes[index],
                          ),
                          context: context);
                    },
                    child: Notes(
                      note: state.notes[index],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
