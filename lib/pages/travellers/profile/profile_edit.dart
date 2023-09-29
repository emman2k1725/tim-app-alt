import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../backend/firebase/UserDataProvider.dart';
import '../../../model/UserModel.dart';

class EditableContainer extends StatefulWidget {
  const EditableContainer({super.key});

  @override
  _EditableContainerState createState() => _EditableContainerState();
}

class _EditableContainerState extends State<EditableContainer> {
  bool _isEditing = false;
  TextEditingController _textEditingController = TextEditingController();
  UserModel? user;
  void getUserData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      user = UserModel.fromMap(jsonDecode(pref.getString('user')!));
    });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: _isEditing ? _buildEditingMode() : _buildViewMode(),
    );
  }

  Widget _buildViewMode() {
    return Row(
      children: [
        Expanded(
          child: Text(
            'Your Text Here',
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () {
            setState(() {
              _isEditing = true;
              _textEditingController.text = 'Your Text Here';
            });
          },
        ),
      ],
    );
  }

  Widget _buildEditingMode() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _textEditingController,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.check),
          onPressed: () {
            setState(() {
              _isEditing = false;
            });
          },
        ),
      ],
    );
  }
}
