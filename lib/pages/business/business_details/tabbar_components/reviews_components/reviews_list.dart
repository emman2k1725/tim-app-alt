// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';

class ReviewsList extends StatefulWidget {
  @override
  _ReviewsListState createState() => _ReviewsListState();
}

class _ReviewsListState extends State<ReviewsList> {
  final int itemsPerPage = 10; // Number of items to load per page
  int currentPage = 1;
  List<String> items = [];
  UserModel? user;
  @override
  void initState() {
    super.initState();
    loadItems();
    loadNewLaunch();
  }

  loadNewLaunch() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (pref.getString('user') != null) {
      setState(() {
        user = UserModel.fromMap(jsonDecode(pref.getString('user')!));
      });
    }
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

  // Load more items when user reaches the end of the list
  Future<void> loadMoreItems() async {
    currentPage++;
    await loadItems();
  }

  @override
  Widget build(BuildContext context) {
    return !Responsive.isDesktop(context)
        ? mobileScreenSize()
        : StreamBuilder<List<Map<String, dynamic>>>(
            stream: getRecentReviews(user?.docID),
            builder: (context, snapshot) {
              List<Map<String, dynamic>> reviewList = snapshot.data!;
              return ListView.separated(
                shrinkWrap: true,
                itemCount:
                    reviewList.length, // Add 1 for loading indicator at the end
                itemBuilder: (context, index) {
                  if (index < reviewList.length) {
                    return ListTile(
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
                                        shape: BoxShape.rectangle,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              emptyImage), //rewviewList[index]['photoURL]
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
                                    reviewList[index]['nameOfRater'] ??
                                        "", // Replace with your name or text
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    reviewList[index]['businessName'] ??
                                        "", // Replace with your name or text
                                    style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                    RatingBar.builder(
                                        initialRating: double.parse(
                                            reviewList[index]['rating']
                                                .toString()),
                                        ignoreGestures: true,
                                        minRating: 0,
                                        direction: Axis.horizontal,
                                        allowHalfRating: true,
                                        itemCount: 5,
                                        itemSize: 20.0,
                                        itemBuilder: (context, _) => const Icon(
                                            Icons.star,
                                            color: Colors.yellow),
                                        onRatingUpdate: (rating) {}),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      reviewList[index]['createdAt'] ??
                                          "", // Replace with your name or text
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ]),
                                  Text(
                                    reviewList[index]['comment'],
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                    style: TextStyle(
                                      color: Colors.white,
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
              );
            });
  }

  Widget mobileScreenSize() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: items.length + 1, // Add 1 for loading indicator at the end
      itemBuilder: (context, index) {
        if (index < items.length) {
          return ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Traveller', // Replace with your name or text
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "${user!.firstName!} ${user!.lastName!}", // Replace with your name or text
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user!.email!, // Replace with your name or text
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star_half_sharp,
                                color: Colors.yellow,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ]),
                            Text(
                              '2023-08-02', // Replace with your name or text
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20),
                        Text(
                          'What a delightful seafood experience! The freshness of the catch truly shines through in every dish, and the flavors are a true testament to their culinary expertise',
                          textAlign: TextAlign.left,
                          softWrap: true,
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.white,
                          ),
                          // Other text style properties can be added here
                        ),
                      ],
                    ),
                  ),
                ],
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
    );
  }
}
