import 'package:eat/src/account/account.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:eat/src/search/Search.dart';
import 'package:eat/src/shell.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      scrollBehavior: MyCustomScrollBehavior(),
      theme: ThemeData(
        // brightness: Brightness.dark,
        useMaterial3: true,
        colorSchemeSeed: Colors.red,
        fontFamily: 'ultra',
      ),
    );
  }
}

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: Splash.path,
  routes: <RouteBase>[
    GoRoute(
      path: Splash.path,
      builder: (BuildContext context, GoRouterState state) {
        return const Splash();
      },
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          path: Search.path,
          builder: (BuildContext context, GoRouterState state) {
            return const Search();
          },
        ),
        GoRoute(
          path: Account.path,
          builder: (BuildContext context, GoRouterState state) {
            return const Account();
          },
        ),
      ],
    ),
  ],
);

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
