import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/backend/firebase/UserDataProvider.dart';
import 'package:tim_app/controllers/menuAppController.dart';
import 'package:tim_app/fade_transition.dart';
import 'package:tim_app/pages/admin/account/account_main.dart';
import 'package:tim_app/pages/admin/admin_main_screen.dart';
import 'package:tim_app/pages/admin/admin_more_page.dart';
import 'package:tim_app/pages/admin/content_management/admin_content_main.dart';
import 'package:tim_app/pages/admin/content_management/admin_manage_advertisement.dart';
import 'package:tim_app/pages/admin/content_management/admin_manage_special_offer.dart';
import 'package:tim_app/pages/admin/content_management/manage_about/manage_about_main.dart';
import 'package:tim_app/pages/admin/content_management/manage_city_guide/manage_cityGuide_main.dart';
import 'package:tim_app/pages/admin/content_management/manage_how_it_works/manage_how_main.dart';
import 'package:tim_app/pages/admin/content_management/manage_media/manage_media_main.dart';
import 'package:tim_app/pages/admin/content_management/manage_news/manage_news_main.dart';
import 'package:tim_app/pages/admin/content_management/manage_tourvideo/manage_tour_main.dart';
import 'package:tim_app/pages/admin/dashboard/admin_dashboard_main.dart';
import 'package:tim_app/pages/admin/manage_business/manage_main.dart';
import 'package:tim_app/pages/admin/manage_travellers/manage_travellers_main.dart';
import 'package:tim_app/pages/profile/profile_screen.dart';

import 'package:tim_app/pages/travellers/apply_business/apply_business_main.dart';
import 'package:tim_app/pages/business/advertisement/business_advertisement_main.dart';
import 'package:tim_app/pages/business/business_dashboard_main.dart';
import 'package:tim_app/pages/business/business_details/business_details_screen.dart';
import 'package:tim_app/pages/business/business_menu.dart';

import 'package:tim_app/pages/business/payment/business_payment_main.dart';
import 'package:tim_app/pages/business/special_offers/business_special_offers_main.dart';
import 'package:tim_app/pages/excel.dart';

import 'package:tim_app/pages/homepage/howItWorks_page.dart';
import 'package:tim_app/pages/homepage/latestNews_page.dart';
import 'package:tim_app/pages/homepage/specialOffers_page.dart';
import 'package:tim_app/pages/login.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/pages/signup.dart';
import 'package:tim_app/pages/travellers/travel_history/travel_history_main.dart';
import 'package:tim_app/pages/travellers/traveller_main_screen.dart';
import 'package:tim_app/pages/travellers/dashboard/traveller_dashboard_screen.dart';
import 'package:tim_app/pages/travellers/traveller_plan/travel_plan_screen.dart';
import '../pages/homepage/about_page.dart';
import '../pages/homepage/advertise_page.dart';
import '../pages/homepage/cityGuide_page.dart';
import '../pages/homepage/homepage.dart';
import '../pages/homepage/media_page.dart';
import '../pages/signup/signup_interest_main.dart';
import '../pages/travellers/travel_history/components/trip_history_rate.dart';

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
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const Home()),
      ),
      GoRoute(
        path: "/excel",
        builder: (context, state) => const ExcelUpload(),
      ),
      GoRoute(
        path: "/login",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const LoginPage()),
      ),
      GoRoute(
        path: "/signup",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const SignupPage()),
      ),
      GoRoute(
        path: "/dashboard",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const TravellerMain()),
      ),
      GoRoute(
        path: "/apply-business",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const ApplyBusinessMain()),
      ),
      GoRoute(
        path: "/signup-interest",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const InterestMain()),
      ),
      GoRoute(
        path: "/profile",
        builder: (context, state) => const ProfileScreen(),

      ),
      GoRoute(
        path: "/about",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const AboutPage()),
      ),
      GoRoute(
        path: "/media",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const MediaPage()),
      ),
      GoRoute(
        path: "/advertise",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const AdvertisePage()),
      ),
      GoRoute(
        path: "/how-it-works",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const HowItWorksPage()),
      ),
      GoRoute(
        path: "/latest-news",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const LatestNewsPage()),
      ),
      GoRoute(
        path: "/special-offers",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const SpecialOffersPage()),
      ),
      GoRoute(
        path: "/city-guide",
        pageBuilder: (context, state) =>
            CustomFadeTransition(widgetChild: const CityGuidePage()),
      ),

      //business dashboard routes
      GoRoute(
        path: "/admin-dashboard",
        builder: (context, state) => const AdminMain(),
      ),
      GoRoute(
        path: "/admin-manage-content",
        builder: (context, state) => const AdminMain(),
      ),

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

// ======== ADMIN DESKTOP ========
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorAKey = GlobalKey<NavigatorState>(debugLabel: 'shellA');
final _shellNavigatorBKey = GlobalKey<NavigatorState>(debugLabel: 'shellB');
final travellerKey = GlobalKey<NavigatorState>(debugLabel: 'travellerKey');
final contentKey = GlobalKey<NavigatorState>(debugLabel: 'contentKey');
final accountKey = GlobalKey<NavigatorState>(debugLabel: 'accountKey');

