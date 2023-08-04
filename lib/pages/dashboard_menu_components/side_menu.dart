import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';

import '../../backend/firebase/userDataProvider.dart';
import '../../model/UserModel.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    userDataProvider.loadDataFromSharedPref();
    UserModel? user = userDataProvider.userData;
    return Drawer(
      backgroundColor: AppColors.primaryBg,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: ListView(
          children: [
            DrawerHeader(
              child: Image.asset(logo),
            ),
            DrawerListTile(
              title: "Dashboard",
              svgSrc: "/icons/dashboard.svg",
              // selectedRoute: selectedRoute == '/',
              press: () {
                GoRouter.of(context).go('/dashboard');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Travel Plan",
              svgSrc: "/icons/travel.svg",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Travel History",
              svgSrc: "/icons/history.svg",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Trip Reviews",
              svgSrc: "/icons/travel.svg",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            user?.hasBusiness == false
                ? DrawerListTile(
                    title: "Apply for Business",
                    svgSrc: "/icons/business.svg",
                    press: () {
                      GoRouter.of(context).go('/apply-business');
                    },
                  )
                : DrawerListTile(
                    title: "Manage Business",
                    svgSrc: "/icons/business.svg",
                    press: () {
                      GoRouter.of(context).go('/business-dashboard');
                    },
                  ),
            const SizedBox(
              height: defaultPadding,
            ),
            const Divider(color: Colors.white70),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Profile",
              svgSrc: "/icons/profile.svg",
              press: () {
                GoRouter.of(context).go('/profile');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Settings",
              svgSrc: "/icons/settings.svg",
              press: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    // required this.selectedRoute,
    // required this.selectedRoute,
  }) : super(key: key);

  final String title, svgSrc;
  // final String selectedRoute;

  // final bool selectedRoute;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      // selected: selectedRoute,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        height: 18,
        width: 18, // Set the desired width
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
