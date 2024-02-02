import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:myclients/config/route/route_paths.dart';
import 'package:myclients/modules/home/view/home_view.dart';
import '../../modules/app_loading/view/app_loading_screen.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const AppLoadingScreen();
      },
    ),
    GoRoute(
      path: RoutePaths.home,
      name: RoutePaths.home,
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
  ],
);
