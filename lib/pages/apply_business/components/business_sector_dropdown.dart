import 'package:flutter/material.dart';

class BUsinessDropdown extends StatefulWidget {
  const BUsinessDropdown({super.key});
  @override
  _BUsinessDropdownState createState() => _BUsinessDropdownState();
}

class _BUsinessDropdownState extends State<BUsinessDropdown> {
  String? selectedBusinessSector;
  String? selectedCuisine;

  List<String> businessSectors = [
    'Restaurant',
    'Retail',
    'Healthcare',
    'Technology',
    'Cafe'
  ];

  Map<String, List<String>> cuisinesByBusinessSector = {
    'Restaurant': ['Italian', 'Chinese', 'Indian', 'Mexican'],
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: const Text(
              'Business Sector',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16.0),
          DropdownButtonFormField<String>(
            value: selectedBusinessSector,
            items: businessSectors.map((sector) {
              return DropdownMenuItem<String>(
                value: sector,
                child: Text(sector),
              );
            }).toList(),
            decoration: InputDecoration(
              labelText: 'Business Sector',
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.blue),
                borderRadius:
                    BorderRadius.circular(20.0), // Set the border radius
              ),
            ),
            onChanged: (value) {
              setState(() {
                selectedBusinessSector = value;
                selectedCuisine =
                    null; // Reset the selected cuisine when business sector changes
              });
            },
          ),
          SizedBox(height: 16),
          if (selectedBusinessSector == 'Restaurant' ||
              selectedBusinessSector == 'Cafe')
            DropdownButtonFormField<String>(
              value: selectedCuisine,
              items: cuisinesByBusinessSector['Restaurant']!.map((cuisine) {
                return DropdownMenuItem<String>(
                  value: cuisine,
                  child: Text(cuisine),
                );
              }).toList(),
              decoration: InputDecoration(
                labelText: 'Cruisines',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius:
                      BorderRadius.circular(20.0), // Set the border radius
                ),
              ),
              onChanged: (value) {
                setState(() {
                  selectedCuisine = value;
                });
              },
            ),
        ],
      ),
    );
  }
}
