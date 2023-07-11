import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class SearchableDropdown extends StatefulWidget {
  @override
  _SearchableDropdownState createState() => _SearchableDropdownState();
}

class _SearchableDropdownState extends State<SearchableDropdown> {
  List<String> items = [
    'Item 1',
    'Item 2',
    'Item 3',
    'Item 4',
    'Item 5',
  ];

  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TypeAheadField<String?>(
          textFieldConfiguration: TextFieldConfiguration(
            decoration: InputDecoration(
              labelText: selectedItem ?? 'None',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
          ),
          suggestionsCallback: (pattern) {
            return items
                .where((item) =>
                    item.toLowerCase().contains(pattern.toLowerCase()))
                .toList();
          },
          itemBuilder: (context, String? suggestion) {
            return ListTile(
              title: Text(suggestion ?? ''),
            );
          },
          onSuggestionSelected: (String? suggestion) {
            setState(() {
              selectedItem = suggestion;
            });
          },
          noItemsFoundBuilder: (_) => ListTile(
            title: Text('No items found'),
          ),
        ),
        SizedBox(height: 16.0),
        Text(
          'Selected Item: ${selectedItem ?? 'None'}',
          style: TextStyle(fontSize: 16.0),
        ),
      ],
    );
  }
}
