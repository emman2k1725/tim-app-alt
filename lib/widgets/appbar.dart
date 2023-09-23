import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/controllers/menuAppController.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';

import '../../backend/firebase/userDataProvider.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({super.key, required this.title});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    if (user == null) {
      userProvider.loadDataFromSharedPref();
      user = userProvider.userData;
    }

    final List<String> optionTraveller = [
      'Account',
      'Option 2',
      'Option 3',
      'Option 4'
    ];

    final List<String> optionBusiness = [
      'Account',
      'Option 2',
      'Option 3',
      'Option 4'
    ];

    final Map<String, IconData> _optionIcons = {
      'Account': Icons.account_circle,
      'Option 2': Icons.favorite,
      'Option 3': Icons.thumb_up,
      'Option 4': Icons.thumb_down,
    };
    void _handleOptionSelected(String option) {
      // You can perform different actions for each option here
      switch (option) {
        case 'Account':
          GoRouter.of(context).go('/media');
          break;
        case 'Option 2':
          break;
        case 'Option 3':
          // Handle Option 3 action
          break;
        case 'Option 4':
          // Handle Option 4 action
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
                    child: Container(
                      child: Center(
                        child: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blue, // Change the icon color
                        ),
                      ),
                    ),
                    itemBuilder: (BuildContext context) {
                      return optionTraveller.map((String option) {
                        return PopupMenuItem<String>(
                          value: option,
                          child: ListTile(
                            leading: Icon(_optionIcons[option]),
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
