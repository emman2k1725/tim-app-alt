import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:tim_app/pages/containers/multidropdown.dart';

class ModalInterestCruisine extends StatefulWidget {
  const ModalInterestCruisine({super.key});

  @override
  State<ModalInterestCruisine> createState() => _ModalInterestCruisineState();
}

class _ModalInterestCruisineState extends State<ModalInterestCruisine> {
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();

  @override
  void initState() {
    super.initState();
  }

  List<String> selectedItems = [];

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
    return AlertDialog(
      title: const Text('Edit Favourite Cruisines'),
      content: Container(
        width: 300,
        height: 200,
        child: MultiSelectDialogField(
          items: _items,
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
                selectedItems = values.cast<String>();
              });
            } else {
              showMinimumSelectionError();
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
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
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();

  @override
  void initState() {
    super.initState();
  }

  List<String> selectedItems = [];

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
    return AlertDialog(
      title: const Text('Edit Top 5 Cities'),
      content: Container(
        width: 300,
        height: 200,
        child: MultiSelectDialogField(
          items: _items,
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
            if (values.length >= 3 && values.length <= 5) {
              setState(() {
                selectedItems = values.cast<String>();
              });
            } else {
              showMinimumSelectionError();
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
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
  static final List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();

  @override
  void initState() {
    super.initState();
  }

  List<String> selectedItems = [];

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
    return AlertDialog(
      title: const Text('Edit Favourite Activities'),
      content: SizedBox(
        width: 300,
        height: 200,
        child: MultiSelectDialogField(
          items: _items,
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
                selectedItems = values.cast<String>();
              });
            } else {
              showMinimumSelectionError();
            }
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Submit'),
        ),
      ],
    );
  }
}
