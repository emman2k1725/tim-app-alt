// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tim_app/model/UserModel.dart';
import 'package:flutter/material.dart';

final userProfile = FirebaseFirestore.instance.collection('user_profile');

Future createUserProfileAuth(String userID, String email, String firstName,
    String lastName, String phoneNumber) async {
  try {
    userProfile.doc(userID).set({
      'email': email,
      'mobileNumber': phoneNumber,
      'firstName': firstName,
      'lastName': lastName,
      'isComplete': false
    });
    debugPrint('Successful');
  } catch (e) {
    print('Error creating user data');
  }
}

Future completeUserProfile(UserModel userModel) async {
  try {
    final Map<String, dynamic> userData = userModel.toMap();
    await userProfile.doc(userData['userID']).update(userData);
  } catch (e) {
    debugPrint(e.toString());
  }
}
