class CuisineData {
  static final List<String> cuisines = [
    'Italian',
    'Mexican',
    'Japanese',
    'Chinese',
    'Indian',
    'Thai',
    'French',
    'Greek',
    'Spanish',
    'Korean',
    'Vietnamese',
    'Mediterranean',
    'American',
    'Brazilian',
    'Turkish',
    'Lebanese',
    'Moroccan',
    'Russian',
    'Swedish',
    'Peruvian',
  ];

//display the suggestion
  static List<String> getSuggestions(String query) =>
      List.of(cuisines).where((cuisine) {
        final cusinineLower = cuisine.toLowerCase();
        final queryLower = query.toLowerCase();

        return cusinineLower.contains(queryLower);
      }).toList();
}

class HangoutData {
  static final List<String> hangoutplaces = [
    'Italian',
    'Mexican',
    'Japanese',
    'Chinese',
    'Indian',
    'Thai',
    'French',
    'Greek',
    'Spanish',
    'Korean',
    'Vietnamese',
    'Mediterranean',
    'American',
    'Brazilian',
    'Turkish',
    'Lebanese',
    'Moroccan',
    'Russian',
    'Swedish',
    'Peruvian',
  ];

//display the suggestion
  static List<String> getSuggestions(String query) =>
      List.of(hangoutplaces).where((hangout) {
        final hangoutLower = hangout.toLowerCase();
        final queryLower = query.toLowerCase();

        return hangoutLower.contains(queryLower);
      }).toList();
}
