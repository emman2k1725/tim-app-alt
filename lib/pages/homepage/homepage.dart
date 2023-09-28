// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/pages/containers/container1.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/pages/containers/imagecarousel.dart';
import 'package:tim_app/widgets/navBar.dart';

import '../../ads_footer.dart';
import '../../navBarProvider.dart';
import '../../responsive.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color(0xFF333334),
        toolbarHeight: Responsive.isDesktop(context) ? 78 : 65,
        elevation: 4,
        titleSpacing: 0,
        title: NavBar(),
      ),
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
              // const NavBar(),
              const SizedBox(
                height: 100,
              ),
              const Container1(),
              const SizedBox(
                height: 40,
              ),
              ImageCarousel(),
              const SizedBox(
                height: 20,
              ),
              AdsFooter(),
            ],
          ),
        ),
      ),
    );
  }
  // Widget build(BuildContext context) {
  //   w = MediaQuery.of(context).size.width;
  //   h = MediaQuery.of(context).size.height;
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: Column(
  //         mainAxisSize: MainAxisSize.max,
  //         children: [
  //           Container(
  //             width: MediaQuery.sizeOf(context).width * 1.0,
  //             height: MediaQuery.sizeOf(context).height * 1.0,
  //             decoration: const BoxDecoration(
  //               image: DecorationImage(
  //                 fit: BoxFit.cover,
  //                 image: AssetImage(mainBg),
  //               ),
  //             ),
  //             child: Column(
  //               children: [
  //                 NavBar(),
  //                 SizedBox(
  //                   height: 20,
  //                 ),
  //                 Container1(),
  //                 ImageCarousel(),
  //               ],
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
