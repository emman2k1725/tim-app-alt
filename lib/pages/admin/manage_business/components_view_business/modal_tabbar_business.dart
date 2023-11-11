import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/manage_business/components_view_business/tabbar_business_reviews.dart';
import 'package:tim_app/widgets/blurContainer.dart';

import 'tabbar_business_details.dart';
import 'tabbar_transaction.dart';

class ModalTabbarBusiness extends StatefulWidget {
  final Map<String, dynamic> item;
  const ModalTabbarBusiness({super.key, required this.item});

  @override
  State<ModalTabbarBusiness> createState() => _ModalTabbarBusinessState();
}

class _ModalTabbarBusinessState extends State<ModalTabbarBusiness>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: BlurContainer(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height,
        childColumn: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              controller: _tabController,
              tabs: [
                Tab(text: 'Business Details'),
                Tab(text: 'Business Reviews'),
                Tab(text: 'Business Transaction'),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.height * 0.70,
              child: TabBarView(
                controller: _tabController,
                children: [
                  SingleChildScrollView(
                    child: Column(children: [TabbarDetails(item: widget.item)]),
                  ),
                  SingleChildScrollView(
                    child: Column(
                        children: [ViewBusinessReviews(item: widget.item)]),
                  ),
                  SingleChildScrollView(
                    child:
                        Column(children: [TransactionView(item: widget.item)]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            //  Navigator.of(context).pop();
          },
          child: Text('Close'),
        ),
      ],
    );
  }
}
