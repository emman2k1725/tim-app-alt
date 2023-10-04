import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/utils/loading.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class CreateAdsDialog extends StatefulWidget {
  final businessID;
  const CreateAdsDialog({super.key, required this.businessID});

  @override
  State<CreateAdsDialog> createState() => _CreateAdsDialogState();
}

class _CreateAdsDialogState extends State<CreateAdsDialog> {
  String? selectedBusinessSector;
  String? selectedCuisine;
  File? pickedImage;
  Uint8List? webPickedImage;
  Map<String, dynamic> advertData = {
    "title": null,
    "description": null,
    "imageURL": null,
    "business": null,
    "createAt": DateTime.now().toString(),
    "status": "Pending"
  };
  List<String> businessSectors = [
    'Homepage Advertisment',
    'Subpage Advertisment',
    'Newsletter Advertisment',
    'Mobile App Advertisment',
  ];

  final _formKey = GlobalKey<FormState>();

  void pickImage() async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      setState(() {
        webPickedImage = f;
        pickedImage = File('a');
      });
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Advertisement'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: double.maxFinite,
                height: 320,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Title *',
                            hintText: 'Title of Ads',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                          ),
                          onSaved: (value) => advertData['title'] = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter title of the advertisement";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Short Description *',
                            hintText: 'Short Description',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                          ),
                          onSaved: (value) => advertData['description'] = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter description of the advertisement";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Advertisement Placement',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            DropdownButtonFormField<String>(
                              value: selectedBusinessSector,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Please select advertisement placement";
                                }
                                return null;
                              },
                              items: businessSectors.map((sector) {
                                return DropdownMenuItem<String>(
                                  value: sector,
                                  child: Text(sector),
                                );
                              }).toList(),
                              decoration: InputDecoration(
                                labelText: 'Advertisement Placement',
                                border: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(
                                      20.0), // Set the border radius
                                ),
                              ),
                              onChanged: (value) {
                                advertData['placement'] = value;
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: double.maxFinite,
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.blue, width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Upload your Advertisement Banner',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Please upload a 800px x 90px image banner',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                          onTap: () {
                            pickImage();
                          },
                          child: pickedImage == null
                              ? Center(
                                  child: Container(
                                    width: 800,
                                    height: 90,
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Background color of the container
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons
                                              .cloud_upload_outlined, // Replace with the icon you want to use
                                          color: Colors.black, // Icon color
                                          size: 30, // Icon size
                                        ),
                                        SizedBox(
                                            width:
                                                10), // Optional: Add spacing between icon and text
                                        Text(
                                          'upload a 800px x 90px image  ', // Replace with your custom text
                                          style: TextStyle(
                                            color: Colors.black, // Text color
                                            fontSize: 18, // Text font size
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Image.memory(webPickedImage!,
                                  fit: BoxFit.fill, width: 140, height: 110)),
                    ),
                  ],
                )),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Close'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate() == true) {
              _formKey.currentState!.save();
              showCustomLoadingDialog(context, 'Creating advertisement....');
              advertData['business'] = widget.businessID;
              // Upload Image
              uploadImage(webPickedImage, 'business_offers').then((value) => {
                    if (value != null)
                      {
                        advertData['imageURL'] = value,
                        createAds(advertData, 'advertisement').then((value) => {
                              if (value == 'success')
                                {
                                  Navigator.pop(context),
                                  const SuccessDialog(
                                      title: 'Success'), // DI LUMALABAS
                                }
                            })
                      }
                  });
            }
          },
          child: const Text('Submit'),
        )
      ],
    );
  }
}
