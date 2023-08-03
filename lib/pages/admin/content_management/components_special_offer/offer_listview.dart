import 'dart:ui';

import 'package:flutter/material.dart';

class ListViewOfContainers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: ListView(
        children: const [
          CustomContainer(
            // imageAsset: 'assets/image1.jpg',
            text: 'How It Works',

            icon: Icons.settings_applications_outlined,
          ),

          SizedBox(
            height: 10,
          ),
          CustomContainer(
            text: 'City Guide',
            icon: Icons.travel_explore,
          ),

          // Add more CustomContainers as needed
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String text;
  final IconData icon;

  const CustomContainer({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                for (double i = 1; i < 5; i++)
                  const BoxShadow(
                    spreadRadius: -1,
                    color: Colors.blueAccent,
                    blurRadius: 1,
                    blurStyle: BlurStyle.outer,
                  )
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white60.withOpacity(0.10),
                  Colors.blue.withOpacity(0.10),
                ],
              ),
              // color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(width: 2, color: Colors.white10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Icon(icon, size: 30, color: Colors.blue),
                  const SizedBox(width: 10),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.arrow_right,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
