import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
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
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: context.read<MenuAppController>().controlMenu,
            ),
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
        navButton('Home'),
        navButton('About'),
        navButton('Media'),
        navButton('Advertisement'),
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

  Widget navButton(String text) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: TextButton(
            onPressed: () {},
            child: Text(text,
                style: const TextStyle(color: Colors.white, fontSize: 18))));
  }

  Widget navLogo() {
    return Container(
      width: 110,
      decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage(logo), fit: BoxFit.contain)),
    );
  }
}
