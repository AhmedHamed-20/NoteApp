import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/features/notes/models/notes_model.dart';
import 'package:notes/features/notes/view/screens/all_notes_screen.dart';
import 'package:notes/features/notes/view_model/cubit/notes_cubit.dart';

import '../../../../core/const/const.dart';
import '../../../../core/const/text_fields_controllers.dart';
import '../widgets/edit_add_notes_widgets/change_color_widget.dart';
import '../widgets/edit_add_notes_widgets/text_fields.dart';

class AddEditNoteScreen extends StatelessWidget {
  const AddEditNoteScreen({
    super.key,
    required this.isEdit,
    this.note,
  });
  final bool isEdit;
  final NotesModel? note;

  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          AppStrings.addNote,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          BlocConsumer<NotesCubit, NoteState>(
            listener: (context, state) {
              if (state.notesAddStatus.index == 1 ||
                  state.notesUpdateStatus.index == 1) {
                flutterToast(
                  msg: AppStrings.savedSuccessfully,
                  backgroundColor: AppColors.toastSuccess,
                  textColor: AppColors.white,
                );

                notesCubit.getNotes();
                notesCubit.resetStatus();

                navigatePushUntiAndRemove(
                    navigateTO: const AllNotesScreen(), context: context);
              }
            },
            builder: (context, state) {
              return TextButton(
                onPressed: () async {
                  final int colorHexa = colors[state.activeColorIndex].value;
                  if (isEdit) {
                    notesCubit.updateNoteToDatabase(
                      databaseId: note!.dataBaseId!,
                      noteBody: TextFieldsControllers.bodyControler.text.trim(),
                      noteTitle:
                          TextFieldsControllers.titleControler.text.trim(),
                      noteColor: colorHexa.toString(),
                    );
                  } else {
                    notesCubit.addNoteToDatabase(
                      noteDate: DateTime.now().toString(),
                      noteBody: TextFieldsControllers.bodyControler.text.trim(),
                      noteTitle:
                          TextFieldsControllers.titleControler.text.trim(),
                      noteColor: colorHexa.toString(),
                    );
                  }
                },
                child: Text(
                  isEdit ? AppStrings.saveEdit : AppStrings.save,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p12),
          child: Column(
            children: [
              EditAddTextFieldsWidget(isEdit: isEdit, note: note),
              const ChangeColorWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
