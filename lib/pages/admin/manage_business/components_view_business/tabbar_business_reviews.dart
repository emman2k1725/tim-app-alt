import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class ViewBusinessReviews extends StatefulWidget {
  final Map<String, dynamic> item;
  const ViewBusinessReviews({super.key, required this.item});

  @override
  State<ViewBusinessReviews> createState() => _ViewBusinessReviewsState();
}

class _ViewBusinessReviewsState extends State<ViewBusinessReviews> {
  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> ratings =
        List<Map<String, dynamic>>.from(widget.item['ratings']);

    double calculateDisplayedRating(double actualRating) {
      if (actualRating > 4.5 && actualRating != 5.00) {
        return 4.5;
      }
      return actualRating;
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: ratings.length,
      itemBuilder: (context, ratingIndex) {
        Map<String, dynamic> rating = ratings[ratingIndex];
        double ratingScore = double.parse(rating['rating'].toString());
        double displayedRating = calculateDisplayedRating(ratingScore);
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: BlurExpanded(
              width: double.maxFinite,
              childColumn: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(
                    '${rating['nameOfRater']}', // Replace with your name or text
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          RatingBar.builder(
                            unratedColor: Colors.grey,
                            initialRating: displayedRating,
                            minRating: 1,
                            itemSize: 24,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding:
                                const EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                            ignoreGestures: true, // Make it non-editable
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            ' ($displayedRating rating)', // Replace with your name or text
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Expanded(
                          child: Column(
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  rating['comment'].isNotEmpty
                                      ? 'Comment: ${rating['comment']}'
                                      : 'No Comment',
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: rating['photoURL'] != null
                            ? Image.network(
                                rating['photoURL'],
                                width: 120, // Adjust the width as needed
                                height: 120, // Adjust the height as needed
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image,
                                    size: 120,
                                    color: Colors.white, // Customize the color
                                  );
                                },
                              )
                            : Icon(
                                Icons.image,
                                size: 120,
                                color: Colors.white, // Customize the color
                              ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'October 23, 2023 | 10:00 PM', // Replace with your name or text
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
