import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart' as firebase_ui;
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/core/const/app_strings.dart';
import 'package:notes/core/const/const.dart';
import 'package:notes/core/services/service_locator.dart';
import 'package:notes/features/notes/view/screens/all_notes_screen.dart';

import '../../../../core/const/google_clinet_id.dart';
import '../../../notes/view_model/cubit/notes_cubit.dart';
import '../../repositories/base/base_auth_local_repository.dart';
import '../../view_model/cubit/auth_cubit.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen(
      {super.key,
      this.isSwitchingAccount = false,
      this.isSyncing = false,
      this.isFirstTime = false});
  final bool isSwitchingAccount;
  final bool isSyncing;
  final bool isFirstTime;
  @override
  Widget build(BuildContext context) {
    final authCubit = BlocProvider.of<AuthCubit>(context);
    final notesCubit = BlocProvider.of<NotesCubit>(context);
    return StreamBuilder<User?>(
        stream: serviceLocator<FirebaseAuth>().authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return firebase_ui.SignInScreen(
              subtitleBuilder: (context, action) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: AppPadding.p10),
                  child: Text(
                    AppStrings.signInAndSaveNotes,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                );
              },
              providers: [
                firebase_ui.EmailAuthProvider(),
                GoogleProvider(
                  clientId: GoogleClientId.clientId,
                ),
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
                    AppStrings.skipAndContinueOnOffline,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                );
              },
            );
          } else {
            authCubit.cacheSkipSignInValue(const CacheOfflineModeParams(
              skipSignIn: true,
              key: AppStrings.skipSignIn,
            ));
            if (isSwitchingAccount || isFirstTime) {
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
