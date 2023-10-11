import 'dart:convert';
import 'dart:ui';
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
      actions: [
        Row(
          children: [
            SizedBox(
              width: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 1, sigmaY: 2),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue.withOpacity(0.30),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 8.0,
                          spreadRadius: 1,
                          offset: Offset(0, 8.0),
                        ),
                      ],

                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white60.withOpacity(0.10),
                          Colors.blue.withOpacity(0.10),
                        ],
                      ),
                      // color: Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(10),
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
                                color:
                                    Colors.blue, // Set the color of the border
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10 / 2),
                            child: Text(
                              user?.firstName ?? 'user',
                              style: const TextStyle(
                                fontSize: 16.0, // Set the font size
                                color: Colors.white, // Set the text color
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
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
