import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ModalForm extends StatefulWidget {
  @override
  _ModalFormState createState() => _ModalFormState();
}

class _ModalFormState extends State<ModalForm> {
  final _formKey = GlobalKey<FormState>();

  String _textValue = '';

  @override
  Widget build(BuildContext context) {
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
                  onSaved: (value) {
                    _textValue = value!;
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
                  onSaved: (value) {
                    _textValue = value!;
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
              Navigator.pop(context, _textValue);
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
