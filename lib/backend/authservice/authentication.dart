import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/UserModel.dart';

class Authenticate {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance.collection('user_profile');

  User? _user;
  User? get user => _user;
  bool get isLoggedIn => _user != null;

  Future register(String email, String password, String firstName,
      String lastName, String mobileNumber) async {
    String result = "";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          mobileNumber: mobileNumber,
          isAdmin: false,
          isRegistrationComplete: false,
          hasBusiness: false,
          address: {
            'building': '',
            'street': '',
            'city': '',
            'state': '',
            'postal': '',
            'country': ''
          });
      await _firestore.doc(_user!.uid).set(userModel.toMap());
      result = "success";
    } on FirebaseAuthException catch (e) {
      result =
          authErrorHandler(parseFirebaseAuthExceptionMessage(input: e.message));
    } catch (e) {
      result = authErrorHandler(
          parseFirebaseAuthExceptionMessage(input: e.toString()));
    }
    return result;
  }

  Future registerAdmin(String email, String password, String firstName,
      String lastName, String mobileNumber, String accessLevel) async {
    String result = "";
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      _user = userCredential.user;
      UserModel userModel = UserModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          mobileNumber: mobileNumber,
          isAdmin: true);
      if (accessLevel == 'Super Admin') {
        userModel.isSuperAdmin = true;
      } else {
        userModel.isSuperAdmin = false;
      }

      await _firestore.doc(_user!.uid).set(userModel.toMap());
      result = "success";
    } on FirebaseAuthException catch (e) {
      result =
          authErrorHandler(parseFirebaseAuthExceptionMessage(input: e.message));
    } catch (e) {
      result = authErrorHandler(
          parseFirebaseAuthExceptionMessage(input: e.toString()));
    }
    return result;
  }

  Future signIn(String email, String password) async {
    String result = "";
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = userCredential.user;
      result = "success";
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      result =
          authErrorHandler(parseFirebaseAuthExceptionMessage(input: e.message));
    }
    return result;
  }

  void signOut() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    try {
      await _auth.signOut();
      await _pref.clear();
      await _pref.reload();

      _user = null;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static bool isAutheticated() {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return false;
    } else {
      return true;
    }
  }
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

String authErrorHandler(String errorCode) {
  String errMessage;
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
