import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  double rating = 0;
  String ratingDescription = '';

  final Map<double, String> ratingDescriptions = {
    0: '',
    1: 'Poor',
    2: 'Fair',
    3: 'Average',
    4: 'Good',
    5: 'Excellent',
  };

  void _onRatingUpdate(double rating) {
    setState(() {
      this.rating = rating;
      ratingDescription = ratingDescriptions[rating] ?? '';
    });
  }

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    List<String> newItems = List.generate(itemsPerPage, (index) {
      int itemNumber = (currentPage - 1) * itemsPerPage + index + 1;
      return 'Item $itemNumber';
    });

    setState(() {
      items.addAll(newItems);
    });
  }

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
                      const Expanded(
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
                      const Expanded(
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
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.grey, // Outline color
                            width: 1.0, // Outline width
                          ),
                        ),
                        child: Column(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, // Button background color
                                foregroundColor:
                                    Colors.black, // Button text color
                              ),
                              onPressed: () {},
                              child: const Column(
                                children: [
                                  Icon(
                                    Icons.add_a_photo,
                                    size: 48.0, // Icon size
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    'Add Photo',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Row(
                              children: [
                                const Text(
                                  'Rate Experience: ', // Replace with your name or text
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                RatingBar.builder(
                                  minRating: 1,
                                  itemBuilder: (BuildContext context, _) =>
                                      const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: _onRatingUpdate,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  ratingDescription, // Replace with your name or text
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            const TextField(
                              decoration: InputDecoration(
                                hintText: 'Enter your comments here...',
                                border: OutlineInputBorder(),
                              ),
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            if (currentPage == 1) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: ElevatedButton(
                  onPressed: loadMoreItems,
                  child: const Text('Load More'),
                ),
              );
            }
          }
        },
        separatorBuilder: (context, index) {
          return const Divider(); // Divider widget after each ListTile
        },
      ),
    );
  }
}
