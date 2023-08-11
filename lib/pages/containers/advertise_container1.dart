// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/widgets/blurContainer.dart';

import '../../responsive.dart';
import '../../utils/appTheme_style.dart';
import '../../utils/constants.dart';
import '../../utils/styles.dart';

class AdvertiseContainer1 extends StatefulWidget {
  const AdvertiseContainer1({super.key});

  @override
  State<AdvertiseContainer1> createState() => _AdvertiseContainer1State();
}

class _AdvertiseContainer1State extends State<AdvertiseContainer1> {
  List<String> title = [
    "HOMEPAGE ADVERT",
    "SUBPAGE ADVERT",
    "NEWSLETTER ADVERT",
    "MOBILE APP ADVERT"
  ];

  List<String> images = [
    homepageAdvert,
    subpageAdvert,
    newsletterAdvert,
    mobileAppAdvert
  ];

  int currentIndex = 0;
  final CarouselController carouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(
            horizontal: Responsive.isDesktop(context) ? w! / 30 : w! / 30,
            vertical: 5),
        child: Responsive.isDesktop(context)
            ? desktopContainer1()
            : mobileContainer1(Responsive.isTablet(context) ? h! / 2 : h! / 4),
      ),
    );
  }

  //============== DESKTOP =============
  Widget desktopContainer1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Advertise With Us',
            style: AppTheme.getSecondaryTextStyle(50.0),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w! / 6),
          child: Divider(
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus justo est, quis fringilla sapien maximus sed. Aliquam elit neque,',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 30,
        ),
        Wrap(
          spacing: 30, // Adjust as needed
          runSpacing: 30,
          children: List.generate(title.length, (index) {
            return SizedBox(
              width: w! / 5,
              child: BlurContainer(
                childColumn: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: double.infinity),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: h! / 4,
                          width: w! / 6,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              image: DecorationImage(
                                  image: AssetImage(images[index]),
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(height: 20),
                        Text(
                          title[index],
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          width: w! / 6,
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus justo est, quis fringilla sapien maximus sed. Aliquam elit neque, feugiat et dolor sed, blandit imperdiet leo.",
                            textAlign: TextAlign.justify,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.normal),
                          ),
                        ),
                        SizedBox(height: 20),
                        Center(
                          child: SizedBox(
                            height: 60,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: ElevatedButton(
                                style: elevatedButtonStyle,
                                onPressed: () {},
                                child: const Text(
                                  'ADVERTISE',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  //================ MOBILE ===============
  Widget mobileContainer1(double imageHeight) {
    return Column(
      children: [
        Center(
          child: Text(
            'Advertise With Us',
            style: AppTheme.getSecondaryTextStyle(30.0),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 15,
        ),
        Divider(
          color: Colors.white,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus justo est, quis fringilla sapien maximus sed. Aliquam elit neque,',
          textAlign: TextAlign.justify,
          style: TextStyle(
              color: Colors.white, fontSize: 12, fontWeight: FontWeight.normal),
        ),
        SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: h! / 4),
              child: IconButton(
                icon:
                    Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
                onPressed: () {
                  carouselController.previousPage();
                },
              ),
            ),
            Expanded(
              child: CarouselSlider(
                items: images.map((item) {
                  int index = images.indexOf(item);
                  return carouselItem(item, title[index], imageHeight);
                }).toList(),
                carouselController: carouselController,
                options: CarouselOptions(
                  height: h!,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                    print("$currentIndex");
                    print(title[index]);
                  },

                  aspectRatio: 16 /
                      9, // Set the aspect ratio to match your item's aspect ratio
                  viewportFraction:
                      1.0, // Adjust this value to control the width of the items
                  autoPlay:
                      false, // Disable auto-play when using manual navigation
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: h! / 4),
              child: IconButton(
                icon:
                    Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
                onPressed: () {
                  carouselController.nextPage();
                },
              ),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }

  Widget carouselItem(String images, String title, double imageHeight) {
    return SizedBox(
      width: w! / 1,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: BlurContainer(
          childColumn: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  height: imageHeight, // h! / 4,
                  width: w! / 2,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      image: DecorationImage(
                          image: AssetImage(images), fit: BoxFit.cover)),
                ),
                SizedBox(height: 20),
                Text(
                  title,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 25),
                SizedBox(
                  width: w! / 2,
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed maximus justo est, quis fringilla sapien maximus sed. Aliquam elit neque, feugiat et dolor sed, blandit imperdiet leo.",
                    textAlign: TextAlign.justify,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 60,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: ElevatedButton(
                        style: elevatedButtonStyle,
                        onPressed: () {},
                        child: const Text(
                          'ADVERTISE',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
