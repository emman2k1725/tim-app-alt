import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class BusinessModel {
  String? businessName, companyName, firstName, lastName, businessDesc;
  String? businessSector, businessEmail;
  String? rating, status, cruisine;
  int? reviewCount;
  Map<String, dynamic>? businessAddress;
  Map<String, dynamic>? businessLinks, businessImages;
  Map<String, dynamic>? businessPhoneNumber;
  List<dynamic>? category;
  Map<String, List<String?>>? businessHours;
  String? businessOwner;

  Uint8List? pickedLogo, pickedImage1, pickedImage2, pickedImage3;

  BusinessModel({
    this.businessName,
    this.companyName,
    this.firstName,
    this.lastName,
    this.businessDesc,
    this.businessSector,
    this.businessPhoneNumber,
    this.businessEmail,
    this.rating,
    this.status,
    this.reviewCount,
    this.businessAddress,
    this.businessLinks,
    this.category,
    this.cruisine,
    this.businessImages,
    this.businessHours,
    this.businessOwner,
    this.pickedLogo,
    this.pickedImage1,
    this.pickedImage2,
    this.pickedImage3,
  });

  factory BusinessModel.withDefaultValues() {
    return BusinessModel(
      businessAddress: {
        'building': '',
        'street': '',
        'city': '',
        'state': '',
        'postal': '',
        'country': '',
      },
      businessPhoneNumber: {'countryCode': '', 'number': ''},
      businessLinks: {'googleMap': '', 'facebook': '', 'instagram': ''},
      businessImages: {'logo': '', 'image1': '', 'image2': '', 'image3': ''},
      businessHours: {
        'Monday': ['09:00', '21:00'],
        'Tuesday': ['09:00', '21:00'],
        'Wednesday': ['09:00', '21:00'],
        'Thursday': ['09:00', '21:00'],
        'Friday': ['09:00', '21:00'],
        'Saturday': ['09:00', '21:00'],
        'Sunday': ['09:00', '21:00']
      },
      status: 'Pending',
      rating: '0',
      reviewCount: 0,
    );
  }

  // Factory method to create a user model from a map or JSON data
  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
        businessName: map['businessName'],
        companyName: map['companyName'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        businessDesc: map['businessDesc'],
        businessSector: map['businessSector'],
        businessPhoneNumber: map['businessPhoneNumber'],
        businessEmail: map['businessEmail'],
        rating: map['rating'],
        status: map['status'],
        reviewCount: map['reviewCount'],
        businessAddress: map['businessAddress'],
        businessLinks: map['businessLinks'],
        category: map['category'],
        cruisine: map['cruisine'],
        businessImages: map['businessImages'],
        businessHours: map['businessHours'],
        businessOwner: map['nationality']);
  }

  // Method to convert the user model to a map or JSON data
  Map<String, dynamic> toMap() {
    return {
      'businessName': businessName,
      'companyName': companyName,
      'firstName': firstName,
      'lastName': lastName,
      'businessDesc': businessDesc,
      'businessSector': businessSector,
      'businessPhoneNumber': businessPhoneNumber,
      'businessEmail': businessEmail,
      'rating': rating,
      'status': status,
      'reviewCount': reviewCount,
      'businessAddress': businessAddress,
      'businessLinks': businessLinks,
      'category': category,
      'cruisine': cruisine,
      'businessImages': businessImages,
      'businessHours': businessHours,
      'businessOwner': businessOwner
    };
  }
}
