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
      debugShowCheckedModeBanner: false,
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
  bool _isRailVisible = false;

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
              leading: Text('Folders'),
              trailing: Icon(Icons.settings),
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              labelType: NavigationRailLabelType.none,
              destinations: const <NavigationRailDestination>[
                NavigationRailDestination(
                  icon: Icon(Icons.folder),
                  selectedIcon: Icon(Icons.folder),
                  label: Text('Favorites'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.expand_more),
                  selectedIcon: Icon(Icons.expand_more),
                  label: Text('All Snippets', selectionColor: Colors.grey,),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.expand_more),
                  selectedIcon: Icon(Icons.expand_more),
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
