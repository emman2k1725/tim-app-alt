import 'package:cloud_firestore/cloud_firestore.dart';

class BusinessModel {
  String? businessName;
  String? companyName;
  String? firstName;
  String? lastName;
  String? businessDesc;
  String? location;
  String? businessSector;
  String? businessPhoneNumber;
  String? businessEmail;
  String? rating;
  String? status;
  String? cruisine;
  int? reviewCount;
  Map<String, dynamic>? businessAddress;
  Map<String, dynamic>? businessLinks;
  List<dynamic>? category;
  List<Map<String, dynamic>>? businessImages;
  List<Map<String, dynamic>>? businessHours;
  DocumentReference? businessOwner;

  BusinessModel(
      {this.businessName,
      this.companyName,
      this.firstName,
      this.lastName,
      this.businessDesc,
      this.location,
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
      this.businessOwner});

  // Factory method to create a user model from a map or JSON data
  factory BusinessModel.fromMap(Map<String, dynamic> map) {
    return BusinessModel(
        businessName: map['businessName'],
        companyName: map['companyName'],
        firstName: map['firstName'],
        lastName: map['lastName'],
        businessDesc: map['businessDesc'],
        location: map['location'],
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
      'location': location,
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
