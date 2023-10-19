import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tim_app/backend/firebase/firebaseService.dart';
import 'package:tim_app/data/cuisine_data.dart';
import 'package:tim_app/model/city_model.dart';
import 'package:tim_app/model/content_model.dart';
import 'package:tim_app/widgets/dialogs/failed_dialog.dart';
import 'package:tim_app/widgets/dialogs/success_dialog.dart';

class SettingHangoutDialog extends StatefulWidget {
  final hangoutData;
  const SettingHangoutDialog({super.key, required this.hangoutData});

  @override
  State<SettingHangoutDialog> createState() => _SettingHangoutDialogState();
}

class _SettingHangoutDialogState extends State<SettingHangoutDialog> {
  final _formKey = GlobalKey<FormState>();
  Map<String, dynamic> newData = {
    "ave_time_mins": "",
    "hangout": "",
  };
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Hangout'),
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
                          labelText: 'Hangout Place',
                          hintText: 'Hangout Place',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Hangout Place';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          newData['hangout'] = value;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Enter Average Time Per Minutes*',
                          hintText: 'Average Time ',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Average Time';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          newData['ave_time_mins'] = int.parse(value!);
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

              widget.hangoutData.add(newData);
              debugPrint(widget.hangoutData.toString());
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(), // Show the loading indicator
                        SizedBox(height: 8),
                        Text("Saving Place..."),
                      ],
                    ),
                  );
                },
              );

              await createSetting(widget.hangoutData, 'hangout').then((value) {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                  if (value == 'success') {
                    Navigator.of(context).pop();
                    // Show a success dialog after one second
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SuccessDialog(
                            title: 'You Added New Hangout Place!');
                      },
                    );
                  } else {
                    Navigator.of(context).pop();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return FailedDialog(
                            title: 'There\'s an error adding new place!');
                      },
                    );
                  }
                });
              });
            }
          },
          child: const Text('Add new place'),
        ),
      ],
    );
  }
}
