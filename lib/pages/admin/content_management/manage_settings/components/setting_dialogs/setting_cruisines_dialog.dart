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

class SettingCruisinesDialog extends StatefulWidget {
  final cruisinesData;
  const SettingCruisinesDialog({super.key, required this.cruisinesData});

  @override
  State<SettingCruisinesDialog> createState() => _SettingCruisinesDialogState();
}

class _SettingCruisinesDialogState extends State<SettingCruisinesDialog> {
  final _formKey = GlobalKey<FormState>();
  String newData = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create New Cruisines'),
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
                          labelText: 'Cruisines',
                          hintText: 'Cruisines',
                          border: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.blue),
                            borderRadius: BorderRadius.circular(
                                20.0), // Set the border radius
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter Cruisines';
                          } else {
                            return null;
                          }
                        },
                        onSaved: (value) {
                          newData = value!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
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
              debugPrint(widget.cruisinesData.toString());
              debugPrint(newData.toString());
              // widget.cruisinesData.add(newData);
              // debugPrint(widget.cruisinesData.toString());
              showDialog(
                context: context,
                builder: (context) {
                  return const AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        CircularProgressIndicator(), // Show the loading indicator
                        SizedBox(height: 8),
                        Text("Saving Cruisines..."),
                      ],
                    ),
                  );
                },
              );

              await updateSetting(newData, 'cruisines').then((value) {
                Future.delayed(const Duration(seconds: 1), () {
                  Navigator.of(context).pop();
                  if (value == 'success') {
                    Navigator.of(context).pop();
                    // Show a success dialog after one second
                    showDialog(
                      context: context,
                      builder: (context) {
                        return const SuccessDialog(
                            title: 'You Added New Cruisine!');
                      },
                    );
                  } else {
                    Navigator.of(context).pop();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return FailedDialog(
                            title: 'There\'s an error adding new cruisines!');
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
