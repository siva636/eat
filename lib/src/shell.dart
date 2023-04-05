import 'package:eat/src/account/account.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:eat/src/search/Search.dart';
import 'package:eat/src/sign_in/view/sign_in_page.dart';
import 'package:eat/src/sign_up/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({
    required this.child,
    Key? key,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        destinations: const <NavigationDestination>[
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        selectedIndex: _calculateSelectedIndex(context),
        onDestinationSelected: (int idx) => _onItemTapped(idx, context),
      ),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    if (location.startsWith(Splash.path)) {
      return 0;
    }
    if (location.startsWith(Search.path)) {
      return 1;
    }
    if (location.startsWith(Account.path) ||
        location.startsWith(SignInPage.path) ||
        location.startsWith(SignUpPage.path)) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(Splash.path);
        break;
      case 1:
        context.go(Search.path);
        break;
      case 2:
        context.go(Account.path);
        break;
    }
  }
}
