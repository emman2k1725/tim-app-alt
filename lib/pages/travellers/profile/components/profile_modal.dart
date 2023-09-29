import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/backend/shared-preferences/sharedPreferenceService.dart';
import 'package:tim_app/pages/services/validator_service.dart';

import '../../../../backend/firebase/userDataProvider.dart';
import '../../../../backend/firebase/firebaseService.dart';
import '../../../../model/UserModel.dart';
import '../../../../utils/loading.dart';

class ModalForm extends StatefulWidget {
  @override
  _ModalFormState createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    String? _firstName;
    String? _lastName;

    return AlertDialog(
      title: Text('Edit Personal Information'),
      content: Form(
        key: _formKey,
        child: Container(
          width: 200.0, // Set the desired width
          height: 150.0, // Set the desired height
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsNumber(value) == true) {
                      return 'Please enter a valid first name';
                    }
                  },
                  onSaved: (value) {
                    _firstName = value;
                    if (value!.isNotEmpty) {
                      user?.setFirstName(_firstName);
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsNumber(value) == true) {
                      return 'Please enter a valid Last name';
                    }
                  },
                  onSaved: (value) {
                    _lastName = value;
                    if (value!.isNotEmpty) {
                      user?.setLastName(_lastName);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            showCustomLoadingDialog(context, 'Updating profile...');
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (_firstName!.isNotEmpty || _lastName!.isNotEmpty) {
                updateUserDocument(user?.docID, user).then((value) {
                  if (value == 'success') {
                    PrefService pref = PrefService();
                    UserModel updatedUserModel;
                    fetchDocumentbyID(user?.docID, 'user_profile')
                        .then((value) {
                      updatedUserModel = UserModel.fromMap(value);
                      pref.createCache(updatedUserModel);
                    });
                  }
                });
              }
              Navigator.pop(context);
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
