import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../backend/authservice/authentication.dart';
import '../../../backend/firebase/UserDataProvider.dart';
import '../../../model/UserModel.dart';
import '../../services/validator_service.dart';

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
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    return AlertDialog(
      title: Text('Edit Address'),
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
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _country = value!;
                    user?.address?['country'] = _country;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsNumber(value) == true) {
                      return 'Please enter a valid country';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'City',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _city = value!;
                    user?.address?['city'] = _city;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsNumber(value) == true) {
                      return 'Please enter a valid city';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Postal Code',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _postal = value!;
                    user?.address?['postal'] = _postal;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (containsChar(value) == true) {
                      return 'Please enter a valid postal code';
                    }
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: 'Building Address',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: Colors.blue,
                        ),
                      )),
                  onSaved: (value) {
                    _building = value!;
                    user?.address?['building'] = _building;
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (_building != null ||
                  _city != null ||
                  _country != null ||
                  _postal != null) {
                userProvider.updateDocument(authProvider.user!.uid, user);
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
              }
            }
          },
          child: Text('Submit'),
        ),
      ],
    );
  }
}
