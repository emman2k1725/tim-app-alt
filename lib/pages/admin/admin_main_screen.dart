// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/routes/router.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

import '../../responsive.dart';

class AdminMain extends StatefulWidget {
  const AdminMain({super.key});

  @override
  State<AdminMain> createState() => _AdminMainState();
}

class _AdminMainState extends State<AdminMain> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserDataProvider>(
        create: (context) => UserDataProvider(),
        child: MaterialApp.router(
          routerConfig:
              router, //Responsive.isDesktop(context) ? goRouter : goRouterMobile,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primarySwatch: Colors.indigo),
        ));
  }
}

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // navigating to the initial location when tapping the item that is
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Responsive.isDesktop(context)
          ? ScaffoldWithNavigationRail(
              body: navigationShell,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
            )
          : ScaffoldWithNavigationBar(
              body: navigationShell,
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
            );
      /*if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }*/
    });
  }
}

class ScaffoldWithNavigationBar extends StatelessWidget {
  const ScaffoldWithNavigationBar({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
              label: 'Dashboard',
              tooltip: 'Dashboard',
              icon: Icon(
                Icons.explore_outlined, // Example: Use a Facebook icon
              )),
          NavigationDestination(
              label: 'Businesses',
              tooltip: 'Manage Business',
              icon: Icon(
                Icons.work, // Example: Use a Facebook icon
              )),
          NavigationDestination(
              label: 'Travellers',
              tooltip: 'Manage Travellers',
              icon: Icon(
                Icons.travel_explore, // Example: Use a Facebook icon
              )),
          NavigationDestination(
              label: 'Content',
              tooltip: 'Content Management',
              icon: Icon(
                Icons.note, // Example: Use a Facebook icon
              )),
          NavigationDestination(
              label: 'Accounts',
              tooltip: 'Accounts',
              icon: Icon(
                Icons.account_box, // Example: Use a Facebook icon
              )),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}

class ScaffoldWithNavigationRail extends StatelessWidget {
  const ScaffoldWithNavigationRail({
    super.key,
    required this.body,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });
  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 250,
            color: AppColors.primaryBg,
            child: NavigationRail(
              backgroundColor: AppColors.primaryBg,
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationSelected,
              extended: true,
              labelType: NavigationRailLabelType.none,
              leading: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.transparent,
                          radius: 30,
                          child: Image.asset(logoIcon),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('TIM DIGITAL',
                            style: TextStyle(
                              fontFamily: 'Researcher',
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 20,
                    endIndent: 20,
                  ),
                ],
              ),
              destinations: <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: selectedIndex == 0
                          ? Colors.blue
                          : AppColors.primaryBg,
                    ),
                    child: SvgPicture.asset(
                      "/icons/dashboard.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 0 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Dashboard',
                    style: navTextStyle,
                  ),
                ),
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: selectedIndex == 1
                          ? Colors.blue
                          : AppColors.primaryBg,
                    ),
                    child: SvgPicture.asset(
                      "/icons/business.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 1 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Manage Business',
                    style: navTextStyle,
                  ),
                ),
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: selectedIndex == 2
                          ? Colors.blue
                          : AppColors.primaryBg,
                    ),
                    child: SvgPicture.asset(
                      "/icons/travel.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 2 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Manage Travellers',
                    style: navTextStyle,
                  ),
                ),
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: selectedIndex == 3
                          ? Colors.blue
                          : AppColors.primaryBg,
                    ),
                    child: SvgPicture.asset(
                      "/icons/business.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 3 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Content Management',
                    style: navTextStyle,
                  ),
                ),
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: selectedIndex == 4
                          ? Colors.blue
                          : AppColors.primaryBg,
                    ),
                    child: SvgPicture.asset(
                      "/icons/business.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 4 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Accounts',
                    style: navTextStyle,
                  ),
                ),
                NavigationRailDestination(
                  icon: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      color: selectedIndex == 5
                          ? Colors.blue
                          : AppColors.primaryBg,
                    ),
                    child: SvgPicture.asset(
                      "/icons/logout.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 5 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Logout',
                    style: navTextStyle,
                  ),
                ),
              ],
            ),
          ),

          // This is the main content.
          Expanded(
            child: body,
          ),
        ],
      ),
    );
  }
}

/// Widget for the root/initial pages in the bottom navigation bar.
class RootScreen extends StatelessWidget {
  /// Creates a RootScreen
  const RootScreen({required this.label, required this.detailsPath, Key? key})
      : super(key: key);

  /// The label
  final String label;

  /// The path to the detail page
  final String detailsPath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tab root - $label'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            // Text('Screen $label',
            //     style: Theme.of(context).textTheme.titleLarge),
            // const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () => context.go(detailsPath),
              child: const Text('View details'),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen for either the A or B screen.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    Key? key,
  }) : super(key: key);

  /// The label to display in the center of the screen.
  final String label;

  @override
  State<StatefulWidget> createState() => DetailsScreenState();
}

/// The state for DetailsScreen
class DetailsScreenState extends State<DetailsScreen> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details Screen - ${widget.label}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text('Details for ${widget.label} - Counter: $_counter',
                style: Theme.of(context).textTheme.titleLarge),
            const Padding(padding: EdgeInsets.all(4)),
            TextButton(
              onPressed: () {
                setState(() {
                  _counter++;
                });
              },
              child: const Text('Increment counter'),
            ),
          ],
        ),
      ),
    );
  }
}
