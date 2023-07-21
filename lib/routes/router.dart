import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/controllers/menuAppController.dart';

import 'package:tim_app/pages/apply_business/applyBusiness.dart';
import 'package:tim_app/pages/apply_business/apply_business_main.dart';

import 'package:tim_app/pages/about_page.dart';
import 'package:tim_app/pages/business/components/Business_dashboard.dart';

import 'package:tim_app/pages/dashboard_main.dart';
import 'package:tim_app/pages/homepage.dart';
import 'package:tim_app/pages/login.dart';
import 'package:tim_app/pages/media_page.dart';
import 'package:tim_app/pages/profile.dart';
import 'package:provider/provider.dart';

import '../pages/business/business_details/business_details_main.dart';
import '../pages/signup/signup_interest_main.dart';

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
        path: "/apply-business",
        builder: (context, state) => const ApplyBusinessMain(),
      ),
      GoRoute(
        path: "/signup-interest",
        builder: (context, state) => const InterestMain(),
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) => const ProfiePage(),
      ),
      GoRoute(
        path: "/about",
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: "/media",
        builder: (context, state) => const MediaPage(),
      ),

      //business dashboard routes
      GoRoute(
        path: "/business-dashboard",
        builder: (context, state) => const BusinessMainScreen(),
      ),
      GoRoute(
        path: "/business-details",
        builder: (context, state) => const BusinessDetailsMain(),
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
