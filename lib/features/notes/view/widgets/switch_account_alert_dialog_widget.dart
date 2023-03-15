import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/features/auth/view/screens/auth_screen.dart';

import '../../../auth/view_model/cubit/auth_cubit.dart';
import '../../view_model/cubit/notes_cubit.dart';

class SwitchAccountAlertDialogWidget extends StatelessWidget {
  const SwitchAccountAlertDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final notesCubit = BlocProvider.of<NotesCubit>(context);
    final authCubit = BlocProvider.of<AuthCubit>(context);
    return AlertDialog(
        title: Text(
          AppStrings.switchAccount,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        content: Text(
          AppStrings.areYouSureYouWantToSwitchAccount,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(AppStrings.no,
                style: Theme.of(context).textTheme.titleMedium),
          ),
          TextButton(
            onPressed: () {
              authCubit.signOut();
              navigatePushUntiAndRemove(
                  navigateTO: const AuthScreen(isSwitchingAccount: true),
                  context: context);
              notesCubit.deleteAllLocalNotes();
            },
            child: Text(AppStrings.yes,
                style: Theme.of(context).textTheme.titleMedium),
          ),
        ]);
  }
}
