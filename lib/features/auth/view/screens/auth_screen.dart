import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/features/notes/view/screens/all_notes_screen.dart';

import '../../../notes/view_model/cubit/notes_cubit.dart';
import '../../repositories/base/base_auth_local_repository.dart';
import '../../view_model/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen(
      {super.key, this.isSwitchingAccount = false, this.isSyncing = false});
  final bool isSwitchingAccount;
  final bool isSyncing;
  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final notesCubit = BlocProvider.of<NotesCubit>(context);
    return StreamBuilder<User?>(
        stream: serviceLocator<FirebaseAuth>().authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return firebase_ui.SignInScreen(
              providers: [
                firebase_ui.EmailAuthProvider(),
              ],
              footerBuilder: (context, action) {
                return TextButton(
                  onPressed: () {
                    authCubit.cacheSkipSignInValue(const CacheOfflineModeParams(
                      skipSignIn: true,
                      key: AppStrings.skipSignIn,
                    ));
                    navigatePushUntiAndRemove(
                        navigateTO: const AllNotesScreen(signedIn: false),
                        context: context);
                  },
                  child: Text(
                    'Skip and continue on offline mode',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              },
            );
          } else {
            authCubit.cacheSkipSignInValue(const CacheOfflineModeParams(
              skipSignIn: true,
              key: AppStrings.skipSignIn,
            ));
            if (isSwitchingAccount == true) {
              notesCubit.getNotesFromFirebase(userId: snapshot.data!.uid);
            }
            if (isSyncing == true) {
              notesCubit.syncNotesToFirebase(snapshot.data!.uid);
            }
            return const AllNotesScreen(
              signedIn: true,
            );
          }
        });
  }
}
