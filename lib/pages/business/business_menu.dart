import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/routes/router.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';
import 'package:tim_app/utils/styles.dart';

class BusinessMenu extends StatefulWidget {
  const BusinessMenu({super.key});

  @override
  State<BusinessMenu> createState() => _BusinessMenuState();
}

class _BusinessMenuState extends State<BusinessMenu> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
    );
  }
}

class ScaffoldWithNavigation extends StatelessWidget {
  const ScaffoldWithNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
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
              icon: Icon(
                Icons.explore_outlined, // Example: Use a Facebook icon
              )),
          NavigationDestination(
              label: 'Ads',
              tooltip: 'Advertisements',
              icon: Icon(
                Icons.ads_click, // Example: Use a Facebook icon
              )),
          NavigationDestination(
              label: 'Offers',
              tooltip: 'Special Offers',
              icon: Icon(
                Icons.discount_outlined, // Example: Use a Facebook icon
              )),
          NavigationDestination(
              label: 'Business',
              tooltip: 'Business Details',
              icon: Icon(
                Icons.work, // Example: Use a Facebook icon
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
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('TIM DIGITAL',
                            style: TextStyle(
                              fontFamily: 'Researcher',
                              fontSize: 17.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                  const Divider(
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
                      "/icons/travel.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 1 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Advertisement',
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
                      "/icons/discount.svg",
                      colorFilter: ColorFilter.mode(
                          selectedIndex == 2 ? Colors.white : Colors.blue,
                          BlendMode.srcIn),
                      height: 18,
                      width: 18, // Set the desired width
                    ),
                  ),
                  // selectedIcon: Icon(Icons.home),
                  label: Text(
                    'Special Offers',
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
                    'Business Details',
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
                    'Back to Traveller',
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
