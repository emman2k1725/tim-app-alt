import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:toast/toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/pages/dashboard_main.dart';
import 'package:tim_app/model/UserProvider.dart';

import '../../model/UserModel.dart';

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
      'firstName': firstName,
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
  showDialog(
      context: context,
      builder: (context) {
        return const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(
              width: 10,
            ),
            Text(
              'Logging in',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                letterSpacing: 1.5,
                wordSpacing: 2.0,
              ),
            ),
          ],
        );
      });
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    UserProvider userProvider =
        // ignore: use_build_context_synchronously
        Provider.of<UserProvider>(context, listen: false);
    User? user = result.user;
    final String? userID = user?.uid;

    final userSnapshot = await userProfile.doc(userID).get();
    if (userSnapshot.exists) {
      // Store User Data from Firebase
      final userData = userSnapshot.data();

      // Store to Usermodel
      UserModel userDetails = UserModel(
          userID: userID as String,
          firstName: userData?['firstName'] as String,
          lastName: userData?['lastName'] as String,
          email: userData?['email'] as String,
          hasBusiness: userData?['hasBusiness'] as bool,
          isAdmin: userData?['isAdmin'] as bool,
          isRegistrationComplete: userData?['isRegistrationComplete'] as bool,
          phoneNumber: userData?['mobileNumber'] as String,
          birthDate: userData?['birthDate'] as DateTime?,
          favCruisine: userData?['favCruisine'] as String?,
          favHangout: userData?['favHangout'] as String?,
          nationality: userData?['nationality'] as String?,
          gender: userData?['gender'] as String?);

      userProvider.setUser(userDetails);

      if (userDetails.isRegistrationComplete == false) {
        GoRouter.of(context).go('/profile');
      } else {
        if (userDetails.isAdmin == true) {
          // route to admin dashboard
        } else {
          GoRouter.of(context).go('/dashboard');
        }
      }
    }
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text(authErrorHandler(
              parseFirebaseAuthExceptionMessage(input: e.message)))),
    );
  } catch (e) {
    debugPrint(e.toString());
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
