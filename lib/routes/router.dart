import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/controllers/menuAppController.dart';
import 'package:tim_app/pages/admin/admin_main.dart';
import 'package:tim_app/pages/admin/admin_main_screen.dart';
import 'package:tim_app/pages/admin/dashboard/admin_dashboard_main.dart';
import 'package:tim_app/pages/admin/manage_business/manage_main.dart';
import 'package:tim_app/pages/advertise_page.dart';


import 'package:tim_app/pages/apply_business/apply_business_main.dart';
import 'package:tim_app/pages/business/advertisement/business_advertisement_main.dart';
import 'package:tim_app/pages/business/business_dashboard_main.dart';
import 'package:tim_app/pages/business/business_details/business_details_main.dart';
import 'package:tim_app/pages/business/business_details/business_details_screen.dart';
import 'package:tim_app/pages/business/business_menu.dart';

import 'package:tim_app/pages/business/components/Business_dashboard.dart';
import 'package:tim_app/pages/business/special_offers/business_special_offers_main.dart';

import 'package:tim_app/pages/dashboard_main.dart';
import 'package:tim_app/pages/homepage.dart';
import 'package:tim_app/pages/homepage/howItWorks_page.dart';
import 'package:tim_app/pages/homepage/latestNews_page.dart';
import 'package:tim_app/pages/homepage/specialOffers_page.dart';
import 'package:tim_app/pages/login.dart';
import 'package:tim_app/pages/media_page.dart';
import 'package:tim_app/pages/profile.dart';
import 'package:provider/provider.dart';

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
      // GoRoute(
      //   path: "/about",
      //   builder: (context, state) => const AboutPage(),
      // ),
      GoRoute(
        path: "/media",
        builder: (context, state) => const MediaPage(),
      ),
      GoRoute(
        path: "/advertise",
        builder: (context, state) => const AdvertisePage(),
      ),
      GoRoute(
        path: "/how-it-works",
        builder: (context, state) => const HowItWorksPage(),
      ),
      GoRoute(
        path: "/latest-news",
        builder: (context, state) => const LatestNewsPage(),
      ),
      GoRoute(
        path: "/special-offers",
        builder: (context, state) => const SpecialOffersPage(),
      ),

      //business dashboard routes
      GoRoute(
        path: "/admin-dashboard",
        builder: (context, state) => const AdminMain(),
      ),
      // GoRoute(
      //   path: "/business-details",
      //   builder: (context, state) => AboutPage(),
      // ),

      // business routing
      GoRoute(
        path: "/business-dashboard",
        builder: (context, state) => const BusinessMenu(),
      ),
      GoRoute(
        path: '/business-details',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: BusinessMenu(),
        ),
      ),
      GoRoute(
        path: '/business-advertisement',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: BusinessMenu(),
        ),
      ),
      GoRoute(
        path: '/business-offers',
        pageBuilder: (context, state) => const NoTransitionPage(
          child: BusinessMenu(),
        ),
      ),
    ],
  );
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');

final goRouter = GoRouter(
  initialLocation: '/admin-dashboard',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNestedNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _shellNavigatorAKey,
          routes: [
            GoRoute(
              path: '/admin-dashboard',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AdminDashboardMain(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'A'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/admin-manage-business',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ManageBusinessMain(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);

final businessNavigatorKey = GlobalKey<NavigatorState>();
final dashboardNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'businessDashboard');
final adsNavigator = GlobalKey<NavigatorState>(debugLabel: 'businessAds');
final offersNavigator = GlobalKey<NavigatorState>(debugLabel: 'businessOffers');
final businessDetailsNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'businessDetails');
final paymentDetailsNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'payment');

final businessRouter = GoRouter(
  initialLocation: '/business-dashboard',
  navigatorKey: businessNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    // Stateful navigation based on:
    // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: dashboardNavigator,
          routes: [
            GoRoute(
              path: '/business-dashboard',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BusinessScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'A'),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: adsNavigator,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/business-advertisement',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BusinessAdvertisementScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'details',
              //     builder: (context, state) => const DetailsScreen(label: 'B'),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: offersNavigator,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/business-offers',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BusinessSpecialOfferScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'details',
              //     builder: (context, state) => const DetailsScreen(label: 'B'),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: businessDetailsNavigator,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/business-details',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BusinessDetailsScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'details',
              //     builder: (context, state) => const DetailsScreen(label: 'B'),
              //   ),
              // ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: paymentDetailsNavigator,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/business-payment',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: BusinessSpecialOfferScreen(),
              ),
              // routes: [
              //   GoRoute(
              //     path: 'details',
              //     builder: (context, state) => const DetailsScreen(label: 'B'),
              //   ),
              // ],
            ),
          ],
        ),
      ],
    ),
  ],
);
