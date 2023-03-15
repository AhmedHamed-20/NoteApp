import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/core/widget/cached_network_image_circle_photo.dart';
import 'package:notes/features/notes/view/widgets/sync_notes_alert_dialog.dart';

class SyncDataWidget extends StatefulWidget {
  const SyncDataWidget({
    super.key,
  });

  @override
  State<SyncDataWidget> createState() => _SyncDataWidgetState();
}

class _SyncDataWidgetState extends State<SyncDataWidget> {
  bool hasInternet = false;
  @override
  void initState() {
    super.initState();
    checkInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: hasInternet,
      replacement: serviceLocator<FirebaseAuth>().currentUser != null
          ? CachedNetworkImageCirclePhoto(
              photoUrl: serviceLocator<FirebaseAuth>().currentUser!.photoURL ??
                  AppAssets.defaultImage,
              photoRadius: 40,
            )
          : IconButton(
              icon: Icon(Icons.sync, color: Theme.of(context).iconTheme.color),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => const SyncNoteAlertDilalog());
              }),
      child: const SizedBox.shrink(),
    );
  }

  Future<void> checkInternet() async {
    hasInternet = await InternetConnectionChecker().hasConnection;
  }
}
