import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:tim_app/backend/firebase/fetchDropDown.dart';
import 'package:tim_app/backend/travel_plan/travelPlanFunction.dart';
import 'package:tim_app/data/draggable_lists.dart';
import 'package:tim_app/model/draggable_model.dart';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:tim_app/pages/travellers/traveller_plan/components/pop_up_image._kanban.dart';
import 'package:tim_app/utils/constants.dart';
import 'package:tim_app/utils/responsive.dart';

class DraggableContainer extends StatefulWidget {
  final List<List<Map<String, dynamic>>> travelitenerary;
  final Map<String, dynamic> traveliteneraryParameters;
  const DraggableContainer(
      {super.key,
      required this.travelitenerary,
      required this.traveliteneraryParameters});

  @override
  _DraggableContainer createState() => _DraggableContainer();
}

class _DraggableContainer extends State<DraggableContainer> {
  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();

    // create the draggable List
    List<DraggableList> generateDraggableLists(
        List<List<Map<String, dynamic>>> travelitenerary) {
      List<DraggableList> draggableLists = [];
      int x = 0;
      for (List<Map<String, dynamic>> dayData in travelitenerary) {
        String header = "Day ${x + 1}";
        String subText = widget.traveliteneraryParameters['dates'][x];
        x++;
        List<DraggableListItem> items = [];

        for (int i = 0; i < dayData.length + 1; i++) {
          if (i < dayData.length) {
            items.add(DraggableListItem(
                title: dayData[i]['businessName'],
                urlImage: dayData[i]['displayImage'],
                address: dayData[i]['address'],
                rating: dayData[i]['rating'].toString(),
                timeSchedule: dayData[i]['timeSchedule']));
          } else {
            // items.add(DraggableListItem(
            //     title: '',
            //     urlImage: '',
            //     address: '',
            //     rating: (4.1).toString(),
            //     timeSchedule: ''));
          }
        }
        DraggableList draggableList = DraggableList(
          header: header,
          subText: subText,
          items: items,
        );

        draggableLists.add(draggableList);
      }

      return draggableLists;
    }

    List<DraggableList> allLists =
        generateDraggableLists(widget.travelitenerary);

    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color.fromARGB(82, 23, 3, 128);
    bool _isExpanded = false;

    void _toggleExpanded() {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }

    return Expanded(
      child: SizedBox(
        width: double.maxFinite,
        child: DragAndDropLists(
          listPadding: const EdgeInsets.all(16),
          listInnerDecoration: BoxDecoration(
            border: Border.all(
              color: Colors.blue, // Change the border color here
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          axis: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          listWidth: 350,
          listDraggingWidth: 150,
          children: lists,
          itemDivider:
              const Divider(thickness: 2, height: 2, color: backgroundColor),
          itemDecorationWhileDragging: const BoxDecoration(
            color: Colors.blue,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          itemDragHandle: buildDragHandle(isList: true),
          onItemReorder: onReorderListItem,
          onListReorder: onReorderList,
          lastItemTargetHeight: 300, // Set the height of the last item target
          addLastItemTargetHeightToTop:
              false, // If true, add the target height to the top, otherwise to the bottom
          lastListTargetSize: 110, // Set the size of the last list target
        ),
      ),
    );
  }

  DragHandle buildDragHandle({bool isList = false}) {
    final verticalAlignment = isList
        ? DragHandleVerticalAlignment.top
        : DragHandleVerticalAlignment.center;
    final color = isList ? Colors.blueGrey : Colors.blue;

    return DragHandle(
      verticalAlignment: verticalAlignment,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          padding: const EdgeInsets.only(right: 10, bottom: 10),
          child: Icon(Icons.drag_indicator_outlined, color: color),
        ),
      ),
    );
  }

  DragAndDropList buildList(DraggableList list) => DragAndDropList(
        header: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  list.header,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  list.subText,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
              ],
            ),
          ),
        ),
        children: list.items
            .map((item) => DragAndDropItem(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: SingleChildScrollView(
                      child: ExpansionTile(
                        onExpansionChanged: (value) {},
                        title: ListTile(
                          leading: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                _showImagePopUp(context);
                              },
                              child: item.urlImage.isEmpty == true
                                  ? Image.asset(
                                      emptyImage,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      item.urlImage,
                                      width: 30,
                                      height: 30,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                          title: Text(item.title,
                              style: const TextStyle(color: Colors.white)),
                          subtitle: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(item.timeSchedule,
                                      style: const TextStyle(
                                          color: Colors.white))),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.rating,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  RatingBar.builder(
                                      initialRating: double.parse(item.rating),
                                      ignoreGestures: true,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemSize: 20.0,
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.yellow),
                                      onRatingUpdate: (rating) {}),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Text(
                              item.address,
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ))
            .toList(),
      );

  void onReorderListItem(
    int oldItemIndex,
    int oldListIndex,
    int newItemIndex,
    int newListIndex,
  ) {
    setState(() {
      final oldListItems = lists[oldListIndex].children;
      final newListItems = lists[newListIndex].children;
      final movedItem = oldListItems.removeAt(oldItemIndex);
      newListItems.insert(newItemIndex, movedItem);
      // Update Time and Database
      Map<String, dynamic> temp =
          widget.travelitenerary[oldListIndex][oldItemIndex];
      widget.travelitenerary[oldListIndex].removeAt(oldItemIndex);
      widget.travelitenerary[newListIndex].insert(newItemIndex, temp);
      fixTimeArrangement();
    });
  }

  void onReorderList(
    int oldListIndex,
    int newListIndex,
  ) {
    setState(() {
      final movedList = lists.removeAt(oldListIndex);
      lists.insert(newListIndex, movedList);
    });
  }

  void fixTimeArrangement() async {
    try {
      List<Map<String, dynamic>> hangoutPlaces =
          await FirebaseService.fetchHangout();

      for (int i = 0;
          i < widget.traveliteneraryParameters['startTime'].length;
          i++) {
        String currentTime = widget.traveliteneraryParameters['startTime'][i];
        for (int y = 1; y <= widget.travelitenerary[i].length - 1; y++) {
          if (y == widget.travelitenerary[i].length) {
            widget.travelitenerary[i][y]['timeSchedule'] ==
                widget.traveliteneraryParameters['endTime'][i];
          }
          setState(() {
            widget.travelitenerary[i][y]['timeSchedule'] = currentTime;
          });

          currentTime = addMinutesToTime(
              currentTime,
              getAveTimeSpent(hangoutPlaces, 'hangout',
                  widget.travelitenerary[i][y]['sector'])!);
        }
      }
      debugPrint(widget.travelitenerary.toString());
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void _showImagePopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: 300,
          height: 150,
          child: AlertDialog(
            content: const PopUpImageKanban(), // Replace with your image URL
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
