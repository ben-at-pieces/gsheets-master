import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';

import '../Bottom_bar/bottom_appbar_class.dart';

class SearchableListView extends StatefulWidget {
  @override
  _SearchableListViewState createState() => _SearchableListViewState();
}

class _SearchableListViewState extends State<SearchableListView> {
  // list of items to display in the ListView
  final List<String> _items = [
    'Single-Click Save',
    'VS Code list view and Overview',
    'Save to Pieces'
    'Proactive Save -VS Code',
    'Share Code with Shareable Links',
    'Automatic Smart Descriptions',
    'Shareable Links',
    'Renaming an Asset',
    'Reclassify Snippet',
    'Workflow Activity View',
    'Snippet Discovery',
    'Getting Started with VS Code',
    'Insert a Snippet',
    'Custom Subdomains',
    'Working with Sensitives',
    'Information View',
    'AutoComplete',
    'AutoExpansion',
    'Save to Pieces As',
    'Collections',
    'Pieces OS',
    'bracket Control',
  ];

  final List<String> _items2 = [
    '''Github issue requesting more clarity with respect to the filter snippets based on the current files extension.

The following three options are the only bit of information users currently get when viewing within settings.

1. none
2. moderate
3. strict

There is an explanation for this feature but circling back to the feature in the production view I am not confident that our users will understand whats going on.

https://github.com/pieces-app/plugin_jetbrains/issues/78''',

    '''MacOS:
  System Trey >-> Settings >-> Tools >-> Pieces

  Windows:
  File >-> Settings >-> Pieces'',''',

    'Save to Pieces'
        'Proactive Save -VS Code',
    'Share Code with Shareable Links',
    'Automatic Smart Descriptions',
    'Shareable Links',
    'Renaming an Asset',
    'Reclassify Snippet',
    'Workflow Activity View',
    'Snippet Discovery',
    'Getting Started with VS Code',
    'Insert a Snippet',
    'Custom Subdomains',
    'Working with Sensitives',
    'Information View',
    'AutoComplete',
    'AutoExpansion',
    'Save to Pieces As',
    'Collections',
    'Pieces OS',
    'bracket Control',
  ];

  // list of items filtered based on user's search
  List<String> _filteredItems = [];

  // controller for the search TextField
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // initialize filtered items to the full list of items
    _filteredItems = _items;

    // listen for changes to the search TextField
    _searchController.addListener(() {
      // get the current value of the TextField
      String searchText = _searchController.text;

      // filter the list of items based on the search text
      setState(() {
        _filteredItems =
            _items.where((item) => item.toLowerCase().contains(searchText.toLowerCase())).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backwardsCompatibility: false,
        backgroundColor: Colors.grey,
        // toolbarHeight: 40,
        // titleSpacing: 50,
        title:Container(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            cursorColor: Colors.black,
            controller: _searchController,
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white,),
              hintText: 'Search...',

            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _filteredItems.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            enableFeedback: true,
            // subtitle: Text(_filteredItems[index],style: TextStyle(color: Colors.black),),
            title: Text(
              _filteredItems[index],
              style: ParticleFont.micro(
                context,
                customization: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
      ),
      // bottomNavigationBar: CutomBottomAppBar(),
    );
  }
}
