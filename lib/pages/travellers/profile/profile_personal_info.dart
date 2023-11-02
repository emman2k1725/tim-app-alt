import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:tim_app/pages/travellers/profile/components/profile_modal.dart';
import 'package:tim_app/pages/travellers/profile/components/profile_modal_address.dart';
import 'package:tim_app/pages/travellers/profile/components/profile_modal_interest.dart';
import 'package:tim_app/widgets/blurContainer.dart';
import 'package:tim_app/widgets/buttonEdit.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({super.key});

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  UserModel? user;
  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    File? _pickedLogo;
    Uint8List? _webPickedLogo;

    Future<Uint8List?> _pickImage(String imageType) async {
      final ImagePicker _picker = ImagePicker();
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        var f = await image.readAsBytes();
        if (imageType == 'logo') {
          setState(() {
            _webPickedLogo = f;
            _pickedLogo = File('a');
          });
        }
      }
      return null;
    }

    final List<dynamic>? cruisines = user?.favCruisine;
    final List<dynamic>? cities = user?.topCities;
    final List<dynamic>? activities = user?.favHangout;
    String? city = user?.address?['city'], country = user?.address?['country'];
    String? building = user?.address?['building'],
        street = user?.address?['street'];
    String cityCountry = "$city, $country";
    String buildingStreet = "$building, $street";
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        BlurContainer(
          width: double.maxFinite,
          //height: 150,
          childColumn: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 25),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150,
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            ClipOval(
                              child: _pickedLogo == null
                                  ? Container(
                                      width:
                                          100, // Set the desired width for the circular avatar
                                      height: 100,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors
                                                .blue, // Set the color of the border
                                            width:
                                                1.0, // Set the width of the border
                                          ),
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                            image: Image.network(
                                                    'assets/images/empty-placeholder.png')
                                                .image, // Replace 'your_image.png' with the actual image path
                                            fit: BoxFit
                                                .cover, // Choose the appropriate fit option for your design
                                          )),
                                    )
                                  : Image.memory(
                                      _webPickedLogo!,
                                      fit: BoxFit.cover,
                                      width: 100,
                                      height: 100,
                                    ),
                            ),
                            Positioned(
                              bottom: 2,
                              left: 60,
                              child: ClipOval(
                                child: Container(
                                  color: Colors.blue,
                                  child: IconButton(
                                    icon: const Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                    onPressed: () {
                                      _pickImage('logo');
                                      // // widget.businessModel?.pickedImage1 =
                                      // //     _webPickedImage1;
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                      height: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.firstName ??
                              '', // Replace with your name or text
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          user?.email ?? '', // Replace with your name or text
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          cityCountry, // Replace with your name or text
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlurExpanded(
          width: double.maxFinite,
          childColumn: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Personal Information', // Replace with your name or text
                      style: TextStyle(
                        color: Colors.white,
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
                      },
                      label: 'Edit',
                      icon: Icons.edit_note_outlined,
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'First Name', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Text(
                              user?.firstName ??
                                  '', // Replace with your name or text
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Last Name', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            user?.lastName == null
                                ? const Text(
                                    'update your  Last Name',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    user?.lastName ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phone Number',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            user?.mobileNumber == null
                                ? const Text(
                                    'update your mobile number',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    user?.mobileNumber ?? '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Email Address',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            user?.email == null
                                ? const Text(
                                    'Please update your email address',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    user?.email ??
                                        'Please update your email address',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        BlurContainer(
          width: double.maxFinite,
          //height: 220,
          childColumn: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Address', // Replace with your name or text
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Country', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            user?.address?['country'] == ""
                                ? const Text(
                                    'Update your Country',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    user?.address?['country'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'City', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            user?.address?['city'] == ''
                                ? const Text(
                                    'Update your City',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    user?.address?['city'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Postal Code',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            user?.address?['postal'] == ''
                                ? const Text(
                                    'Update your Postal',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  )
                                : Text(
                                    user?.address?['postal'] ?? '',
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Building Address', // Replace with your name or text
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            buildingStreet.isEmpty
                                ? Text(
                                    buildingStreet,
                                    style: const TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  )
                                : const Text(
                                    'Update your Bldg. Street',
                                    style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.red,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            BlurExpanded(
              width: double.maxFinite,
              childColumn: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Favourite Cruisines', // Replace with your name or text
                          style: TextStyle(
                            fontSize: 18.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ReusableEditButton(
                          onPressed: () async {
                            await showDialog(
                              context: context,
                              builder: (context) =>
                                  const ModalInterestCruisine(),
                            );
                          },
                          label: 'Edit',
                          icon: Icons.edit_note_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlurExpanded(
              width: double.maxFinite,
              childColumn: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Top 5 City', // Replace with your name or text
                          style: TextStyle(
                            color: Colors.white,
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            BlurExpanded(
              width: double.maxFinite,
              childColumn: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Favourite Activities', // Replace with your name or text
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        ReusableEditButton(
                          onPressed: () async {
                            // Show the modal form and wait for the result
                            await showDialog(
                              context: context,
                              builder: (context) =>
                                  const ModalInterestActivity(),
                            );
                          }, // Pass the onPressed function here
                          label: 'Edit',
                          icon: Icons.edit_note_outlined,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
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
                                        borderRadius:
                                            BorderRadius.circular(10.0),
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
                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
