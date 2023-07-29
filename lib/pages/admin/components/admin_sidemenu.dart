import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';

class AdminSideMenu extends StatefulWidget {
  const AdminSideMenu({super.key});

  @override
  State<AdminSideMenu> createState() => _AdminSideMenuState();
}

class _AdminSideMenuState extends State<AdminSideMenu> {
  @override
  Widget build(BuildContext context) {
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
              press: () {
                // GoRouter.of(context).go('/dashboard');
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Manage Businesses",
              svgSrc: "/icons/business.svg",
              press: () {
                GoRouter.of(context).go('/business-details');
              },
            ),
            DrawerListTile(
              title: "Manage Travellers",
              svgSrc: "/icons/travel.svg",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Manage Special Offers",
              svgSrc: "/icons/discount.svg",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Manage Advertisement",
              svgSrc: "/icons/payment.svg",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Manage News",
              svgSrc: "/icons/payment.svg",
              press: () {},
            ),
            const SizedBox(
              height: 10,
            ),
            DrawerListTile(
              title: "Sign out",
              svgSrc: "/icons/logout.svg",
              press: () {
                GoRouter.of(context).go('/dashboard');
              },
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
