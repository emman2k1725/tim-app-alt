// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/responsive.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/outlinedButton.dart';

import '../admin/content_management/manage_how_it_works/components/manage_video.dart';

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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TabletButtonContainers(),
              ],
            )
          : Column(
              children: [
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
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ShadowButton(
            icon: Icons.book_outlined,
            text: 'How It Works',
            onPressed: () {
              GoRouter.of(context).go('/how-it-works');
            },
          ),
          ShadowButton(
            icon: Icons.newspaper_outlined,
            text: 'Latest News',
            onPressed: () {
              GoRouter.of(context).go('/latest-news');
            },
          ),
          ShadowButton(
            icon: Icons.discount_outlined,
            text: 'Special Offer',
            onPressed: () {
              GoRouter.of(context).go('/special-offers');
            },
          ),
          ShadowButton(
            icon: Icons.travel_explore_outlined,
            text: 'City Guide',
            onPressed: () {
              GoRouter.of(context).go('/city-guide');
            },
          ),
        ],
      ),
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
          onPressed: () {
            GoRouter.of(context).go('/special-offers');
          },
        ),
        SizedBox(height: 40),
        ShadowButton(
          icon: Icons.travel_explore_outlined,
          text: 'City Guide',
          onPressed: () {
            GoRouter.of(context).go('/city-guide');
          },
        ),
      ],
    );
  }
}
