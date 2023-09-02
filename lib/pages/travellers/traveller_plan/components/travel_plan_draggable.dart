import 'package:flutter/material.dart';
import 'package:tim_app/data/draggable_lists.dart';
import 'package:tim_app/model/draggable_model.dart';

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:tim_app/pages/travellers/traveller_plan/components/pop_up_image._kanban.dart';
import 'package:tim_app/utils/responsive.dart';

class DraggableContainer extends StatefulWidget {
  const DraggableContainer({super.key});

  @override
  _DraggableContainer createState() => _DraggableContainer();
}

class _DraggableContainer extends State<DraggableContainer> {
  late List<DragAndDropList> lists;

  @override
  void initState() {
    super.initState();

    lists = allLists.map(buildList).toList();
  }

  @override
  Widget build(BuildContext context) {
    // final backgroundColor = Color.fromARGB(255, 243, 242, 248);
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
        height: 700,
        child: DragAndDropLists(
          listPadding: const EdgeInsets.all(16),
          listInnerDecoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
            borderRadius: BorderRadius.circular(10),
          ),
          axis: Responsive.isDesktop(context) ? Axis.horizontal : Axis.vertical,
          listWidth: 350,
          listDraggingWidth: 150,
          children: lists,
          itemDivider: Divider(thickness: 2, height: 2, color: backgroundColor),
          itemDecorationWhileDragging: const BoxDecoration(
            color: Colors.white,
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
          ),
          listDragHandle: buildDragHandle(isList: true),
          itemDragHandle: buildDragHandle(isList: true),
          onItemReorder: onReorderListItem,
          onListReorder: onReorderList,
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
        header: Container(
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
        children: list.items
            .map((item) => DragAndDropItem(
                  child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: ExpansionTile(
                        onExpansionChanged: (value) {},
                        title: ListTile(
                          leading: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: GestureDetector(
                              onTap: () {
                                _showImagePopUp(context);
                              },
                              child: Image.asset(
                                item.urlImage,
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          title: Text(item.title),
                          subtitle: Column(
                            children: [
                              Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(item.title)),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star_half, color: Colors.yellow),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              child: Text(
                                'Expanded content goes here.',
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ],
                      )),
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

  void _showImagePopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          width: 300,
          height: 150,
          child: AlertDialog(
            content: const PopUpImageKanban(), // Replace with your image URL
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'),
              ),
            ],
          ),
        );
      },
    );
  }
}
