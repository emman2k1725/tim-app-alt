// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/pages/containers/videoplayer.dart';
import 'package:tim_app/responsive.dart';
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
      child: Responsive.isDesktop(context)
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: SizedBox(height: 300, child: VideoPlayerScreen())),
                const SizedBox(
                  width: 100,
                ),
                TabletButtonContainers(),
              ],
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w! / 10),
                  child: SizedBox(height: 300, child: VideoPlayerScreen()),
                ),
                SizedBox(height: 40),
                Responsive.isTablet(context)
                    ? TabletButtonContainers()
                    : MobileButtonContainers(),
              ],
            ),
    );
  }
}

class TabletButtonContainers extends StatelessWidget {
  const TabletButtonContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadowButton(
              icon: Icons.book_outlined,
              text: 'How It Works',
              onPressed: () {
                GoRouter.of(context).go('/how-it-works');
              },
            ),
            const SizedBox(
              width: 50,
            ),
            ShadowButton(
              icon: Icons.newspaper_outlined,
              text: 'Latest News',
              onPressed: () {
                GoRouter.of(context).go('/latest-news');
              },
            ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShadowButton(
              icon: Icons.discount_outlined,
              text: 'Special Offer',
              onPressed: () {},
            ),
            const SizedBox(
              width: 50,
            ),
            ShadowButton(
              icon: Icons.travel_explore_outlined,
              text: 'Travel Planning',
              onPressed: () {},
            ),
          ],
        ),
      ],
    );
  }
}

class MobileButtonContainers extends StatelessWidget {
  const MobileButtonContainers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ShadowButton(
          icon: Icons.book_outlined,
          text: 'How It Works',
          onPressed: () {
            GoRouter.of(context).go('/how-it-works');
          },
        ),
        SizedBox(height: 40),
        ShadowButton(
          icon: Icons.newspaper_outlined,
          text: 'Latest News',
          onPressed: () {
            GoRouter.of(context).go('/latest-news');
          },
        ),
        SizedBox(height: 40),
        ShadowButton(
          icon: Icons.discount_outlined,
          text: 'Special Offer',
          onPressed: () {},
        ),
        SizedBox(height: 40),
        ShadowButton(
          icon: Icons.travel_explore_outlined,
          text: 'Travel Planning',
          onPressed: () {},
        ),
      ],
    );
  }
}
