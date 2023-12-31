import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/model/content_model.dart';
import 'package:tim_app/widgets/blurContainer.dart';

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
    ContentModel? contentModel = ContentModel();

    return AlertDialog(
      backgroundColor: Colors.transparent,
      title: const Text('Create New Newsletter'),
      content: BlurExpanded(
        width: MediaQuery.of(context).size.width * 0.5,
        childColumn: SingleChildScrollView(
          child: Theme(
            data: ThemeData(
              hintColor: Colors.white,
              primarySwatch: Colors.blue,
              colorScheme: ColorScheme.light(primary: Colors.blue),
              inputDecorationTheme: InputDecorationTheme(
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      BorderSide(color: Colors.blue), // Set the border color
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      BorderSide(color: Colors.grey), // Set the border color
                ),
              ),
            ),
            child: Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        const Text(
                          'Add New Newsletter',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 20,
                        ),
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
                            contentModel.contentTitle = value;
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
                            contentModel.description = value;
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
                            contentModel.website = value;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Upload your Newsletter Image',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'Please upload a 400px x 209px image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                                            color: Colors.white, // Icon color
                                            size: 30, // Icon size
                                          ),
                                          SizedBox(
                                              width:
                                                  10), // Optional: Add spacing between icon and text
                                          Text(
                                            'upload a 400px x 209px image  ', // Replace with your custom text
                                            style: TextStyle(
                                              color: Colors.white, // Text color
                                              fontSize: 18, // Text font size
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Image.memory(_webPickedImage!,
                                      fit: BoxFit.fill,
                                      width: 140,
                                      height: 110),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              contentModel.displayImage =
                  await uploadImage(_webPickedImage, 'Newsletter');
              contentModel.contentType = 'News';
              contentModel.createdAt = DateTime.now();
              _formKey.currentState!.save();
              await createContent(contentModel).then((value) {
                if (value == 'success') {
                  debugPrint('Okay na');
                } else {
                  debugPrint('Di pa okay');
                }
              });
            }
          },
          child: const Text('Create'),
        ),
      ],
    );
  }
}
