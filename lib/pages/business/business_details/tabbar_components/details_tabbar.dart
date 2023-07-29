import 'package:flutter/material.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/pages/profile/components/profile_modal.dart';
import 'package:tim_app/pages/profile/components/profile_modal_address.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/widgets/buttonEdit.dart';

class DetailsTabbar extends StatefulWidget {
  const DetailsTabbar({super.key});

  @override
  State<DetailsTabbar> createState() => _DetailsTabbarState();
}

class _DetailsTabbarState extends State<DetailsTabbar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Container(
          width: double.maxFinite,
          height: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipOval(
                child: Container(
                  width: 100, // Set the desired width for the circular avatar
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue, // Set the color of the border
                      width: 1.0, // Set the width of the border
                    ),
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(
                          businessProfile), // Replace 'your_image.png' with the actual image path
                      fit: BoxFit
                          .cover, // Choose the appropriate fit option for your design
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
                height: 15,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Seafood Overload', // Replace with your name or text
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'johndoe@gmail.com', // Replace with your name or text
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    'Indulge in a culinary voyage at our seafood restaurant, \nWhere ocean-fresh delicacies are expertly prepared to delight your taste buds.\nUnforgettable flavors await!', // Replace with your name or text
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
              // Align(
              //   alignment: Alignment.bottomRight,
              //   child: ReusableEditButton(
              //     onPressed: () async {
              //       // Show the modal form and wait for the result
              //       await showDialog(
              //         context: context,
              //         builder: (context) => ModalForm(),
              //       );
              //     }, // Pass the onPressed function here
              //     label: 'Edit',
              //     icon: Icons.edit_note_outlined,
              //   ),
              // ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Business Thumbnail', // Replace with your name or text
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ReusableEditButton(
                    onPressed: () async {
                      // Show the modal form and wait for the result
                      await showDialog(
                        context: context,
                        builder: (context) => ModalForm(),
                      );
                    }, // Pass the onPressed function here
                    label: 'Edit',
                    icon: Icons.edit_note_outlined,
                  ),
                ],
              ),
              ImageRowPage(),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Google Maps and social links', // Replace with your name or text
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ReusableEditButton(
                    onPressed: () async {
                      // Show the modal form and wait for the result
                      await showDialog(
                        context: context,
                        builder: (context) => ModalAddress(),
                      );
                    },
                    label: 'Edit',
                    icon: Icons.edit_note_outlined,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topLeft,
                child: const Text(
                  'To feature links on your profile, set the audience to Public.', // Replace with your name or text
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              BusinessLinks(),
            ],
          ),
        ),
      ],
    );
  }
}
