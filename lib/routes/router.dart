import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/controllers/menuAppController.dart';
import 'package:tim_app/pages/dashboard_main.dart';
import 'package:tim_app/pages/homepage.dart';
import 'package:tim_app/pages/login.dart';
import 'package:tim_app/pages/profile.dart';
import 'package:tim_app/pages/profile/profile_screen.dart';
import 'package:provider/provider.dart';

GoRouter createRouter() {
  return GoRouter(
    routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => MenuAppController(),
            ),
          ],
          child: const Home(),
        ),
      ),
      GoRoute(
        path: "/login",
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: "/dashboard",
        builder: (context, state) => const DashboardMainScreen(),
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) => const ProfiePage(),
      ),
    ],
  );
}

// final _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: "/",
//       builder: (context, state) => const Home(),
//     ),
//     GoRoute(
//       path: "/dashboard",
//       builder: (context, state) => const DashboardMainScreen(),
//     ),
//     GoRoute(
//       path: "/profile",
//       builder: (context, state) => const ProfiePage(),
//     ),
//   ],
// );
