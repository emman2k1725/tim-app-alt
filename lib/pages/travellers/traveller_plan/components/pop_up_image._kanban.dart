import 'package:flutter/material.dart';

class PopUpImageKanban extends StatefulWidget {
  const PopUpImageKanban({super.key});

  @override
  State<PopUpImageKanban> createState() => _PopUpImageKanbanState();
}

class _PopUpImageKanbanState extends State<PopUpImageKanban> {
  final List<String> images = [
    'https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=3367&q=80',
    'https://images.unsplash.com/photo-1595231776515-ddffb1f4eb73?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1590502593747-42a996133562?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=975&q=80',
  ];
  final PageController _pageViewController =
      PageController(initialPage: 0); // set the initial page you want to show

  int _activePage = 0;

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: 200,
      child: Row(
        children: [
          // Left side: Container with PageView
          Column(
            children: [
              Container(
                height: 150,
                width: 200,
                child: Stack(
                  children: [
                    PageView.builder(
                        scrollDirection: Axis.horizontal,
                        controller: _pageViewController,
                        onPageChanged: (int index) {
                          setState(() {
                            _activePage = index;
                          });
                        },
                        itemCount: images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Image.network(
                            images[index],
                            fit: BoxFit.cover,
                          );
                        }),
                    //creating dots at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 40,
                      child: Container(
                        height: 50,
                        color: Colors.black12,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(
                              images.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: InkWell(
                                      onTap: () {
                                        _pageViewController.animateToPage(index,
                                            duration: const Duration(
                                                milliseconds: 300),
                                            curve: Curves.easeIn);
                                      },
                                      child: CircleAvatar(
                                        radius: 5,
                                        // check if a dot is connected to the current page
                                        // if true, give it a different color
                                        backgroundColor: _activePage == index
                                            ? Colors.greenAccent
                                            : Colors.white30,
                                      ),
                                    ),
                                  )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Right side: Container with Content
          Expanded(
            child: Container(
              width: 200,
              color: Colors.white,
              child: Center(
                child: Text(
                  'Content Area',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
