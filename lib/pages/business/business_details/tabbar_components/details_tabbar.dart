// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/business_links.dart';
import 'package:tim_app/pages/business/business_details/tabbar_components/thumbnail.dart';
import 'package:tim_app/pages/profile/components/profile_modal.dart';
import 'package:tim_app/pages/profile/components/profile_modal_address.dart';
import 'package:tim_app/pages/travellers/apply_business/components/stepper_three.dart';
import 'package:tim_app/pages/travellers/apply_business/components/stepper_two.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';
import 'package:tim_app/widgets/buttonEdit.dart';

import '../../../../backend/firebase/firebaseService.dart';

class DetailsTabbar extends StatefulWidget {
  const DetailsTabbar({super.key});

  @override
  State<DetailsTabbar> createState() => _DetailsTabbarState();
}

class _DetailsTabbarState extends State<DetailsTabbar> {
  File? _pickedLogo, _pickedImage1, _pickedImage2, _pickedImage3;
  Uint8List? _webPickedLogo;
  Uint8List? _webPickedImage1;
  Uint8List? _webPickedImage2;
  Uint8List? _webPickedImage3;

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
      } else if (imageType == 'image1') {
        setState(() {
          _webPickedImage1 = f;
          _pickedImage1 = File('a');
        });
      } else if (imageType == 'image2') {
        setState(() {
          _webPickedImage2 = f;
          _pickedImage2 = File('a');
        });
      } else if (imageType == 'image3') {
        setState(() {
          _webPickedImage3 = f;
          _pickedImage3 = File('a');
        });
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Responsive.isMobile(context)
              ? mobileContainer1()
              : desktopContainer1(),
        ],
      ),
    );
  }

// ============== CONTAINER 1 ==============
  Widget desktopContainer1() {
    return FutureBuilder(
        future: fetchDocumentbyID('94RhxOFr6SQMqRm9ffiB', 'businesses'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error fetching data'));
          } else if (snapshot.hasData) {
            Map<String, dynamic> item = snapshot.data!;
            return Column(
              children: [
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Business Information', // Replace with your name or text
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                  image: Image.network(item[
                                                                  'businessImages']
                                                              ['logo'] ??
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
                                        color: Colors.black,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add_a_photo_outlined,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          onPressed: () {
                                            _pickImage('logo');
                                            // widget.businessModel?.pickedImage1 =
                                            //     _webPickedImage1;
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
                          SizedBox(
                            width: 300,
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item['businessName']
                                        .toString(), // Replace with your name or text
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    item['businessEmail']
                                        .toString(), // Replace with your name or text
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                  SizedBox(height: 8.0),
                                  Text(
                                    item['businessDesc']
                                        .toString(), // Replace with your name or text
                                    style: TextStyle(
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['businessSector']
                                    .toString(), // Replace with your name or text
                                style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                item['businessAddress']['country']
                                    .toString(), // Replace with your name or text
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                              SizedBox(height: 8.0),
                              Text(
                                item['businessPhoneNumber']['countryCode']
                                        .toString() +
                                    item['businessPhoneNumber']['number']
                                        .toString(), // Replace with your name or text
                                style: TextStyle(
                                  fontSize: 15.0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
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
                      Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Business Thumbnails',
                              style: TextStyle(
                                  fontSize: 16.0, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Upload your 3 business thumbnails here',
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 200,
                              child: Center(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                      onTap: () {
                                        _pickImage('image1');
                                        // widget.businessModel?.pickedImage1 =
                                        //     _webPickedImage1;
                                      },
                                      child: _pickedImage1 == null
                                          ? ImageUploadCard(
                                              icon: const Icon(
                                                  Icons.cloud_upload_outlined,
                                                  size: 35,
                                                  color: Colors.blue),
                                              description: 'Click to upload',
                                            )
                                          : Image.memory(_webPickedImage1!,
                                              fit: BoxFit.contain,
                                              width: 140,
                                              height: 110)),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 200,
                              child: Center(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                      onTap: () {
                                        _pickImage('image2');
                                        // widget.businessModel?.pickedImage2 =
                                        //     _webPickedImage2;
                                      },
                                      child: _pickedImage2 == null
                                          ? ImageUploadCard(
                                              icon: const Icon(
                                                  Icons.cloud_upload_outlined,
                                                  size: 35,
                                                  color: Colors.blue),
                                              description: 'Click to upload',
                                            )
                                          : Image.memory(_webPickedImage2!,
                                              fit: BoxFit.contain,
                                              width: 140,
                                              height: 110)),
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              width: 200,
                              child: Center(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                      onTap: () {
                                        _pickImage('image3');
                                        // widget.businessModel?.pickedImage3 =
                                        //     _webPickedImage3;
                                      },
                                      child: _pickedImage3 == null
                                          ? ImageUploadCard(
                                              icon: const Icon(
                                                  Icons.cloud_upload_outlined,
                                                  size: 35,
                                                  color: Colors.blue),
                                              description: 'Click to upload',
                                            )
                                          : Image.memory(_webPickedImage3!,
                                              fit: BoxFit.contain,
                                              width: 140,
                                              height: 110)),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.maxFinite,
                  height: 330,
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
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Business Information', // Replace with your name or text
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
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
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 500,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Country', // Replace with your name or text
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  item['businessAddress'][
                                      'country'], // Replace with your name or text
                                  style: TextStyle(
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
                                Text(
                                  'City', // Replace with your name or text
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  item['businessAddress'][
                                      'city'], // Replace with your name or text
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        children: [
                          SizedBox(
                            width: 500,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Postal Code', // Replace with your name or text
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  item['businessAddress'][
                                      'postal'], // Replace with your name or text
                                  style: TextStyle(
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
                                Text(
                                  'Building Address', // Replace with your name or text
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Text(
                                  item['businessAddress'][
                                      'building'], // Replace with your name or text
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.0),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          'Business Links', // Replace with your name or text
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      BusinessLinks(item: item),
                      SizedBox(height: 20.0),
                      // Align(
                      //     alignment: Alignment.topLeft,
                      //     child: OperatingHours(
                      //       operatingHours: item['businessHours'][], closingTime: null, openingTime: null,
                      //     )),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Center(child: Text('No data found'));
          }
        });
  }

  Widget mobileContainer1() {
    return Container(
      width: double.maxFinite,
      height: h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
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
            height: 15,
          ),
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
    );
  }

  // ============== CONTAINER 2 ==============
}
