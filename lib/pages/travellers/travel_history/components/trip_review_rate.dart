import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/backend/travel_plan/travelPlanFunction.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/loading.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class HistoryReviewsList extends StatefulWidget {
  final placeVisited;
  final fromDocID;
  final tripHistory;
  const HistoryReviewsList(
      {super.key,
      required this.tripHistory,
      required this.placeVisited,
      required this.fromDocID});

  @override
  _HistoryReviewsListState createState() => _HistoryReviewsListState();
}

class _HistoryReviewsListState extends State<HistoryReviewsList> {
  final int itemsPerPage = 10; // Number of items to load per page
  int currentPage = 1;
  List<String> items = [];
  double rating = 0;
  String ratingDescription = '';
  String? comment;
  UserModel? user;
  File? _pickedImage;
  Uint8List? _webPickedImage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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

  Future<bool> updatedRate(
      String placeID, String docID, String date, dynamic itenerary) async {
    bool flag = false;
    try {
      for (int x = 0; x < itenerary.length; x++) {
        if (date == itenerary[x]['dateSchedule'] &&
            placeID == itenerary[x]['placeID']) {
          itenerary[x]['ifRated'] = true;
          flag = true;
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    bool updatedIteneraryRes = await updateItenerary(itenerary, docID);
    return updatedIteneraryRes;
  }

  Future<Uint8List?> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();

      setState(() {
        _webPickedImage = f;
        _pickedImage = File('a');
      });
    }
    return null;
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
        itemCount: widget
            .placeVisited.length, // Add 1 for loading indicator at the end
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
                              widget.placeVisited[index][
                                  'businessName'], // Replace with your name or text
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                const Icon(
                                  Icons.star_half,
                                  color: Colors.yellow,
                                  size: 15,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.placeVisited[index]['rating']
                                      .toString(), // Replace with your name or text
                                  style: const TextStyle(
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
                                'Visited time and date: ${widget.placeVisited[index]['dateSchedule']} at ${widget.placeVisited[index]['timeSchedule']}', // Replace with your name or text
                                style: const TextStyle(
                                  fontSize: 12.0,
                                ),
                              ),
                            ]),
                            Text(
                              widget.placeVisited[index]['description'],
                              textAlign: TextAlign.left,
                              softWrap: true,
                              style: const TextStyle(
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
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                              _pickedImage == null
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .white, // Button background color
                                        foregroundColor:
                                            Colors.black, // Button text color
                                      ),
                                      onPressed: () {
                                        _pickImage();
                                      },
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
                                    )
                                  : Image.memory(_webPickedImage!,
                                      fit: BoxFit.fill,
                                      width: 140,
                                      height: 110),
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
                              TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Enter your comments here...',
                                  border: OutlineInputBorder(),
                                ),
                                maxLines: 3,
                                onSaved: (value) {
                                  value == null
                                      ? comment = ""
                                      : comment = value;
                                },
                              ),
                              const SizedBox(height: 16.0),
                              ElevatedButton(
                                onPressed: () async {
                                  showCustomLoadingDialog(
                                      context, 'Posting your review...');
                                  formKey.currentState!.save();
                                  String? photoURL;
                                  // PhotoUpload and get URL
                                  if (_webPickedImage != null) {
                                    photoURL = (await uploadReviewImage(
                                        _webPickedImage,
                                        "reviews/${user!.docID}"))!;
                                  }

                                  Map<String, dynamic> ratingData = {
                                    "rating": rating,
                                    "comment": comment,
                                    "placeID": widget.placeVisited[index]
                                        ['placeID'],
                                    "nameOfRater":
                                        "${user?.firstName} ${user?.lastName}",
                                    "idOfRater": user?.docID,
                                    "photoURL": photoURL
                                  };
                                  bool ratePlaceRes =
                                      await ratePlace(ratingData);
                                  if (ratePlaceRes == true) {
                                    updatedRate(
                                            widget.placeVisited[index]
                                                ['placeID'],
                                            widget.fromDocID,
                                            widget.placeVisited[index]
                                                ['dateSchedule'],
                                            widget.tripHistory)
                                        .then((value) {
                                      if (value == true) {
                                        Navigator.pop(context);
                                        const SuccessDialog(
                                            title:
                                                'Review successfully posted!');
                                      }
                                    });
                                  } else {
                                    // error dialog here
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          ),
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
