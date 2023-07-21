import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tim_app/pages/containers/multidropdown.dart';

import '../../../backend/authservice/authentication.dart';
import '../../../backend/firebase/UserDataProvider.dart';
import '../../../backend/firebase/fetchDropDown.dart';
import '../../../model/UserModel.dart';

class ModalInterestCruisine extends StatefulWidget {
  const ModalInterestCruisine({super.key});

  @override
  State<ModalInterestCruisine> createState() => _ModalInterestCruisineState();
}

class _ModalInterestCruisineState extends State<ModalInterestCruisine> {
  Future<List<String>>? _dropdownCruisines;

  @override
  void initState() {
    super.initState();
    _dropdownCruisines = FirebaseService.fetchDropdownItems('cruisines');
  }

  List<String> selectedCruisines = [];

  void showMinimumSelectionError() {
    const snackBar = SnackBar(
      content: Text('Please select at least 3 items and a minimum of 5 items.'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    return AlertDialog(
      title: const Text('Edit Favourite Cruisines'),
      content: Container(
        width: 300,
        height: 200,
        child: FutureBuilder(
            future: _dropdownCruisines,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              List<String> fetchedItems = snapshot.data ?? [];
              List<MultiSelectItem<String>> dropdownCruisineItems = fetchedItems
                  .map((item) => MultiSelectItem<String>(item, item))
                  .toList();
              return MultiSelectDialogField(
                items: dropdownCruisineItems,
                chipDisplay: MultiSelectChipDisplay(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  chipColor: Colors.blue,
                ),
                title: const Text("Cruisines"),
                searchable: true,
                buttonIcon: const Icon(
                  Icons.restaurant_outlined,
                  color: Colors.blue,
                ),
                buttonText: const Text(
                  "Favourite Cruisines",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
                onConfirm: (values) {
                  if (values.length >= 3 && values.length <= 5) {
                    setState(() {
                      selectedCruisines = values.cast<String>();
                    });
                  } else {
                    showMinimumSelectionError();
                  }
                },
              );
            }),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedCruisines.isEmpty || selectedCruisines.length < 3) {
              Navigator.pop(context);
            } else {
              user?.favCruisine = selectedCruisines;
              userProvider.updateDocument(authProvider.user!.uid, user);
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class ModalInterestCity extends StatefulWidget {
  const ModalInterestCity({super.key});

  @override
  State<ModalInterestCity> createState() => _ModalInterestCityState();
}

class _ModalInterestCityState extends State<ModalInterestCity> {
  Future<List<String>>? _dropdowncities;

  @override
  void initState() {
    super.initState();
    _dropdowncities = FirebaseService.fetchDropdownItems('cities');
  }

  List<String> selectedCities = [];

  void showMinimumSelectionError() {
    const snackBar = SnackBar(
      content: Text('Please select at least 3 items and a minimum of 5 items.'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;
    return AlertDialog(
      title: const Text('Edit Top 5 Cities'),
      content: Container(
        width: 300,
        height: 200,
        child: FutureBuilder(
            future: _dropdowncities,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              List<String> fetchedItems = snapshot.data ?? [];
              List<MultiSelectItem<String>> dropdownCitiesItems = fetchedItems
                  .map((item) => MultiSelectItem<String>(item, item))
                  .toList();
              return MultiSelectDialogField(
                items: dropdownCitiesItems,
                chipDisplay: MultiSelectChipDisplay(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  chipColor: Colors.blue,
                ),
                title: const Text("Cities"),
                searchable: true,
                buttonIcon: const Icon(
                  Icons.restaurant_outlined,
                  color: Colors.blue,
                ),
                buttonText: const Text(
                  "Top 5 Cities",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
                onConfirm: (values) {
                  if (values.length == 5) {
                    setState(() {
                      selectedCities = values.cast<String>();
                    });
                  } else {
                    showMinimumSelectionError();
                  }
                },
              );
            }),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedCities.isEmpty || selectedCities.length < 5) {
              Navigator.pop(context);
            } else {
              user?.topCities = selectedCities;
              userProvider.updateDocument(authProvider.user!.uid, user);
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}

class ModalInterestActivity extends StatefulWidget {
  const ModalInterestActivity({super.key});

  @override
  State<ModalInterestActivity> createState() => _ModalInterestActivityState();
}

class _ModalInterestActivityState extends State<ModalInterestActivity> {
  Future<List<String>>? _dropdownInterests;

  @override
  void initState() {
    super.initState();
    _dropdownInterests = FirebaseService.fetchDropdownItems('hangout');
  }

  List<String> selectedInterests = [];

  void showMinimumSelectionError() {
    const snackBar = SnackBar(
      content: Text('Please select at least 3 items and a minimum of 5 items.'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    UserDataProvider userProvider = Provider.of<UserDataProvider>(context);
    UserModel? user = userProvider.userData;

    return AlertDialog(
      title: const Text('Edit Favourite Activities'),
      content: SizedBox(
        width: 300,
        height: 200,
        child: FutureBuilder(
            future: _dropdownInterests,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              List<String> fetchedItems = snapshot.data ?? [];
              List<MultiSelectItem<String>> dropdownInterestsItems =
                  fetchedItems
                      .map((item) => MultiSelectItem<String>(item, item))
                      .toList();
              return MultiSelectDialogField(
                items: dropdownInterestsItems,
                chipDisplay: MultiSelectChipDisplay(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  chipColor: Colors.blue,
                ),
                title: const Text("Activities"),
                searchable: true,
                buttonIcon: const Icon(
                  Icons.restaurant_outlined,
                  color: Colors.blue,
                ),
                buttonText: const Text(
                  "Favourite Activities",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 12,
                  ),
                ),
                onConfirm: (values) {
                  if (values.length >= 3 && values.length <= 5) {
                    setState(() {
                      selectedInterests = values.cast<String>();
                    });
                  } else {
                    showMinimumSelectionError();
                  }
                },
              );
            }),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (selectedInterests.isEmpty || selectedInterests.length < 3) {
              Navigator.pop(context);
            } else {
              user?.favHangout = selectedInterests;
              userProvider.updateDocument(authProvider.user!.uid, user);
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