final adminRouter = GoRouter(
  initialLocation: '/admin-dashboard',
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
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
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: _shellNavigatorBKey,
          routes: [
            GoRoute(
              path: '/admin-manage-business',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ManageBusinessMain(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: travellerKey,
          routes: [
            GoRoute(
              path: '/admin-manage-travellers',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ManageTravellerMain(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: contentKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/admin-manage-content',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ContentManagementMain(),
              ),
              routes: [
                GoRoute(
                  path: 'offer',
                  builder: (context, state) => const ManageSpecialOffer(),
                ),
                GoRoute(
                  path: 'advertisement',
                  builder: (context, state) => const ManageAdvertisement(),
                ),
                GoRoute(
                  path: 'news',
                  builder: (context, state) => const ManageNewsScreenMain(),
                ),
                GoRoute(
                  path: 'media',
                  builder: (context, state) => const ManageMediaScreenMain(),
                ),
                GoRoute(
                  path: 'guide',
                  builder: (context, state) =>
                      const ManageCityGuideScreenMain(),
                ),
                GoRoute(
                  path: 'about',
                  builder: (context, state) => const ManageAboutScreenMain(),
                ),
                GoRoute(
                  path: 'how',
                  builder: (context, state) => const ManageHowScreenMain(),
                ),
                GoRoute(
                  path: 'tour',
                  builder: (context, state) => const ManageTourScreenMain(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: accountKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/admin-account',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AdminAccountMain(),
              ),
              routes: [],
            ),
          ],
        ),
      ],
    ),
  ],
);

// ======== MOBILE DESKTOP ========
final _rootNavigatorKeyMobile = GlobalKey<NavigatorState>();
final _shellNavigatorAKeyMobile =
    GlobalKey<NavigatorState>(debugLabel: 'shellAMobile');
final _shellNavigatorBKeyMobile =
    GlobalKey<NavigatorState>(debugLabel: 'shellBMobile');
final travellerKeyMobile =
    GlobalKey<NavigatorState>(debugLabel: 'travellerKeyMobile');
final contentKeyMobile =
    GlobalKey<NavigatorState>(debugLabel: 'contentKeyMobile');
final accountKeyMobile = GlobalKey<NavigatorState>(debugLabel: 'accountKey');
final moreKeyMobile = GlobalKey<NavigatorState>(debugLabel: 'moreKeyMobile');

final goRouterMobile = GoRouter(
  initialLocation: '/admin-dashboard',
  navigatorKey: _rootNavigatorKeyMobile,
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
          navigatorKey: _shellNavigatorAKeyMobile,
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
          navigatorKey: _shellNavigatorBKeyMobile,
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
        StatefulShellBranch(
          navigatorKey: travellerKey,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/admin-manage-travellers',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ManageTravellerMain(),
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
        StatefulShellBranch(
          navigatorKey: moreKeyMobile,
          routes: [
            // Shopping Cart
            GoRoute(
              path: '/admin-more',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: AdminMorePage(),
              ),
              routes: [
                GoRoute(
                  path: 'details',
                  builder: (context, state) => const DetailsScreen(label: 'B'),
                ),
                /*GoRoute(
                  path: '/admin-manage-content',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: ContentManagementMain(),
                  ),
                  routes: [
                    GoRoute(
                      path: 'offer',
                      builder: (context, state) => const ManageSpecialOffer(),
                    ),
                    GoRoute(
                      path: 'advertisement',
                      builder: (context, state) => const ManageAdvertisement(),
                    ),
                    GoRoute(
                      path: 'news',
                      builder: (context, state) => const ManageNewsScreenMain(),
                    ),
                  ],
                ),
                GoRoute(
                  path: '/admin-account',
                  pageBuilder: (context, state) => const NoTransitionPage(
                    child: AdminAccountMain(),
                  ),
                  routes: [],
                ),*/
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
              routes: [],
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
                child: BusinessPaymentScreen(),
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

final travellerNavigatorKey = GlobalKey<NavigatorState>();
final travellerNavigator = GlobalKey<NavigatorState>(debugLabel: 'dashboard');
final travelPlanNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'travel-plan');
final travelHistoryNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'travel-history');
final travelApplyBusinessNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'travel-apply');
final travelAccountNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'travel-account');

final travellerRouter = GoRouter(
  initialLocation: '/dashboard',
  navigatorKey: travellerNavigatorKey,
  debugLogDiagnostics: true,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return TravellerNavigation(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: travellerNavigator,
          routes: [
            GoRoute(
              path: '/dashboard',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TravellerDashboard(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: travelPlanNavigator,
          routes: [
            GoRoute(
              path: '/travel-plan',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TravellerPlanScreen(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: travelHistoryNavigator,
          routes: [
            GoRoute(
              path: '/travel-history',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: TravelHistoryMain(),
              ),
              routes: [
                GoRoute(
                  path: 'history-rate',
                  builder: (context, state) => const TripHistoryRate(),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: travelApplyBusinessNavigator,
          routes: [
            GoRoute(
              path: '/apply-business',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ApplyBusinessMain(),
              ),
              routes: [],
            ),
          ],
        ),
        StatefulShellBranch(
          navigatorKey: travelAccountNavigator,
          routes: [
            GoRoute(
              path: '/traveller-account',
              pageBuilder: (context, state) => const NoTransitionPage(
                child: ProfileScreen(),
              ),
              routes: [],
            ),
          ],
        ),
      ],
    ),
  ],
);
