import 'package:flutter/material.dart';
import 'package:tim_app/pages/containers/videoplayer.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/outlinedButton.dart';

class ImageCarousel extends StatefulWidget {
  @override
  _ImageCarouselState createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  final List<String> imageUrls = [
    timHand,
    homepageTim,
    mainBg,
  ];
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(child: SizedBox(height: 500, child: VideoPlayerScreen())),
          const Expanded(
            child: ShadowButton(),
          ),
        ],
      ),
    );
  }
}
