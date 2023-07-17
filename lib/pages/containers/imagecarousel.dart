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
          Expanded(child: SizedBox(height: 300, child: VideoPlayerScreen())),
          const SizedBox(
            width: 100,
          ),
          Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  ShadowButton(
                    icon: Icons.book_outlined,
                    text: 'How It Works',
                    onPressed: () {
                      // Add your button onPressed logic here
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ShadowButton(
                    icon: Icons.newspaper_outlined,
                    text: 'Latest News',
                    onPressed: () {
                      // Add your button onPressed logic here
                    },
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 50,
                  ),
                  ShadowButton(
                    icon: Icons.discount_outlined,
                    text: 'Special Offer',
                    onPressed: () {
                      // Add your button onPressed logic here
                    },
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  ShadowButton(
                    icon: Icons.travel_explore_outlined,
                    text: 'Travel Planning',
                    onPressed: () {
                      // Add your button onPressed logic here
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
