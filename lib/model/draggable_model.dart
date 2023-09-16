class DraggableList {
  final String header;
  final String subText;
  final List<DraggableListItem> items;

  const DraggableList({
    required this.header,
    required this.subText,
    required this.items,
  });
}

class DraggableListItem {
  final String title;
  final String urlImage;
  final String address;
  final String rating;
  final String timeSchedule;

  const DraggableListItem(
      {required this.title,
      required this.urlImage,
      required this.address,
      required this.rating,
      required this.timeSchedule});
}
