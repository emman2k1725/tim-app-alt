import 'package:flutter/material.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Animal {
  final int id;
  final String name;

  Animal({
    required this.id,
    required this.name,
  });
}

class Multidropdown extends StatefulWidget {
  Multidropdown({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  _MultidropdownState createState() => _MultidropdownState();
}

class _MultidropdownState extends State<Multidropdown> {
  static List<Animal> _animals = [
    Animal(id: 1, name: "Lion"),
    Animal(id: 2, name: "Flamingo"),
    Animal(id: 3, name: "Hippo"),
    Animal(id: 4, name: "Horse"),
    Animal(id: 5, name: "Tiger"),
    Animal(id: 6, name: "Penguin"),
    Animal(id: 7, name: "Spider"),
    Animal(id: 8, name: "Snake"),
    Animal(id: 9, name: "Bear"),
    Animal(id: 10, name: "Beaver"),
    Animal(id: 11, name: "Cat"),
    Animal(id: 12, name: "Fish"),
    Animal(id: 13, name: "Rabbit"),
    Animal(id: 14, name: "Mouse"),
    Animal(id: 15, name: "Dog"),
    Animal(id: 16, name: "Zebra"),
    Animal(id: 17, name: "Cow"),
    Animal(id: 18, name: "Frog"),
    Animal(id: 19, name: "Blue Jay"),
    Animal(id: 20, name: "Moose"),
    Animal(id: 21, name: "Gecko"),
    Animal(id: 22, name: "Kangaroo"),
    Animal(id: 23, name: "Shark"),
    Animal(id: 24, name: "Crocodile"),
    Animal(id: 25, name: "Owl"),
    Animal(id: 26, name: "Dragonfly"),
    Animal(id: 27, name: "Dolphin"),
  ];
  final _items = _animals
      .map((animal) => MultiSelectItem<Animal>(animal, animal.name))
      .toList();
  //List<Animal> _selectedAnimals = [];
  List<Animal> _selectedAnimals2 = [];
  List<Animal> _selectedAnimals3 = [];
  //List<Animal> _selectedAnimals4 = [];
  List<Animal> _selectedAnimals5 = [];
  final _multiSelectKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    _selectedAnimals5 = _animals;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              SizedBox(height: 40),
              MultiSelectDialogField(
                chipDisplay: MultiSelectChipDisplay(
                  shape: StadiumBorder(side: BorderSide(color: Colors.grey)),
                  textStyle: TextStyle(
                    fontSize: 16, // Adjust the font size as needed
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  items: _items,
                  chipColor: Colors.blue,

                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(
                        0.2), // Set the background color of the chips
                    borderRadius: BorderRadius.circular(
                        10), // Set the border radius of the chips
                    border: Border.all(
                        color: Colors.blue,
                        width:
                            2), // Set the border color and width of the chips
                  ),
                  onTap: (item) {
                    // Handle chip tap event
                  },
                  chipWidth: 100, // Adjust the width of the chips as needed
                  height: 10, // Adjust the height of the chips as needed
                ),

                items: _items,
                title: Text("Animals"),
                searchable: true,
                // selectedColor: Colors.red,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
                buttonIcon: Icon(
                  Icons.pets,
                  color: Colors.blue,
                ),
                buttonText: Text(
                  "Favorite Cuisines",
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 12,
                  ),
                ),
                onConfirm: (results) {
                  //_selectedAnimals = results;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
