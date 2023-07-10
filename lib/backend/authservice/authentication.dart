import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final userProfile = FirebaseFirestore.instance.collection('user_profile');
String userID = "";

Future registerWithEmailPassword(String email, String password,
    String phoneNumber, String firstName, String lastName) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userID = userCredential.user!.uid;
    debugPrint(userID);
    await userProfile.doc(userID).set({
      'email': email,
      'firstNamme': firstName,
      'lastName': lastName,
      'mobileNumber': phoneNumber,
      'isRegistrationComplete': false,
      'hasBusiness': false,
      'isAdmin': false
    });
    debugPrint('Firestore document created successfully.');
  } catch (e) {
    debugPrint(e.toString());
  }
  return null;
}
