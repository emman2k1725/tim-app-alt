import 'dart:ui';

import 'package:flutter/material.dart';

class ListViewOfContainers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView(
        children: [
          Expanded(
            child: CustomContainer(
              // imageAsset: 'assets/image1.jpg',
              text: 'HOW IT WORKS',
              subtext: 'Create or update content for HOW IT WORKS page',
              icon: Icons.settings_applications_outlined,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: CustomContainer(
              // imageAsset: 'assets/image2.jpg',
              text: 'Container 2',
              subtext: 'Create or update content for HOW IT WORKS page',
              icon: Icons.settings,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: CustomContainer(
              // imageAsset: 'assets/image3.jpg',
              text: 'Container 3',
              subtext: 'Create or update content for HOW IT WORKS page',
              icon: Icons.info,
            ),
          ),
          // Add more CustomContainers as needed
        ],
      ),
    );
  }
}

// class CustomContainer extends StatelessWidget {
//   final String imageAsset;
//   final String text;
//   final IconData icon;

//   const CustomContainer({
//     required this.imageAsset,
//     required this.text,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(16),
//       child:
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.5),
//             spreadRadius: 3,
//             blurRadius: 5,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//     );
//   }
// }

class CustomContainer extends StatelessWidget {
  final String text;
  final String subtext;
  final IconData icon;

  const CustomContainer({
    Key? key,
    required this.text,
    required this.subtext,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
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
                  SizedBox(width: 20),
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      shape: BoxShape.rectangle,
                      color: Colors.white,
                    ),
                    child: Icon(icon, size: 30, color: Colors.blue),
                  ),
                  SizedBox(width: 20),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: 5,
                        ),
                        Text(subtext,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 15,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: OutlinedButton(
                        onPressed: () {
                          // Add your button's onPressed logic here
                        },
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          side: BorderSide(
                            color: Colors.blue, // Border color
                            width: 2.0, // Border width
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'View', // Text
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(width: 8.0),
                              Icon(Icons.arrow_right),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            //  Column(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Icon(
            //       icon,
            //       color: Colors.white,
            //       size: 30,
            //     ),
            //     const SizedBox(height: 10),
            //     Text(
            //       text,
            //       style: const TextStyle(
            //         color: Colors.white,
            //         fontSize: 18,
            //       ),
            //     ),
            //   ],
            // ),
          ),
        ),
      ),
    );
  }
}
