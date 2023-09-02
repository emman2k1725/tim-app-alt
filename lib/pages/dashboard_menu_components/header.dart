import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/controllers/menuAppController.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/utils/colors.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (!Responsive.isDesktop(context))
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: context.read<MenuAppController>().controlMenu,
          ),
        if (!Responsive.isMobile(context))
          // Text(
          //   "Dashboard",
          //   style: Theme.of(context).textTheme.titleLarge,
          // ),
          if (!Responsive.isMobile(context))
            Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
        const Expanded(child: SearchField()),
        const ProfileCard()
      ],
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider userDataProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userDataProvider.userData;

    return Container(
      margin: const EdgeInsets.only(left: 10),
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
        children: [
          ClipOval(
            child: Container(
              width: 50, // Set the desired width for the circular avatar
              height: 40,
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
              child: Text(user!.firstName ?? 'User'),
            ),
          const Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search",
        fillColor: AppColors.primaryText,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            // decoration: BoxDecoration(
            //   color: Colors.grey,
            //   borderRadius: const BorderRadius.all(Radius.circular(10)),
            // ),
            child: SvgPicture.asset("/icons/search.svg"),
          ),
        ),
      ),
    );
  }
}
