import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/pages/services/validator_service.dart';

import '../../../backend/authservice/authentication.dart';
import '../../../backend/firebase/UserDataProvider.dart';
import '../../../model/UserModel.dart';

class ModalForm extends StatefulWidget {
  @override
  _ModalFormState createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  final _formKey = GlobalKey<FormState>();

  String? _firstName;
  String? _lastName;

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
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
                    if (value != null) {
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
                    if (value != null) {
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
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              if (_firstName != null || _lastName != null) {
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> selectedItems = [];
  final _items = ['Italian', 'Mexican', 'Indian', 'Chinese', 'Thai'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MultiSelectDialogField in Modal'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Select Cuisines'),
                content: MultiSelectDialogField(
                  items: _items
                      .map((item) => MultiSelectItem<String>(item, item))
                      .toList(),
                  chipDisplay: MultiSelectChipDisplay(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    textStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    chipColor: Colors.blue,
                  ),
                  title: const Text("Cuisines"),
                  searchable: true,
                  buttonIcon: const Icon(
                    Icons.restaurant_outlined,
                    color: Colors.blue,
                  ),
                  buttonText: const Text(
                    "Favorite Cuisines",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  initialValue: selectedItems,
                  onConfirm: (values) {
                    if (values.length >= 3 && values.length <= 5) {
                      setState(() {
                        selectedItems = values.cast<String>();
                      });
                      Navigator.pop(
                          context); // Close the dialog after selection
                    } else {
                      showMinimumSelectionError();
                    }
                  },
                ),
              ),
            );
          },
          child: Text('Open Modal'),
        ),
      ),
    );
  }

  void showMinimumSelectionError() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text('Please select 3 to 5 cuisines.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}
