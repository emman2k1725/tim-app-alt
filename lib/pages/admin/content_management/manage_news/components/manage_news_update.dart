import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/applyBusiness.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/model/content_model.dart';
import 'package:tim_app/widgets/blurContainer.dart';

import '../../../../../widgets/dialogs/success_dialog.dart';

class UpdateNewsDialog extends StatefulWidget {
  final Map<String, dynamic> newsData;
  const UpdateNewsDialog({
    super.key,
    required this.newsData,
  });

  @override
  State<UpdateNewsDialog> createState() => _UpdateNewsDialogState();
}

class _UpdateNewsDialogState extends State<UpdateNewsDialog> {
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
    TextEditingController title =
        TextEditingController(text: widget.newsData['contentTitle']);
    TextEditingController content =
        TextEditingController(text: widget.newsData['description']);
    TextEditingController newsLink =
        TextEditingController(text: widget.newsData['website']);

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
                          controller: title,
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
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: content,
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
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: newsLink,
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
                          style: TextStyle(color: Colors.white),
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
                                    ? Image.network(
                                        widget.newsData['displayImage'],
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.memory(_webPickedImage!,
                                        fit: BoxFit.fill,
                                        width: 140,
                                        height: 110)),
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
              if (_webPickedImage == null) {
                contentModel.displayImage = widget.newsData['displayImage'];
              } else {
                deleteOldVideo();
                contentModel.displayImage =
                    await uploadVideo(_webPickedImage, 'News');
              }
              contentModel.contentType = 'News';
              contentModel.createdAt = DateTime.now();
              _formKey.currentState!.save();
              await updateContent(widget.newsData['docID'], contentModel)
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
          child: const Text('Update News'),
        ),
      ],
    );
  }

  void deleteOldVideo() async {
    try {
      Reference storageReference =
          FirebaseStorage.instance.ref(widget.newsData['displayImage']);
      await storageReference.delete();
      debugPrint('Successfully deleted old video');
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
