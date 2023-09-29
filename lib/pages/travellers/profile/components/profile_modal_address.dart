import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../backend/firebase/firebaseService.dart';
import '../../../../backend/firebase/userDataProvider.dart';
import '../../../../backend/shared-preferences/sharedPreferenceService.dart';
import '../../../../model/UserModel.dart';
import '../../../services/validator_service.dart';

class ModalAddress extends StatefulWidget {
  @override
  _ModalAddressState createState() => _ModalAddressState();
}

class _ModalAddressState extends State<ModalAddress> {
  final _formKey = GlobalKey<FormState>();

  String? _country;
  String? _building;
  String? _city;
  String? _postal;

  @override
  Widget build(BuildContext context) {
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    return AlertDialog(
      title: const Text('Edit Address'),
      content: Form(
        key: _formKey,
        child: Container(
          width: 220.0, // Set the desired width
          height: 300.0, // Set the desired height
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _country = value!;
                    if (value.isNotEmpty) {
                      user?.address?['country'] = _country;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsNumber(value) == true) {
                      return 'Please enter a valid country';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _city = value!;
                    if (value.isNotEmpty) {
                      user?.address?['city'] = _city;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsNumber(value) == true) {
                      return 'Please enter a valid city';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Postal Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _postal = value!;
                    if (value.isNotEmpty) {
                      user?.address?['postal'] = _postal;
                    }
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsChar(value) == true) {
                      return 'Please enter a valid postal code';
                    }
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Building Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: const BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _building = value;
                    if (value!.isNotEmpty) {
                      user?.address?['building'] = _building;
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
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (_building!.isNotEmpty ||
                  _city!.isNotEmpty ||
                  _country!.isNotEmpty ||
                  _postal!.isNotEmpty) {
                updateUserDocument(user!.docID, user).then((value) {
                  if (value == 'success') {
                    PrefService pref = PrefService();
                    UserModel updatedUserModel;
                    fetchDocumentbyID(user.docID, 'user_profile').then((value) {
                      updatedUserModel = UserModel.fromMap(value);
                      pref.createCache(updatedUserModel);
                    });
                  }
                });
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
