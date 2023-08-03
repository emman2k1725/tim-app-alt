import 'package:flutter/material.dart';

class CreateNewsDialog extends StatefulWidget {
  const CreateNewsDialog({super.key});

  @override
  State<CreateNewsDialog> createState() => _CreateNewsDialogState();
}

class _CreateNewsDialogState extends State<CreateNewsDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Create New Newsletter'),
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
                        hintText: 'Title of News',
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
                        labelText: 'Content of news *',
                        hintText: 'Content of news ',
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
                        labelText: 'News Link *',
                        hintText: 'News Link ',
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
                      'Upload your Newsletter Image',
                      style: TextStyle(
                          fontSize: 16.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Please upload a 400px x 209px image',
                      style: TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Center(
                      child: Container(
                        width: 400,
                        height: 209,
                        decoration: BoxDecoration(
                          color:
                              Colors.white, // Background color of the container
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.blue, width: 2),
                        ),
                        child: Row(
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
                              'upload a 400px x 209px image  ', // Replace with your custom text
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
