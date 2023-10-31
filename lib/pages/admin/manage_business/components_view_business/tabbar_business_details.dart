import 'package:flutter/material.dart';
import 'package:tim_app/pages/admin/manage_business/operating_hours.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';

class TabbarDetails extends StatefulWidget {
  final Map<String, dynamic> item;
  const TabbarDetails({super.key, required this.item});

  @override
  State<TabbarDetails> createState() => _TabbarDetailsState();
}

class _TabbarDetailsState extends State<TabbarDetails> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          height: 230,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
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
                        image: DecorationImage(
                          image: Image.network(widget.item['businessImages']
                                      ['logo'] ??
                                  'assets/images/empty-placeholder.png')
                              .image, // Replace 'your_image.png' with the actual image path
                          fit: BoxFit
                              .cover, // Choose the appropriate fit option for your design
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            widget.item['businessName']
                                .toString(), // Replace with your name or text
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${widget.item['businessEmail']} | ${widget.item['businessPhoneNumber']['countryCode']}${widget.item['businessPhoneNumber']['number']}',
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            '${widget.item['businessSector']} | ${widget.item['businessAddress']['country']}',
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
                      child: Text(
                        widget.item['businessDesc'].toString(),
                        overflow: TextOverflow.visible,
                        style: const TextStyle(),
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
        Container(
          width: double.maxFinite,
          height: 220,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Business Thumbnail', // Replace with your name or text
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ImageRowPage(item: widget.item),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Business Address', // Replace with your name or text
                  style: TextStyle(
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
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.item['businessAddress']
                              ['country'], // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 15.0,
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
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.item['businessAddress']
                              ['city'], // Replace with your name or text
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w500),
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
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.item['businessAddress']
                              ['postal'], // Replace with your name or text
                          style: const TextStyle(
                            fontSize: 15.0,
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
                            color: Colors.grey,
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          widget.item['businessAddress']
                              ['building'], // Replace with your name or text
                          style: const TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.w500),
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
      ],
    );
  }
}
