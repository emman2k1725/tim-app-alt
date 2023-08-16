import 'package:flutter/material.dart';
import 'package:tim_app/utils/constants.dart';

class HistoryReviewsList extends StatefulWidget {
  const HistoryReviewsList({super.key});

  @override
  _HistoryReviewsListState createState() => _HistoryReviewsListState();
}

class _HistoryReviewsListState extends State<HistoryReviewsList> {
  final int itemsPerPage = 10; // Number of items to load per page
  int currentPage = 1;
  List<String> items = [];

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  // Simulated API call to fetch items for the current page
  Future<void> loadItems() async {
    // Simulated delay to mimic API call
    await Future.delayed(Duration(seconds: 1));

    // Replace this with your actual API call or data loading logic
    List<String> newItems = List.generate(itemsPerPage, (index) {
      int itemNumber = (currentPage - 1) * itemsPerPage + index + 1;
      return 'Item $itemNumber';
    });

    setState(() {
      items.addAll(newItems);
    });
  }

  // Load more items when user reaches the end of the list
  Future<void> loadMoreItems() async {
    currentPage++;
    await loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.separated(
        itemCount: items.length + 1, // Add 1 for loading indicator at the end
        itemBuilder: (context, index) {
          if (index < items.length) {
            return ExpansionTile(
              onExpansionChanged: (value) {},
              title: ListTile(
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipOval(
                              child: Container(
                                width: 50,
                                height: 50,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 1.0,
                                  ),
                                  shape: BoxShape.circle,
                                  image: const DecorationImage(
                                    image: AssetImage(profile),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Seafood Unli', // Replace with your name or text
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                Icon(
                                  Icons.star_half,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '4.5', // Replace with your name or text
                                  style: TextStyle(
                                    fontSize: 10.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(children: [
                              Text(
                                'Visited time: 8:00 AM', // Replace with your name or text
                                style: TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ]),
                            Text(
                              'What a delightful seafood experience! The freshness of the catch truly shines through in every dish, and the flavors are a true testament to their culinary expertise',
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                              // Other text style properties can be added here
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            if (currentPage == 1) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: loadMoreItems,
                  child: Text('Load More'),
                ),
              );
            }
          }
        },
        separatorBuilder: (context, index) {
          return Divider(); // Divider widget after each ListTile
        },
      ),
    );
  }
}
