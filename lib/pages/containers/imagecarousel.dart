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
    return StreamBuilder<QuerySnapshot>(
        stream: fetchTableContent('HowItWorks'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            final List<Map<String, dynamic>> data =
                snapshot.data!.docs.map((QueryDocumentSnapshot document) {
              Map<String, dynamic> documentData =
                  document.data() as Map<String, dynamic>;
              documentData['id'] =
                  document.id; // Add the document ID to the data map
              return documentData;
            }).toList();

            final aboutData = data[0];
            return Container(
              margin: EdgeInsets.symmetric(horizontal: w! / 10, vertical: 20),
              child: Responsive.isDesktop(context)
                  ? Row(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Expanded(
                              child: SizedBox(
                            height: 300,
                            /* child: VideoPlayerScreen(
                                videoUrl: aboutData['displayImage']) */
                          )),
                        ),
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
                          child: SizedBox(
                            height: 300,
                            child: VideoPlayerScreen(
                                videoUrl: aboutData['displayImage']),
                          ),
                        ),
                        SizedBox(height: 40),
                        Responsive.isTablet(context)
                            ? TabletButtonContainers()
                            : MobileButtonContainers(),
                      ],
                    ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        });
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
              onPressed: () {
                GoRouter.of(context).go('/special-offers');
              },
            ),
            const SizedBox(
              width: 50,
            ),
            ShadowButton(
              icon: Icons.travel_explore_outlined,
              text: 'Travel Planning',
              onPressed: () {
                GoRouter.of(context).go('/city-guide');
              },
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
          onPressed: () {
            GoRouter.of(context).go('/special-offers');
          },
        ),
        SizedBox(height: 40),
        ShadowButton(
          icon: Icons.travel_explore_outlined,
          text: 'Travel Planning',
          onPressed: () {
            GoRouter.of(context).go('/city-guide');
          },
        ),
      ],
    );
  }
}
