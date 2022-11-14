import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/const/const.dart';
import '../../../../../core/widget/color_picker_widget.dart';
import '../../../view_model/cubit/notes_cubit.dart';

class ChangeColorWidget extends StatelessWidget {
  const ChangeColorWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var notesCubit = BlocProvider.of<NotesCubit>(context);

    return SizedBox(
      height: screenHeight(context) * 0.1,
      width: screenWidth(context),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: colors.length,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            notesCubit.changeActiveColorIndex(index);
          },
          child: BlocBuilder<NotesCubit, NoteState>(
            builder: (context, state) {
              return ColorPickerWidget(
                colors: colors,
                currentActiveTab: state.activeColorIndex,
                currentWidgetIndex: index,
                context: context,
              );
            },
          ),
        ),
      ),
    );
  }
}
