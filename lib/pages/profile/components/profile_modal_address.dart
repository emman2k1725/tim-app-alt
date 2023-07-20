import 'package:flutter/material.dart';

class ModalAddress extends StatefulWidget {
  @override
  _ModalAddressState createState() => _ModalAddressState();
}

class _ModalAddressState extends State<ModalAddress> {
  final _formKey = GlobalKey<FormState>();

  String _textValue = '';

  @override
  Widget build(BuildContext context) {
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
                    _textValue = value!;
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
                    _textValue = value!;
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
                    _textValue = value!;
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
