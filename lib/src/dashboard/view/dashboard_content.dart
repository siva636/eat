import 'package:eat/src/auth/bloc/auth_bloc.dart';
import 'package:eat/src/dashboard/bloc/bloc.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:eat/src/search/view/search.dart';
import 'package:eat/src/utils/constants/constants.dart';
import 'package:eat/src/utils/enums/view_status.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final dashboardBloc = context.read<DashboardBloc>();

    return BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
      if (state.viewStatus == ViewStatus.inProgress) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state.viewStatus == ViewStatus.success) {
        return const Center(child: Text('Profile deleted'));
      }
      if (state.viewStatus == ViewStatus.failure) {
        return const Center(child: Text('Profile deletion failed'));
      }

      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome ${authBloc.state.myUser!.mobileNumber}!'),
            const SizedBox(height: verticalGap),
            Column(
              children: [
                FilledButton(
                  onPressed: () {
                    context.go(SearchPage.path);
                  },
                  child: const Text('Restaurants'),
                ),
                const SizedBox(height: verticalGap),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () async {
                        bool? confirmedDeletion = await showDialog<bool>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Delete profile?'),
                            content: const Text(
                                'Are you sure you want to delete your profile permanently?'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        );
                        if (!mounted) {
                          return;
                        }
                        if (confirmedDeletion == true) {
                          String uid = authBloc.state.myUser!.uid;
                          dashboardBloc.add(DeletionConfirmed(uid));
                          authBloc.add(Delete());
                        }
                      },
                      child: const Text('Delete'),
                    ),
                    TextButton(
                      onPressed: () {
                        FirebaseAuth.instance.signOut();
                        context.go(Splash.path);
                      },
                      child: const Text('Sign out'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
