import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../backend/firebase/businessDataProvider.dart';
import '../../../backend/firebase/fetchDropDown.dart';
import '../../../model/BusinessModel.dart';

class BUsinessDropdown extends StatefulWidget {
  const BUsinessDropdown({super.key});
  @override
  _BUsinessDropdownState createState() => _BUsinessDropdownState();
}

class _BUsinessDropdownState extends State<BUsinessDropdown> {
  String? selectedBusinessSector;
  String? selectedCruisine;
  Future<List<String>>? _dropdownCruisines;
  Future<List<String>>? _dropdownTravelCat;
  Future<List<String>>? _dropdownSector;

  @override
  void initState() {
    super.initState();
    _dropdownTravelCat = FirebaseService.fetchDropdownItems('travellerType');
    _dropdownCruisines = FirebaseService.fetchDropdownItems('cruisines');
    _dropdownSector = FirebaseService.fetchDropdownItems('hangout');
  }

  @override
  Widget build(BuildContext context) {
    BusinessDataProvider businessProvider =
        Provider.of<BusinessDataProvider>(context);
    BusinessModel? business = businessProvider.businessData;
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
          FutureBuilder(
            future: _dropdownSector,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              List<String> fetchedItems = snapshot.data ?? [];

              return DropdownButtonFormField<String>(
                value: selectedBusinessSector,
                items: fetchedItems.map((sector) {
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
                    selectedCruisine =
                        null; // Reset the selected cuisine when business sector changes
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select business sector';
                  }
                },
                onSaved: (value) {
                  business?.businessSector = value;
                },
              );
            },
          ),
          const SizedBox(height: 16),
          if (selectedBusinessSector == 'Restaurant' ||
              selectedBusinessSector == 'Cafe')
            FutureBuilder(
                future: _dropdownCruisines,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  List<String> fetchedItems = snapshot.data ?? [];
                  return DropdownButtonFormField<String>(
                    value: selectedCruisine,
                    items: fetchedItems!.map((cruisine) {
                      return DropdownMenuItem<String>(
                        value: cruisine,
                        child: Text(cruisine),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      labelText: 'Cruisines',
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the border radius
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        selectedCruisine = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select cruisine';
                      }
                    },
                    onSaved: (value) {
                      business?.cruisine = value;
                    },
                  );
                }),
        ],
      ),
    );
  }
}
