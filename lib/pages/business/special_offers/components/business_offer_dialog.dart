import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/utils/loading.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class CreateOfferDialog extends StatefulWidget {
  final businessID;
  const CreateOfferDialog({super.key, required this.businessID});

  @override
  State<CreateOfferDialog> createState() => _CreateOfferDialogState();
}

class _CreateOfferDialogState extends State<CreateOfferDialog> {
  File? pickedImage;
  Uint8List? webPickedImage;
  String? expirationDateText;
  DateTime? expirationDate;
  TextEditingController _expirationDateController = TextEditingController();
  Map<String, dynamic> businessOfferData = {
    "title": null,
    "description": null,
    "offerCode": null,
    "expiration": null,
    "imageURL": null,
    "business": null,
    "createAt": DateTime.now().toString(),
    "status": "Pending"
  };
  final _formKey = GlobalKey<FormState>();

  Future<void> selectExpiration(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: expirationDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != expirationDate) {
      setState(() {
        expirationDate = picked;

        expirationDateText = expirationDate!.toLocal().toString().split(' ')[0];
        _expirationDateController.text = expirationDateText!;
      });
    }
  }

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
      title: const Text('Create New Special Offers'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                width: ((MediaQuery.of(context).size.width) * 0.60),
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
                            hintText: 'Title of Offer',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                          ),
                          onSaved: (value) =>
                              businessOfferData['title'] = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter Title of the Offer";
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
                          onSaved: (value) =>
                              businessOfferData['description'] = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter a short description of the Offer";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Offer Code *',
                            hintText: 'Offer Code',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                          ),
                          onSaved: (value) =>
                              businessOfferData['offerCode'] = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter code of the Offer";
                            }
                            return null;
                          }),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Expiration Date',
                            hintText: 'Expiration Date',
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.blue),
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the border radius
                            ),
                          ),
                          controller: _expirationDateController,
                          onTap: () => selectExpiration(context),
                          onSaved: (value) =>
                              businessOfferData['expiration'] = value,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please select expiration date of the Offer";
                            }
                            return null;
                          }),
                    ],
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Container(
                width: ((MediaQuery.of(context).size.width) * 0.70),
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
                      'Upload your Special Offer Image',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Please upload a 200px x 200px image',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                            onTap: () {
                              pickImage();
                            },
                            child: pickedImage == null
                                ? Container(
                                    width: 200,
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors
                                          .white, // Background color of the container
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.blue, width: 2),
                                    ),
                                    child: const Column(
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
                                          'Upload image  ', // Replace with your custom text
                                          style: TextStyle(
                                            color: Colors.black, // Text color
                                            fontSize: 18, // Text font size
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Image.memory(webPickedImage!,
                                    fit: BoxFit.fill, width: 140, height: 110)),
                      ),
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
              showCustomLoadingDialog(context, 'Creating special offer....');
              businessOfferData['business'] = widget.businessID;
              // Upload Image
              uploadImage(webPickedImage, 'business_offers').then((value) => {
                    if (value != null)
                      {
                        businessOfferData['imageURL'] = value,
                        createAds(businessOfferData, 'special_offers')
                            .then((value) => {
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
