import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/features/notes/view/widgets/switch_account_alert_dialog_widget.dart';
import 'package:notes/features/notes/view/widgets/sync_notes_alert_dialog.dart';

class SyncDataWidget extends StatefulWidget {
  const SyncDataWidget({
    super.key,
    required this.hasInternet,
  });
  final bool hasInternet;

  @override
  State<SyncDataWidget> createState() => _SyncDataWidgetState();
}

class _SyncDataWidgetState extends State<SyncDataWidget> {
  @override
  void initState() {
    // checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.hasInternet) {
      return serviceLocator<FirebaseAuth>().currentUser != null
          ? InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) =>
                        const SwitchAccountAlertDialogWidget());
              },
              child: serviceLocator<FirebaseAuth>().currentUser!.photoURL ==
                      null
                  ? const CircleAvatar(
                      radius: AppRadius.r25,
                      backgroundImage: AssetImage(AppAssets.noImage),
                    )
                  : CircleAvatar(
                      radius: AppRadius.r25,
                      backgroundImage: NetworkImage(
                        serviceLocator<FirebaseAuth>().currentUser!.photoURL!,
                      ),
                    ),
            )
          : IconButton(
              icon: Icon(Icons.sync, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const SyncNoteAlertDilalog());
              });
    } else {
      return const SizedBox.shrink();
    }
  }
}
