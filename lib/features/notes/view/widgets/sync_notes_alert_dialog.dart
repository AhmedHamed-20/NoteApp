import 'package:flutter/material.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/features/auth/view/screens/auth_screen.dart';

class SyncNoteAlertDilalog extends StatelessWidget {
  const SyncNoteAlertDilalog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppStrings.syncNotes,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text(AppStrings.syncNotesMessage,
          style: Theme.of(context).textTheme.titleMedium),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              AppStrings.cancel,
              style: Theme.of(context).textTheme.titleMedium,
            )),
        TextButton(
          onPressed: () {
            navigatePushUntiAndRemove(
                navigateTO: const AuthScreen(isSyncing: true),
                context: context);
          },
          child: Text(
            AppStrings.syncData,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
