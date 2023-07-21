class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  bool? hasBusiness;
  bool? isAdmin;
  bool? isRegistrationComplete;
  DateTime? birthDate;
  String? mobileNumber;
  List<dynamic>? favCruisine;
  List<dynamic>? favHangout;
  List<dynamic>? topCities;
  String? travelCat;
  String? nationality;
  String? gender;
  Map<String, dynamic>? address;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.hasBusiness,
    this.isAdmin,
    this.isRegistrationComplete,
    this.mobileNumber,
    this.travelCat,
    this.birthDate,
    this.favCruisine,
    this.favHangout,
    this.topCities,
    this.gender,
    this.nationality,
    this.address,
  });

  void setFirstName(String? newFirstName) {
    firstName = newFirstName;
  }

  void setLastName(String? newLastName) {
    lastName = newLastName;
  }

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
        topCities: map['topCities'],
        gender: map['gender'],
        nationality: map['nationality'],
        address: map['address']);
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
      'topCities': topCities,
      'gender': gender,
      'nationality': nationality,
      'address': address
    };
  }
}
