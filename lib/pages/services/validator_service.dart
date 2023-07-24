bool containsNumber(String? input) {
  if (input == null) {
    return false;
  }
  final RegExp regex = RegExp(r'[0-9]');
  return regex.hasMatch(input);
}

bool containsChar(String? input) {
  if (input == null) {
    return false;
  }
  final RegExp regex = RegExp(r'\D');
  return regex.hasMatch(input);
}
