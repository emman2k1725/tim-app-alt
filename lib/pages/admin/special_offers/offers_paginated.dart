import 'package:flutter/material.dart';

class PaginatedContainerList extends StatefulWidget {
  @override
  _PaginatedContainerListState createState() => _PaginatedContainerListState();
}

class _PaginatedContainerListState extends State<PaginatedContainerList> {
  late PageController _pageController;
  final int _totalPages = 5; // Replace this with the total number of pages
  final double _containerWidth = 200;
  final double _containerHeight = 150;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Paginated Containers'),
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration.zero),
        builder: (context, snapshot) {
          return PageView.builder(
            controller: _pageController,
            itemCount: _totalPages,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: 10, // Number of containers per page
                  itemBuilder: (context, containerIndex) {
                    int containerNumber = index * 10 + containerIndex + 1;
                    return Container(
                      width: _containerWidth,
                      height: _containerHeight,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Container $containerNumber',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (_pageController.page!.toInt() > 0)
            FloatingActionButton(
              onPressed: () {
                _pageController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(Icons.arrow_back),
            ),
          SizedBox(width: 10),
          if (_pageController.page!.toInt() < _totalPages - 1)
            FloatingActionButton(
              onPressed: () {
                _pageController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Icon(Icons.arrow_forward),
            ),
        ],
      ),
    );
  }
}
