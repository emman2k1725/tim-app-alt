import 'package:flutter/material.dart';

class CreateOfferDialog extends StatefulWidget {
  const CreateOfferDialog({super.key});

  @override
  State<CreateOfferDialog> createState() => _CreateOfferDialogState();
}

class _CreateOfferDialogState extends State<CreateOfferDialog> {
  String? selectedBusinessSector;
  String? selectedCuisine;

  List<String> businessSectors = [
    'Homepage Advertisment',
    'Subpage Advertisment',
    'Newsletter Advertisment',
    'Mobile App Advertisment',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Special Offers'),
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
                    ),
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
                    ),
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
                    Text(
                      'Upload your Special Offer Image',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Please upload a 200px x 200px image',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Background color of the container
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
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
          child: Text('Close'),
        ),
      ],
    );
  }
}
