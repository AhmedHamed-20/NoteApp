import 'package:flutter/material.dart';

import '../../../../../core/const/const.dart';

class EditAddTextFieldsWidget extends StatelessWidget {
  const EditAddTextFieldsWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          style: Theme.of(context).textTheme.titleLarge,
          controller: titleControler,
          decoration: InputDecoration(
            focusColor: Colors.transparent,
            fillColor: Theme.of(context).scaffoldBackgroundColor,
            hintText: 'Title',
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
          controller: bodyControler,
          decoration: InputDecoration(
            focusColor: Colors.transparent,
            fillColor: Colors.white,
            hintText: 'Type somthing...',
            hintStyle: Theme.of(context).textTheme.titleMedium,
            border: InputBorder.none,
          ),
        ),
      ],
    );
  }
}
