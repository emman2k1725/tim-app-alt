import 'package:flutter/material.dart';

import 'tabbar_business_details.dart';

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
      title: Text(widget.item['businessName'].toString()),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.80,
        height: MediaQuery.of(context).size.height,
        child: Column(
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
                Tab(text: 'Tab 3'),
              ],
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.80,
              height: MediaQuery.of(context).size.height * 0.60,
              child: TabBarView(
                controller: _tabController,
                children: [
                  //tabbar 1
                  SingleChildScrollView(
                    child: Column(children: [TabbarDetails(item: widget.item)]),
                  ),
                  // SingleChildScrollView(
                  //     child: TabbarDetails(item: widget.item)),

                  Center(child: Text('Content for Tab 2')),
                  Center(child: Text('Content for Tab 3')),
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
