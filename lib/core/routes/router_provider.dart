import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:nomadcoder_flutter_final_project2/core/constants/router_const.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/screens/navigation_screen.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/screens/sign_in_screen.dart';
import 'package:nomadcoder_flutter_final_project2/presentation/screens/sign_up_screen.dart';
import 'package:nomadcoder_flutter_final_project2/providers/auth/auth_repository_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'router_provider.g.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
@riverpod
GoRouter router(Ref ref) {
  final authState = ref.watch(authStateStreamProvider);
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RoutePath.signin,
    routes: [
      GoRoute(
        path: RoutePath.signin,
        name: RouteNames.signin,
        builder: (context, state) => const SignInScreen(),
      ),
      GoRoute(
        path: RoutePath.signup,
        name: RouteNames.signup,
        builder: (context, state) => const SignUpScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return NavigationScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.home,
                name: RouteNames.home,
                builder: (context, state) => Container(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.write,
                name: RouteNames.write,
                builder: (context, state) => Container(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RoutePath.profile,
                name: RouteNames.profile,
                builder: (context, state) => Container(),
              ),
            ],
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      if (authState is AsyncLoading<User?>) {
        return RoutePath.signin;
      }

      final authenticated = authState.valueOrNull != null;

      final authenticating =
          (state.matchedLocation == RoutePath.signin) ||
          (state.matchedLocation == RoutePath.signup);

      if (authenticated == false) {
        return authenticating ? null : RoutePath.signin;
      }
      return (authenticating) ? RoutePath.home : null;
    },
  );
}
