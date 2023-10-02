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
          return const Center(
              child:
                  CircularProgressIndicator()); // Show a loading indicator while fetching data.
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Text('No data available');
        } else {
          final List<CarouselItem> carouselItems =
              snapshot.data!.docs.map((doc) {
            final data = doc.data() as Map<String, dynamic>;
            return CarouselItem(
              title: data['contentTitle'],
              imageUrl: data['displayImage'],
              description: data['description'],
            );
          }).toList();

          return CarouselSlider.builder(
            itemCount: carouselItems.length,
            itemBuilder: (BuildContext context, int index, int realIndex) {
              final item = carouselItems[index];
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      item.imageUrl,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return const CircularProgressIndicator();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 200,
                          height: 200,
                          child: const Icon(
                            Icons.image,
                            color: Colors.white,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: Text(
                          item.description,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          // _showRowDialog(data[index], context);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Continue reading",
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                  fontSize: 15,
                                  fontStyle: FontStyle.italic,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 15,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ],
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
