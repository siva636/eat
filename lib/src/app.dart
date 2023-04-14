import 'package:eat/src/about/about.dart';
import 'package:eat/src/dashboard/dashboard.dart';
import 'package:eat/src/auth/bloc/auth_bloc.dart';
import 'package:eat/src/onboarding/splash.dart';
import 'package:eat/src/search/view/search.dart';
import 'package:eat/src/shell.dart';
import 'package:eat/src/sign_in/sign_in.dart';
import 'package:eat/src/sign_up/sign_up.dart';
import 'package:eat/src/utils/enums/authentication_status.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      debugShowCheckedModeBanner: false,
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
          path: SignUpPage.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SignUpPage();
          },
        ),
        GoRoute(
          path: SearchPage.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SearchPage();
          },
        ),
        GoRoute(
          path: About.path,
          builder: (BuildContext context, GoRouterState state) {
            return const About();
          },
        ),
        GoRoute(
          path: SignInPage.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SignInPage();
          },
        ),
        GoRoute(
          path: Dashboard.path,
          redirect: (BuildContext context, GoRouterState state) {
            if (context.read<AuthBloc>().state.authenticationStatus !=
                AuthenticationStatus.authenticated) {
              return SignInPage.path;
            } else {
              return null;
            }
          },
          builder: (BuildContext context, GoRouterState state) {
            return const Dashboard();
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
