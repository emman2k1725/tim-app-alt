class ContentModel {
  String? contentTitle;
  String? contentType;
  DateTime? createdAt;
  String? description;
  String? displayImage;
  String? website;

  ContentModel({
    this.contentTitle,
    this.contentType,
    this.createdAt,
    this.description,
    this.displayImage,
    this.website,
  });

  // Factory method to create a user model from a map or JSON data
  factory ContentModel.fromMap(Map<String, dynamic> map) {
    return ContentModel(
      contentTitle: map['contentTitle'],
      contentType: map['contentType'],
      createdAt: map['createdAt'],
      description: map['description'],
      displayImage: map['displayImage'],
      website: map['website'],
    );
  }

  // Method to convert the user model to a map or JSON data
  Map<String, dynamic> toMap() {
    return {
      'contentTitle': contentTitle,
      'contentType': contentType,
      'createdAt': createdAt,
      'description': description,
      'displayImage': displayImage,
      'website': website,
    };
  }
}
