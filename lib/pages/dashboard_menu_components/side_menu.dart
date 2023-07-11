import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryBg,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset(logo),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "/icons/dashboard.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Travel Plan",
            svgSrc: "/icons/travel.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Travel History",
            svgSrc: "/icons/history.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Trip Reviews",
            svgSrc: "/icons/travel.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Apply for Business",
            svgSrc: "/icons/business.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "/icons/profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "/icons/settings.svg",
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
        height: 24,
        width: 24, // Set the desired width
      ),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white54),
      ),
    );
  }
}
