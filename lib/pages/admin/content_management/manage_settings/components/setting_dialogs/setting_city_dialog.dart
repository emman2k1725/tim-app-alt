import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/model/city_model.dart';
import 'package:tim_app/model/content_model.dart';
import 'package:tim_app/widgets/dialogs/failed_dialog.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class SettingCityDialog extends StatefulWidget {
  final cityData;
  const SettingCityDialog({super.key, required this.cityData});

  @override
  State<SettingCityDialog> createState() => _SettingCityDialogState();
}

class _SettingCityDialogState extends State<SettingCityDialog> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> newData = {
    "city": "",
    "lat": "",
    "long": "",
  };
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New City'),
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
                          labelText: 'City Name',
                          hintText: 'City Name',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter city name';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          newData['city'] = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Latitude based on Google Map*',
                          hintText: 'Latitude ',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter latitude';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          newData['lat'] = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Latitude based on Google Map*',
                          hintText: 'Latitude',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter latitude';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          newData['long'] = value;
                        },
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              widget.cityData.add(newData);

              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(), // Show the loading indicator
                        SizedBox(height: 8),
                        Text("Saving City..."),
                      ],
                    ),
                  );
                },
              );

              await createSetting(widget.cityData, 'cities').then((value) {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                  if (value == 'success') {
                    Navigator.of(context).pop();
                    // Show a success dialog after one second
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SuccessDialog(
                            title: 'You Added New City!');
                      },
                    );
                  } else {
                    Navigator.of(context).pop();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return FailedDialog(title: 'You Added New City!');
                      },
                    );
                  }
                });
              });
            }
          },
          child: const Text('Add new city'),
        ),

        // ElevatedButton(
        //   onPressed: () async {
        //     if (_formKey.currentState!.validate()) {
        //       _formKey.currentState!.save();
        //       widget.cityData.add(newData);
        //       showDialog(
        //         context: context,
        //         builder: (context) {
        //           return FutureBuilder(
        //             future: createSetting(widget.cityData, 'cities'),
        //             builder: (context, snapshot) {
        //               if (snapshot.connectionState == ConnectionState.waiting) {
        //                 return CircularProgressIndicator();
        //               } else if (snapshot.hasError) {
        //                 return Text('Error: ${snapshot.error}');
        //               } else {
        //                 if (snapshot.data == 'success') {
        //                   Future.delayed(Duration(seconds: 2), () {
        //                     Navigator.of(context)
        //                         .pop(); // Close the loading dialog
        //                     showDialog(
        //                       context: context,
        //                       builder: (context) {
        //                         return SuccessDialog(
        //                             title: 'You Added New City!');
        //                       },
        //                     );
        //                   });
        //                 } else {
        //                   // Handle other cases if needed
        //                 }
        //                 return Container(); // Placeholder for success message or further actions
        //               }
        //             },
        //           );
        //         },
        //       );
        //     }
        //   },
        //   child: const Text('Add new city'),
        // ),

        // ElevatedButton(
        //   onPressed: () async {
        //     if (_formKey.currentState!.validate()) {
        //       const Center(child: CircularProgressIndicator());
        //       _formKey.currentState!.save();
        //       widget.cityData.add(newData);
        //       await createSetting(widget.cityData, 'cities').then((value) {
        //         if (value == 'success') {
        //           // debugPrint('This is value: $value');
        //           Navigator.pop(context);
        //           // Navigator.pop(context);
        //           const SuccessDialog(title: 'You Added New City!');
        //         } else {}
        //       });
        //     }
        //   },
        //   child: const Text('Add new city'),
        // ),
      ],
    );
  }
}
