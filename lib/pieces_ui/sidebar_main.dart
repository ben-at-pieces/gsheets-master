import 'package:flutter/material.dart';
import 'package:gsheets/pieces_ui/dropdown.dart';
import 'package:gsheets/pieces_ui/search.dart';

import 'carousel.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NavRailExample(),
    );
  }
}

class NavRailExample extends StatefulWidget {
  const NavRailExample({Key? key}) : super(key: key);

  @override
  _NavRailExampleState createState() => _NavRailExampleState();
}

class _NavRailExampleState extends State<NavRailExample> {
  int _selectedIndex = 0;
  bool _isRailVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        title: SearchBar(),
        leadingWidth: 300,
        leading: Padding(
          padding: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [

              /// This code creates a button with a menu icon that toggles the visibility of a rail when pressed.

              IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  setState(() {
                    _isRailVisible = !_isRailVisible;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownWidget(
                  selectedOption: 'Carousel',
                ),
              ),
            ],
          ),
        ),
      ),
      body: Row(
        children: <Widget>[
          Visibility(
            visible: _isRailVisible,
            child: NavigationRail(
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.none,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.favorite_border),
                  selectedIcon: Icon(Icons.favorite),
                  label: Text('First'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.bookmark_border),
                  selectedIcon: Icon(Icons.book),
                  label: Text('Second'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.star_border),
                  selectedIcon: Icon(Icons.star),
                  label: Text('Third'),
                ),
              ],
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(
            child: CarouselDemo(),
          ),
        ],
      ),
    );
  }
}
 // This code creates a layout with a NavigationRail and a CarouselDemo widget. The NavigationRail allows the user to select between three options, while the CarouselDemo widget takes up the remaining space and displays content.
