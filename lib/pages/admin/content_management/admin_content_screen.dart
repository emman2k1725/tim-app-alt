import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tim_app/pages/admin/content_management/components_special_offer/offer_listview.dart';
import 'package:tim_app/pages/admin/special_offers/offers_paginated.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class ContentManagementScreen extends StatefulWidget {
  const ContentManagementScreen({super.key});

  @override
  State<ContentManagementScreen> createState() =>
      _ContentManagementScreenState();
}

class _ContentManagementScreenState extends State<ContentManagementScreen> {
  Color shadowColor = Colors.blueAccent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(30.0),
          child: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () => context.go('/admin-manage-content/offer'),
                  child: BlurImageContainer(
                    height: 200,
                    width: 250,
                    text: 'Manage Special Offers',
                    icon: Icons
                        .discount_outlined, // Replace with the desired icon
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              BlurImageContainer(
                height: 200,
                width: 250,
                text: 'Manage Advertisement',
                icon: Icons.ads_click_outlined, // Replace with the desired icon
              ),
              SizedBox(
                width: 10,
              ),
              BlurImageContainer(
                height: 200,
                width: 250,
                text: 'Manage Newsletter',
                icon: Icons.newspaper_outlined, // Replace with the desired icon
              ),
              SizedBox(
                width: 10,
              ),
              BlurImageContainer(
                height: 200,
                width: 250,
                text: 'Manage Media',
                icon:
                    Icons.camera_alt_outlined, // Replace with the desired icon
              ),
            ],
          ),
        ),
        Container(height: 500, child: ListViewOfContainers()),
      ],
    );
  }
}
