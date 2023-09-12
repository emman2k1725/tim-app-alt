import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/applyBusiness.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tim_app/backend/firebase/fetchTable.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/model/content_model.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class CreateHowDialog extends StatefulWidget {
  final Map<String, dynamic> aboutDataUpdate;
  const CreateHowDialog({super.key, required this.aboutDataUpdate});

  @override
  State<CreateHowDialog> createState() => _CreateHowDialogState();
}

class _CreateHowDialogState extends State<CreateHowDialog> {
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

  void deleteOldVideo() async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref(widget.aboutDataUpdate['displayImage']);
      await storageReference.delete();
      debugPrint('Successfully deleted old video');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ContentModel? contentModel = ContentModel();
    TextEditingController _contentTitleController =
        TextEditingController(text: widget.aboutDataUpdate['contentTitle']);
    TextEditingController _contentDescController =
        TextEditingController(text: widget.aboutDataUpdate['description']);

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
                        controller: _contentTitleController,
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
                        controller: _contentDescController,
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
                                          'Upload new video  ', // Replace with your custom text
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
                        'Updating Data',
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                );
              },
            );

            if (_formKey.currentState!.validate()) {
              if (_webPickedImage == null) {
                contentModel.displayImage =
                    widget.aboutDataUpdate['displayImage'];
              } else {
                deleteOldVideo();
                contentModel.displayImage =
                    await uploadVideo(_webPickedImage, 'HowItWorks');
              }
              contentModel.contentType = 'HowItWorks';
              contentModel.createdAt = DateTime.now();
              _formKey.currentState!.save();
              await updateContent(widget.aboutDataUpdate['docID'], contentModel)
                  .then((value) {
                if (value == 'success') {
                  Navigator.of(context).pop();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SuccessDialog(
                        title: 'You updated the content',
                      );
                    },
                  );
                } else {
                  // Non success action
                  debugPrint('Di pa okay');
                }
              });
              // Navigator.of(context).pop();
            }
          },
          child: const Text('Create Media'),
        ),
      ],
    );
  }
}
