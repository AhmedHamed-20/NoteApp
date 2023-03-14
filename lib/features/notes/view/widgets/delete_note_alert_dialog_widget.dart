import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/const/const.dart';

import '../../view_model/cubit/notes_cubit.dart';

class DeleteNoteAlertDoalogWidget extends StatelessWidget {
  const DeleteNoteAlertDoalogWidget({Key? key, required this.databaseId})
      : super(
          key: key,
        );
  final int databaseId;
  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);
    return BlocConsumer<NotesCubit, NoteState>(
      listener: (context, state) {
        if (state.notesDeleteStatus.index == 1) {
          flutterToast(
              msg: 'Deleted Success',
              backgroundColor: AppColors.toastSuccess,
              textColor: AppColors.white);
          notesCubit.getNotes();
          notesCubit.resetStatus();
        }
      },
      builder: (context, state) {
        return AlertDialog(
          title: Text('Are you sure ?',
              style: Theme.of(context).textTheme.titleLarge),
          content: Text('Delete this note ?',
              style: Theme.of(context).textTheme.titleMedium),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('No', style: Theme.of(context).textTheme.titleMedium),
            ),
            TextButton(
              onPressed: () {
                notesCubit.deleteNoteFromDatabaseById(databaseId);
                Navigator.pop(context);
              },
              child: Text(
                'Yes',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
          backgroundColor: Theme.of(context).colorScheme.background,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }
}
