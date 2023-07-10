import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';


class LoginPageModel {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController1;
  String? Function(BuildContext, String?)? emailAddressController1Validator;
  // State field(s) for password widget.
  TextEditingController? passwordController1;
  late bool passwordVisibility1;
  String? Function(BuildContext, String?)? passwordController1Validator;
  // State field(s) for emailAddress widget.
  TextEditingController? emailAddressController2;
  String? Function(BuildContext, String?)? emailAddressController2Validator;
  // State field(s) for password widget.
  TextEditingController? passwordController2;
  late bool passwordVisibility2;
  String? Function(BuildContext, String?)? passwordController2Validator;
  // State field(s) for password widget.
  TextEditingController? passwordController3;
  late bool passwordVisibility3;
  String? Function(BuildContext, String?)? passwordController3Validator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    passwordVisibility1 = false;
    passwordVisibility2 = false;
    passwordVisibility3 = false;
  }

  void dispose() {
    unfocusNode.dispose();
    emailAddressController1?.dispose();
    passwordController1?.dispose();
    emailAddressController2?.dispose();
    passwordController2?.dispose();
    passwordController3?.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}
