import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:tim_app/pages/dashboard_main.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final userProfile = FirebaseFirestore.instance.collection('user_profile');
String userID = "";
String errMessage = "An error occured. Try again later";

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
  } on FirebaseAuthException catch (e) {
    debugPrint(e.message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(authErrorHandler(
              parseFirebaseAuthExceptionMessage(input: e.message)))),
    );
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
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(authErrorHandler(
              parseFirebaseAuthExceptionMessage(input: e.message)))),
    );
  }
}

String authErrorHandler(String errorCode) {
  switch (errorCode) {
    case "user-not-found":
      {
        errMessage = "Invalid email or password";
        break;
      }
    case "wrong-password":
      {
        errMessage = "Invalid email or password";
        break;
      }

    case "user-disabled":
      {
        errMessage = "This account is disabled";
        break;
      }

    case "network-request-failed":
      {
        errMessage = "Network connection failed. Try again later.";
        break;
      }
    case "email-already-in-use":
      {
        errMessage = "Email already exists. Please sign in instead.";
        break;
      }
    default:
      {
        errMessage = "An error occured. Try again later";
      }
  }
  return errMessage;
}

String parseFirebaseAuthExceptionMessage(
    {String plugin = "auth", required String? input}) {
  if (input == null) {
    return "unknown";
  }

  // https://regexr.com/7en3h
  String regexPattern = r'(?<=\(' + plugin + r'/)(.*?)(?=\)\.)';
  RegExp regExp = RegExp(regexPattern);
  Match? match = regExp.firstMatch(input);
  if (match != null) {
    return match.group(0)!;
  }

  return "unknown";
}
