import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:tim_app/model/carousel.dart';
import 'package:tim_app/pages/travellers/dashboard/traveller_dashboard_screen_body.dart';

class CarouselImage extends StatelessWidget {
  const CarouselImage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('content')
          .where("contentType", isEqualTo: 'Media')
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while fetching data.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No data available');
        } else {
          final List<CarouselItem> carouselItems =
              snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return CarouselItem(
              text: data['contentTitle'],
              imageUrl: data['displayImage'],
            );
          }).toList();

          return CarouselSlider.builder(
            itemCount: carouselItems.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final item = carouselItems[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.network(
                    item.imageUrl,
                    width: 200,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    item.text,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              );
            },
            options: CarouselOptions(
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 3),
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              pauseAutoPlayOnTouch: true,
            ),
          );
        }
      },
    );
  }
}
