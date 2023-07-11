import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/pages/dashboard_main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final userProfile = FirebaseFirestore.instance.collection('user_profile');
String userID = "";

void registerWithEmailPassword(
    String email,
    String password,
    String phoneNumber,
    String firstName,
    String lastName,
    BuildContext context) async {
  try {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    userID = userCredential.user!.uid;
    await userProfile.doc(userID).set({
      'email': email,
      'firstNamme': firstName,
      'lastName': lastName,
      'mobileNumber': phoneNumber,
      'isRegistrationComplete': false,
      'hasBusiness': false,
      'isAdmin': false
    });
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardMainScreen()),
    );
  } catch (e) {
    print(e.toString());
  }
}

void loginWithEmailPassword(
    String email, String password, BuildContext context) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const DashboardMainScreen()),
    );
  } catch (e) {
    print(e.toString());
  }
}
