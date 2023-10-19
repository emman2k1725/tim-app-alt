class CityModel {
  String? city;
  String? lat;
  String? long;

  CityModel({
    this.city,
    this.lat,
    this.long,
  });

  // Factory method to create a user model from a map or JSON data
  factory CityModel.fromMap(Map<String, dynamic> map) {
    return CityModel(
      city: map['city'],
      lat: map['lat'],
      long: map['long'],
    );
  }

  // Method to convert the user model to a map or JSON data
  Map<String, dynamic> toMap() {
    return {
      'city': city,
      'lat': lat,
      'long': long,
    };
  }
}
