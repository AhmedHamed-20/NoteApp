import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/features/notes/view/screens/all_notes_screen.dart';
import 'package:notes/features/notes/view_model/cubit/notes_cubit.dart';

import '../../../../core/const/const.dart';
import '../widgets/edit_add_notes_widgets/change_color_widget.dart';
import '../widgets/edit_add_notes_widgets/text_fields.dart';

class AddEditNoteScreen extends StatefulWidget {
  const AddEditNoteScreen(
      {super.key,
      required this.isEdit,
      this.databaseId,
      this.title,
      this.body});
  final bool isEdit;
  final String? title;
  final String? body;
  final int? databaseId;
  @override
  State<AddEditNoteScreen> createState() => _AddEditNoteScreenState();
}

class _AddEditNoteScreenState extends State<AddEditNoteScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.isEdit) {
      titleControler.text = widget.title ?? '';
      bodyControler.text = widget.body ?? '';
    }
  }

  @override
  void dispose() {
    titleControler.clear();
    bodyControler.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Add Note',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          BlocConsumer<NotesCubit, NoteState>(
            listener: (context, state) {
              if (state.notesAddStatus.index == 1 ||
                  state.notesUpdateStatus.index == 1) {
                flutterToast(
                    msg: 'Saved Sucess',
                    backgroundColor: AppColors.toastSuccess,
                    textColor: AppColors.white);

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
                  if (widget.isEdit) {
                    notesCubit.updateNoteToDatabase(
                      databaseId: widget.databaseId!,
                      noteBody: bodyControler.text.trim(),
                      noteTitle: titleControler.text.trim(),
                      noteColor: colorHexa.toString(),
                    );
                  } else {
                    notesCubit.addNoteToDatabase(
                      noteDate: DateTime.now().toString(),
                      noteBody: bodyControler.text.trim(),
                      noteTitle: titleControler.text.trim(),
                      noteColor: colorHexa.toString(),
                    );
                  }
                },
                child: Text(
                  widget.isEdit ? 'save edit' : 'save',
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
            children: const [
              EditAddTextFieldsWidget(),
              ChangeColorWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
