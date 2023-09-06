import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/model/content_model.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class CreateMediaDialog extends StatefulWidget {
  const CreateMediaDialog({
    super.key,
  });

  @override
  State<CreateMediaDialog> createState() => _CreateMediaDialogState();
}

class _CreateMediaDialogState extends State<CreateMediaDialog> {
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
      title: const Text('Create New Media'),
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
                          hintText: 'Title of Media',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter media title';
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
                          labelText: 'Content of media *',
                          hintText: 'Content of media ',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter media content';
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
                          labelText: 'Media Link *',
                          hintText: 'Media Link ',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter media link';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          contentModel.website = value;
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
                        'Upload your Media Image',
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
          onPressed: () async {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Creating Media',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                );
              },
            );
            if (_formKey.currentState!.validate()) {
              contentModel.displayImage =
                  await uploadImage(_webPickedImage, 'Media');
              contentModel.contentType = 'Media';
              contentModel.createdAt = DateTime.now();
              _formKey.currentState!.save();

              // Navigator.of(context).pop();

              await createContent(contentModel).then((value) {
                Navigator.of(context).pop();
                if (value == 'success') {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SuccessDialog(
                        title: 'You created new media content',
                      );
                    },
                  );
                } else {
                  debugPrint('Di pa okay');
                }
              });
            }
          },
          child: const Text('Create Media'),
        ),
      ],
    );
  }
}
