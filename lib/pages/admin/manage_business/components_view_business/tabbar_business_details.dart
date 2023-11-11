import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/widgets/blurContainer.dart';

class TabbarDetails extends StatefulWidget {
  final Map<String, dynamic> item;
  const TabbarDetails({super.key, required this.item});

  @override
  State<TabbarDetails> createState() => _TabbarDetailsState();
}

class _TabbarDetailsState extends State<TabbarDetails> {
  @override
  Widget build(BuildContext context) {
    double ratingScore = double.parse(widget.item['rating'].toString());

    double calculateDisplayedRating(double actualRating) {
      if (actualRating > 4.5 && actualRating != 5.00) {
        return 4.5;
      }
      return actualRating;
    }

    double displayedRating = calculateDisplayedRating(ratingScore);
    debugPrint(displayedRating.toString());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          BlurContainer(
            width: double.maxFinite,
            height: 220,
            childColumn: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: Container(
                        width:
                            100, // Set the desired width for the circular avatar
                        height: 80,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.blue, // Set the color of the border
                            width: 1.0, // Set the width of the border
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          widget.item['businessImages']['logo'],
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(
                              Icons.business_center,
                              color: Colors.white,
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: 8.0),
                            Text(
                              widget.item['businessName']
                                  .toString(), // Replace with your name or text
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Row(
                              children: [
                                RatingBar.builder(
                                  unratedColor: Colors.grey,
                                  initialRating: displayedRating,
                                  minRating: 1,
                                  itemSize: 24,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
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
                                  '$displayedRating (${widget.item['reviewCount']} reviews)', // Replace with your name or text
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${widget.item['businessEmail']} | ${widget.item['businessPhoneNumber']['countryCode']}${widget.item['businessPhoneNumber']['number']}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                            Text(
                              '${widget.item['businessSector']} | ${widget.item['businessAddress']['country']}',
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.item['businessDesc'].toString(),
                            overflow: TextOverflow.visible,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlurExpanded(
            width: double.maxFinite,
            childColumn: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Business Thumbnail', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                widget.item['businessImages']['image1'] != null &&
                        widget.item['businessImages']['image2'] != null &&
                        widget.item['businessImages']['image3'] != null
                    ? ImageRowPage(item: widget.item)
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'No images uploaded',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          BlurExpanded(
            width: double.maxFinite,
            childColumn: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Business Address', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 500,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Country', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              widget.item['businessAddress']
                                  ['country'], // Replace with your name or text
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'City', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              widget.item['businessAddress']
                                  ['city'], // Replace with your name or text
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      SizedBox(
                        width: 500,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Postal Code', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              widget.item['businessAddress']
                                  ['postal'], // Replace with your name or text
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Building Address', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              widget.item['businessAddress'][
                                  'building'], // Replace with your name or text
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Business Links', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  BusinessLinks(item: widget.item),
                  const SizedBox(height: 20.0),
                  Align(
                      alignment: Alignment.topLeft,
                      child: OperatingHours(
                        operatingHours: widget.item['businessHours'],
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
