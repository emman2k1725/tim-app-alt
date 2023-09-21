import 'package:flutter/material.dart';
import '../../../../backend/firebase/fetchDropDown.dart';
import '../../../../model/BusinessModel.dart';

class BUsinessDropdown extends StatefulWidget {
  final BusinessModel? businessModel;
  const BUsinessDropdown({super.key, required this.businessModel});
  @override
  _BUsinessDropdownState createState() => _BUsinessDropdownState();
}

class _BUsinessDropdownState extends State<BUsinessDropdown> {
  String? selectedBusinessSector;
  String? selectedCruisine;
  Future<List<String>>? _dropdownCruisines;
  // Future<List<String>>? _dropdownTravelCat;
  Future<List<String>>? _dropdownSector;

  @override
  void initState() {
    super.initState();
    // _dropdownTravelCat = FirebaseService.fetchDropdownItems('travellerType');
    _dropdownCruisines = FirebaseService.fetchDropdownItems('cruisines');
    _dropdownSector = FirebaseService.fetchDropdownItems('hangout');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                  return null;
                },
                onSaved: (value) {
                  widget.businessModel?.businessSector = value;
                },
              );
            },
          ),
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
                    items: fetchedItems.map((cruisine) {
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
                      return null;
                    },
                    onSaved: (value) {
                      widget.businessModel?.cruisine = value;
                    },
                  );
                }),
        ],
      ),
    );
  }
}
