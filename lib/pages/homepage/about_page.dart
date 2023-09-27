// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/firebase/userDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/widgets/appbar.dart';

import '../../ads_footer.dart';
import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';
import '../../widgets/navBar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    if (user == null) {
      userProvider.loadDataFromSharedPref();
      user = userProvider.userData;
    }
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(mainBg),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              user!.docID!.isEmpty || user.docID == null
                  ? NavBar()
                  : CustomAppBar(title: 'hs'),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: Responsive.isDesktop(context) ? w / 10 : w / 20,
                    vertical: 5),
                child: Responsive.isDesktop(context)
                    ? DesktopContainer1()
                    : MobileContainer1(),
              ),
              AdsFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

class DesktopContainer1 extends StatelessWidget {
  const DesktopContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
            child: Container(
          // color: Colors.red,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About Us',
                style: AppTheme.getSecondaryTextStyle(50.0),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'See how Whisper can help you in promoting your business',
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu nibh nec augue blandit condimentum sed sed turpis.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu nibh nec augue blandit condimentum sed sed turpis. Quisque suscipit orci non velit tempus, eget congue leo tincidunt. Nullam lobortis nisi vulputate posuere rhoncus. Donec rutrum felis vel mauris molestie, eget tincidunt elit pellentesque. Cras maximus lectus vitae ante malesuada, ac rutrum tortor tempus. Aenean et tellus lacus. Duis viverra elementum dolor sit amet accumsan. Praesent nec rhoncus eros.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                color: Colors.white,
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: SizedBox(
                  height: 60,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: ElevatedButton(
                      style: elevatedButtonStyle,
                      onPressed: () {
                        GoRouter.of(context).go('/about');
                      },
                      child: const Text(
                        'REGISTER HERE',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
        Expanded(
          child: Container(
              height: 460,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(homepageTim), fit: BoxFit.contain))),
        ),
      ],
    );
  }
}

class MobileContainer1 extends StatelessWidget {
  const MobileContainer1({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: h! / 3,
            width: w! / 2,
            child: const Padding(
              padding: EdgeInsets.only(bottom: 30),
              child: Image(
                image: AssetImage(homepageTim),
                fit: BoxFit.contain,
              ),
            ),
          ),
          //const SizedBox(height: 30),
          Center(
            child: Text(
              'About Us',
              style: AppTheme.getSecondaryTextStyle(30.0),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            'See how Whisper can help you in promoting your business',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu nibh nec augue blandit condimentum sed sed turpis.',
            textAlign: TextAlign.justify,
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu nibh nec augue blandit condimentum sed sed turpis. Quisque suscipit orci non velit tempus, eget congue leo tincidunt. Nullam lobortis nisi vulputate posuere rhoncus. Donec rutrum felis vel mauris molestie, eget tincidunt elit pellentesque. Cras maximus lectus vitae ante malesuada, ac rutrum tortor tempus. Aenean et tellus lacus. Duis viverra elementum dolor sit amet accumsan. Praesent nec rhoncus eros.',
            textAlign: TextAlign.justify,
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            color: Colors.white,
          ),
          const SizedBox(
            height: 20,
          ),
          Center(
            child: SizedBox(
              height: 60,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () {
                    GoRouter.of(context).go('/about');
                  },
                  child: const Text(
                    'REGISTER HERE',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
