import 'package:flutter/material.dart';
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
        'Sync Notes',
        style: Theme.of(context).textTheme.titleLarge,
      ),
      content: Text('Sync notes with your account?',
          style: Theme.of(context).textTheme.titleMedium),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: Theme.of(context).textTheme.titleMedium,
            )),
        TextButton(
          onPressed: () {
            navigatePushUntiAndRemove(
                navigateTO: const AuthScreen(), context: context);
          },
          child: Text(
            'Sync',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}
