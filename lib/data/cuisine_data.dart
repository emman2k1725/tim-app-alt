import 'package:tim_app/backend/firebase/fetchDropDown.dart';

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
