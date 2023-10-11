import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/pages/travellers/profile/components/profile_modal_interest.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/buttonEdit.dart';

import 'package:tim_app/backend/firebase/UserDataProvider.dart';
import 'package:tim_app/model/UserModel.dart';

class ProfileInterest extends StatefulWidget {
  const ProfileInterest({super.key});

  @override
  State<ProfileInterest> createState() => _ProfileInterestState();
}

class _ProfileInterestState extends State<ProfileInterest> {
  @override
  Widget build(BuildContext context) {
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    final List<dynamic>? cruisines = user?.favCruisine;
    final List<dynamic>? cities = user?.topCities;
    final List<dynamic>? activities = user?.favHangout;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        BlurContainer(
          width: double.maxFinite,
          height: 150,
          childColumn: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Favourite Cruisines', // Replace with your name or text
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ReusableEditButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => const ModalInterestCruisine(),
                      );
                    },
                    label: 'Edit',
                    icon: Icons.edit_note_outlined,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: cruisines!
                          .map((tag) => Chip(
                                label: Text(
                                  tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.all(
                                    8.0), // Overall padding around the Chip
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top 5 City', // Replace with your name or text
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ReusableEditButton(
                    onPressed: () async {
                      await showDialog(
                        context: context,
                        builder: (context) => const ModalInterestCity(),
                      );
                    },
                    label: 'Edit',
                    icon: Icons.edit_note_outlined,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: cities!
                          .map((tag) => Chip(
                                label: Text(
                                  tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.all(
                                    8.0), // Overall padding around the Chip
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Favourite Activities', // Replace with your name or text
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
                        builder: (context) => const ModalInterestActivity(),
                      );
                    }, // Pass the onPressed function here
                    label: 'Edit',
                    icon: Icons.edit_note_outlined,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                    child: Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: activities!
                          .map((tag) => Chip(
                                label: Text(
                                  tag,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                backgroundColor: Colors.blue,
                                padding: const EdgeInsets.all(
                                    8.0), // Overall padding around the Chip
                                labelPadding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                              ))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
