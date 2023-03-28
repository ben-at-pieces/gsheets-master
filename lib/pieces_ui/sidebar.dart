import 'package:flutter/material.dart';

class FloatingActionButtonWithSideBar extends StatefulWidget {
  @override
  _FloatingActionButtonWithSideBarState createState() =>
      _FloatingActionButtonWithSideBarState();
}

class _FloatingActionButtonWithSideBarState
    extends State<FloatingActionButtonWithSideBar> {
  String? _newValue;

  bool _isSideBarVisible = false;

  void _toggleSideBar() {
    setState(() {
      _isSideBarVisible = !_isSideBarVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        FloatingActionButton(
          onPressed: _toggleSideBar,
          child: Icon(Icons.menu),
        ),
        AnimatedPositioned(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          left: _isSideBarVisible ? 0 : -200,
          child: Container(
            width: 200,
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Folders',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 0,
                  color: Colors.grey[400],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Favorites',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'All',
                        style: TextStyle(fontSize: 14),
                      ),
                      Text(
                        'Work',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 1,
                  height: 0,
                  color: Colors.grey[400],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Tags',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Favorites',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        height: 0,
                        color: Colors.grey[400],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Some tag 1',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Some tag 2',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
