import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/model/content_model.dart';

class CreateNewsDialog extends StatefulWidget {
  const CreateNewsDialog({
    super.key,
  });

  @override
  State<CreateNewsDialog> createState() => _CreateNewsDialogState();
}

class _CreateNewsDialogState extends State<CreateNewsDialog> {
  File? _pickedImage;
  Uint8List? _webPickedImage;

  Future<Uint8List?> _pickImage(String imageType) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      var f = await image.readAsBytes();
      if (imageType == 'logo') {
        setState(() {
          _webPickedImage = f;
          _pickedImage = File('a');
        });
      }
    }
    return null;
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ContentModel contentModel = ContentModel();
    return AlertDialog(
      title: const Text('Create New Newsletter'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Title *',
                          hintText: 'Title of News',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter news title';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          if (value == null) {
                            contentModel.contentTitle = null;
                          } else {
                            contentModel.contentTitle = value;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Content of news *',
                          hintText: 'Content of news ',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter news content';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          if (value == null) {
                            contentModel.description = null;
                          } else {
                            contentModel.description = value;
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'News Link *',
                          hintText: 'News Link ',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter news link';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          if (value == null) {
                            contentModel.website = null;
                          } else {
                            contentModel.website = value;
                          }
                        },
                      ),
                    ],
                  )),
              const SizedBox(
                height: 20,
              ),
              Container(
                  width: double.maxFinite,
                  height: 300,
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
                        'Upload your Newsletter Image',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Please upload a 400px x 209px image',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Center(
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () async {
                              await _pickImage('logo');
                            },
                            child: _pickedImage == null
                                ? Container(
                                    width: 400,
                                    height: 209,
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
                                          'upload a 400px x 209px image  ', // Replace with your custom text
                                          style: TextStyle(
                                            color: Colors.black, // Text color
                                            fontSize: 18, // Text font size
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Image.memory(_webPickedImage!,
                                    fit: BoxFit.fill, width: 140, height: 110),
                          ),
                        ),
                      ),
                    ],
                  ))
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {},
          child: const Text('Create'),
        ),
      ],
    );
  }
}
