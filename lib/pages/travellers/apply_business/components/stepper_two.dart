import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../model/BusinessModel.dart';

class StepperTwo extends StatefulWidget {
  final BusinessModel? businessModel;
  final GlobalKey<FormState> formKey;
  const StepperTwo({
    super.key,
    required this.formKey,
    required this.businessModel,
  });

  @override
  State<StepperTwo> createState() => _StepperTwoState();
}

class _StepperTwoState extends State<StepperTwo> {
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
    return Form(
      key: widget.formKey,
      child: Container(
        width: 900,
        height: 950,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Details',
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Update your business photo and details here',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 20),
            Row(
              children: [
                const SizedBox(
                  width: 500,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Business Logo',
                        style: TextStyle(
                            fontSize: 16.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Upload your business logo',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                    ],
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
                            onTap: () async {
                              await _pickImage('logo');
                            },
                            child: _pickedLogo == null
                                ? ImageUploadCard(
                                    icon: const Icon(
                                        Icons.cloud_upload_outlined,
                                        size: 35,
                                        color: Colors.blue),
                                    description: 'Click to upload',
                                  )
                                : Image.memory(_webPickedLogo!,
                                    fit: BoxFit.fill, width: 140, height: 110)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Thumbnails',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
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
                              widget.businessModel?.pickedImage1 =
                                  _webPickedImage1;
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
                                    fit: BoxFit.fill, width: 140, height: 110)),
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
                              widget.businessModel?.pickedImage2 =
                                  _webPickedImage2;
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
                                    fit: BoxFit.fill, width: 140, height: 110)),
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
                              widget.businessModel?.pickedImage3 =
                                  _webPickedImage3;
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
                                    fit: BoxFit.fill, width: 140, height: 110)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Business Description',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Describe your business in less or 150 letters',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Business Description',
                hintText: 'Business Description max of 150 letters',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 5,
              validator: (value) {
                if (value == null ||
                    value.isEmpty ||
                    (value.length < 50 && value.length > 150)) {
                  return 'Please enter a 150 letter long description of your business';
                }
                return null;
              },
              onSaved: (value) {
                widget.businessModel?.businessDesc = value;
              },
            ),
            const SizedBox(height: 10),
            const Divider(),
            const SizedBox(height: 20),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                'Business Links',
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Google Map Link',
                hintText: 'Google Map Link',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a google map link';
                }
                return null;
              },
              onSaved: (value) {
                widget.businessModel?.businessLinks?['googleMap'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Facebook Link',
                hintText: 'Facebook Link',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              onSaved: (value) {
                widget.businessModel?.businessLinks?['facebook'] = value;
              },
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Instagram Link',
                hintText: 'Instagram Link',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              onSaved: (value) {
                widget.businessModel?.pickedLogo = _webPickedLogo;
                widget.businessModel?.pickedImage1 = _webPickedImage1;
                widget.businessModel?.pickedImage2 = _webPickedImage2;
                widget.businessModel?.pickedImage3 = _webPickedImage3;
                widget.businessModel?.businessLinks?['instagram'] = value;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class ImageUploadCard extends StatelessWidget {
  final Icon icon;
  final String description;

  ImageUploadCard({required this.icon, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.blue, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
              ],
            ),
            const SizedBox(height: 10),
            Text(
              description,
              style: const TextStyle(
                color: Colors.white,
                decoration: TextDecoration.underline,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
