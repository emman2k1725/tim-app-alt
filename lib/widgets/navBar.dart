import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:tim_app/pages/about_page.dart';
import 'package:tim_app/pages/homepage.dart';
import 'package:tim_app/pages/login.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/styles.dart';

import '../controllers/menuAppController.dart';
import '../responsive.dart';
import 'package:provider/provider.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    /* return ScreenTypeLayout(
      mobile: mobileNavBar(),
      desktop: deskTopNavBar(),
    );*/
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: Responsive.isDesktop(context) ? 40 : 20, vertical: 15),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          navLogo(),
          if (!Responsive.isDesktop(context) && !Responsive.isTablet(context))
            // IconButton(
            //   icon: const Icon(Icons.menu, color: Colors.white),
            //   onPressed: context.read<MenuAppController>().controlMenu,
            // ),
            subMenu(w, h),
          if (!Responsive.isMobile(context)) navBarItems(),
        ],
      ),
    );
  }

  Widget mobileNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [const Icon(Icons.menu), navLogo()],
      ),
    );
  }

  /*Widget deskTopNavBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          navLogo(),
          Row(
            children: [
              navButton('Home'),
              navButton('About'),
              navButton('Media'),
              navButton('Advertisement'),
              SizedBox(
                height: 45,
                child: ElevatedButton(
                    style: borderedButtonStyle,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginPage()));
                    },
                    child: Text(
                      'Get Started',
                      style: TextStyle(color: AppColors.primary),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }*/

  Widget navBarItems() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        navButton('Home', () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Home()));
        }),
        navButton('About', () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AboutPage()));
        }),
        navButton('Media', () {}),
        navButton('Advertisement', () {}),
        SizedBox(
          height: 45,
          child: ElevatedButton(
              style: borderedButtonStyle,
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: Text(
                'Get Started',
                style: TextStyle(color: AppColors.primary),
              )),
        )
      ],
    );
  }

  Widget navButton(String text, void Function()? onPressed) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: TextButton(
            onPressed: onPressed,
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 18))));
  }

  Widget navLogo() {
    return Container(
      width: 70,
      margin: EdgeInsets.only(bottom: 12),
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(logo), fit: BoxFit.contain)),
    );
  }

  Widget subMenu(double width, double height) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        customButton: const Icon(
          Icons.menu,
          color: Colors.white,
        ),
        items: [
          ...MenuItems.firstItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
          const DropdownMenuItem<Divider>(
              enabled: false,
              child: Divider(
                color: Colors.black12,
              )),
          ...MenuItems.secondItems.map(
            (item) => DropdownMenuItem<MenuItem>(
              value: item,
              child: MenuItems.buildItem(item),
            ),
          ),
        ],
        onChanged: (value) {
          MenuItems.onChanged(context, value! as MenuItem);
        },
        dropdownStyleData: DropdownStyleData(
          width: width,
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.white, //Colors.blue.shade900,
          ),
          offset: const Offset(0, -10),
        ),
        menuItemStyleData: MenuItemStyleData(
          customHeights: [
            ...List<double>.filled(MenuItems.firstItems.length, 48),
            8,
            ...List<double>.filled(MenuItems.secondItems.length, 48),
          ],
          padding: const EdgeInsets.only(left: 16, right: 16),
        ),
      ),
    );
  }
}

class MenuItem {
  const MenuItem({
    required this.text,
    required this.icon,
  });

  final String text;
  final IconData icon;
}

abstract class MenuItems {
  static const List<MenuItem> firstItems = [home, about, media, advertisement];
  static const List<MenuItem> secondItems = [getStarted];

  static const home = MenuItem(text: 'Home', icon: Icons.home);
  static const about = MenuItem(text: 'About', icon: Icons.help);
  static const media = MenuItem(text: 'Media', icon: Icons.image);
  static const advertisement =
      MenuItem(text: 'Advertisement', icon: Icons.video_collection);
  static const getStarted =
      MenuItem(text: 'Get Started', icon: Icons.ads_click);

  static Widget buildItem(MenuItem item) {
    return Row(
      children: [
        Icon(item.icon, color: Colors.black, size: 22),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Text(
            item.text,
            style: const TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }

  static void onChanged(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.home:
        //Do something
        break;
      case MenuItems.about:
        //Do something
        break;
      case MenuItems.media:
        //Do something
        break;
      case MenuItems.advertisement:
        //Do something
        break;
    }
  }
}
