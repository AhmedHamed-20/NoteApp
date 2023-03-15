import 'package:flutter/material.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/const/text_fields_controllers.dart';

import '../../../../../core/const/const.dart';
import '../../../models/notes_model.dart';

class EditAddTextFieldsWidget extends StatefulWidget {
  const EditAddTextFieldsWidget({
    required this.isEdit,
    this.note,
    Key? key,
  }) : super(key: key);
  final bool isEdit;
  final NotesModel? note;
  @override
  State<EditAddTextFieldsWidget> createState() =>
      _EditAddTextFieldsWidgetState();
}

class _EditAddTextFieldsWidgetState extends State<EditAddTextFieldsWidget> {
  @override
  void initState() {
    super.initState();
    initControllers();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: Theme.of(context).textTheme.titleLarge,
          controller: TextFieldsControllers.titleControler,
          decoration: InputDecoration(
            focusColor: Colors.transparent,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            hintText: AppStrings.title,
            hintStyle: Theme.of(context).textTheme.titleLarge,
            border: InputBorder.none,
          ),
        ),
        const SizedBox(
          height: AppHeight.h10,
        ),
        TextField(
          cursorColor: Theme.of(context).iconTheme.color,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          style: Theme.of(context).textTheme.titleMedium,
          controller: TextFieldsControllers.bodyControler,
          decoration: InputDecoration(
            focusColor: Colors.transparent,
            fillColor: Colors.white,
            hintText: AppStrings.typeSomething,
            hintStyle: Theme.of(context).textTheme.titleMedium,
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }

  void initControllers() {
    TextFieldsControllers.titleControler = TextEditingController();
    TextFieldsControllers.bodyControler = TextEditingController();
    if (widget.isEdit) {
      TextFieldsControllers.titleControler.text = widget.note!.title;
      TextFieldsControllers.bodyControler.text = widget.note!.body;
    }
  }

  void disposeControllers() {
    TextFieldsControllers.titleControler.dispose();
    TextFieldsControllers.bodyControler.dispose();
  }
}
