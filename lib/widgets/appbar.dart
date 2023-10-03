import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/authservice/authentication.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/homepage/about_page.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  UserModel? user;

  @override
  void initState() {
    super.initState();
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      setState(() {
        user = UserModel.fromMap(jsonDecode(pref.getString('user')!));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Authenticate auth = Authenticate();
    final List<String> optionTraveller = ['Account', 'Business', 'Sign out'];
    final Map<String, IconData> optionIcons = {
      'Account': Icons.account_circle,
      'Business': Icons.business,
      'Sign out': Icons.logout,
    };
    void _handleOptionSelected(String option) {
      // You can perform different actions for each option here
      switch (option) {
        case 'Account':
          GoRouter.of(context).go('/traveller-account');
          break;
        case 'Homepage':
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const AboutPage(),
            ),
          );
          break;
        case 'Business':
          GoRouter.of(context).go('/business');
          break;
        case 'Sign out':
          auth.signOut();
          GoRouter.of(context).go('/');
          break;
      }
    }

    return AppBar(
      backgroundColor: AppColors.primaryBg,
      elevation: 2,
      actions: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10 / 2,
              ),
              decoration: BoxDecoration(
                color: AppColors.primaryText,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      width:
                          50, // Set the desired width for the circular avatar
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blue, // Set the color of the border
                          width: 1.0, // Set the width of the border
                        ),
                        shape: BoxShape.circle,
                        image: const DecorationImage(
                          image: AssetImage(
                              profile), // Replace 'your_image.png' with the actual image path
                          fit: BoxFit
                              .cover, // Choose the appropriate fit option for your design
                        ),
                      ),
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10 / 2),
                      child: Text(
                        user?.firstName ?? 'user',
                        style: const TextStyle(
                          fontSize: 16.0, // Set the font size
                          color: Colors.blue, // Set the text color
                        ),
                      ),
                    ),
                  PopupMenuButton<String>(
                    child: const Center(
                      child: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.blue, // Change the icon color
                      ),
                    ),
                    itemBuilder: (BuildContext context) {
                      return optionTraveller.map((String option) {
                        return PopupMenuItem<String>(
                          value: option,
                          child: ListTile(
                            leading: Icon(optionIcons[option]),
                            title: Text(option),
                            onTap: () {
                              _handleOptionSelected(option);
                            },
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
