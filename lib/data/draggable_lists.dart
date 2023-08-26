import 'package:tim_app/model/draggable_model.dart';

List<DraggableList> allLists = [
  const DraggableList(
    header: 'Day 1',
    subText: '08/10/2023',
    items: [
      DraggableListItem(
        title: 'The Savory Spoon',
        urlImage: 'assets/images/businessLogo.jpg',
      ),
      DraggableListItem(
        title: 'UrbanBites',
        urlImage: 'assets/images/restaurant1.jpg',
      ),
    ],
  ),
  const DraggableList(
    header: 'Day 2',
    subText: '08/11/2023',
    items: [
      DraggableListItem(
        title: 'SeaSalt Eats',
        urlImage: 'assets/images/restaurant2.jpg',
      ),
      DraggableListItem(
        title: 'Fusion Flavors',
        urlImage: 'assets/images/restaurant3.jpg',
      ),
      DraggableListItem(
        title: 'Coastal Catch',
        urlImage: 'assets/images/restaurant4.jpg',
      ),
    ],
  ),
  const DraggableList(
    header: 'Day 3',
    subText: '08/12/2023',
    items: [
      DraggableListItem(
        title: 'The Hungry Hive',
        urlImage: 'assets/images/restaurant4.jpg',
      ),
      DraggableListItem(
        title: 'The Green Fork',
        urlImage: 'assets/images/restaurant3.jpg',
      ),
      DraggableListItem(
        title: 'Fireside Feast',
        urlImage: 'assets/images/restaurant1.jpg',
      ),
    ],
  ),
];
