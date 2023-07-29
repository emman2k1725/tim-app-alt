import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';

class BusinessSideMenu extends StatefulWidget {
  const BusinessSideMenu({super.key});

  @override
  State<BusinessSideMenu> createState() => _BusinessSideMenuState();
}

class _BusinessSideMenuState extends State<BusinessSideMenu> {
  String _selectedTitle = "Dashboard"; // Default selected title

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
                _selectItem("Dashboard");
                GoRouter.of(context).go('/business-dashboard');

                setState(() {
                  _selectedTitle = "Dashboard";
                });
              },
              selected: _selectedTitle == "Dashboard",
            ),
            const SizedBox(height: 10),
            DrawerListTile(
              title: "Advertisement",
              svgSrc: "/icons/travel.svg",
              press: () {
                _selectItem("Advertisement");
              },
              selected: _selectedTitle == "Advertisement",
            ),
            const SizedBox(height: 10),
            DrawerListTile(
              title: "Special Offers",
              svgSrc: "/icons/discount.svg",
              press: () {
                _selectItem("Offers");
              },
              selected: _selectedTitle == "Offers",
            ),
            const SizedBox(height: 10),
            DrawerListTile(
              title: "Business Details",
              svgSrc: "/icons/business.svg",
              press: () {
                _selectItem("BusinessDetails");
                GoRouter.of(context).go('/About');
                setState(() {
                  _selectedTitle = "BusinessDetails";
                });
              },
              selected: _selectedTitle == "BusinessDetails",
            ),
            const SizedBox(height: 10),
            DrawerListTile(
              title: "Payment",
              svgSrc: "/icons/payment.svg",
              press: () {
                _selectItem("Payment");
              },
              selected: _selectedTitle == "Payment",
            ),
            DrawerListTile(
              title: "Logout",
              svgSrc: "/icons/logout.svg",
              press: () {
                _selectItem("Logout");
                GoRouter.of(context).go('/homepage');
              },
              selected: _selectedTitle == "Logout",
            ),
          ],
        ),
      ),
    );
  }

  void _selectItem(String title) {
    setState(() {
      _selectedTitle = title;
    });
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.press,
    required this.selected,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      selected: selected,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(
          selected
              ? Colors.blue
              : Colors.white54, // Change icon color based on selected state
          BlendMode.srcIn,
        ),
        height: 18,
        width: 18,
      ),
      title: Text(
        title,
        style: TextStyle(color: selected ? Colors.blue : Colors.white54),
      ),
    );
  }
}
