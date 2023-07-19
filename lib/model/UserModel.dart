import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? hasBusiness;
  final bool? isAdmin;
  final bool? isRegistrationComplete;
  final DateTime? birthDate;
  final String? mobileNumber;
  final String? favCruisine;
  final String? favHangout;
  final String? travelCat;
  final String? nationality;
  final String? gender;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.email,
    this.hasBusiness,
    this.isAdmin,
    this.isRegistrationComplete,
    this.mobileNumber,
    this.travelCat,
    this.birthDate,
    this.favCruisine,
    this.favHangout,
    this.gender,
    this.nationality,
  });

  // Factory method to create a user model from a map or JSON data
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        firstName: map['firstName'],
        lastName: map['lastName'],
        email: map['email'],
        hasBusiness: map['hasBusiness'],
        isAdmin: map['isAdmin'],
        isRegistrationComplete: map['isRegistrationComplete'],
        mobileNumber: map['mobileNumber'],
        travelCat: map['travelCat'],
        birthDate: map['birthDate'],
        favCruisine: map['favCruisine'],
        favHangout: map['favHangout'],
        gender: map['gender'],
        nationality: map['nationality']);
  }

  // Method to convert the user model to a map or JSON data
  Map<String, dynamic> toMap() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'hasBusiness': hasBusiness,
      'isAdmin': isAdmin,
      'isRegistrationComplete': isRegistrationComplete,
      'mobileNumber': mobileNumber,
      'travelCat': travelCat,
      'birthDate': birthDate,
      'favCruisine': favCruisine,
      'favHangout': favHangout,
      'gender': gender,
      'nationality': nationality
    };
  }
}
