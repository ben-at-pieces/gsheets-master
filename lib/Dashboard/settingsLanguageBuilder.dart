import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';

import '../Bottom_bar/bottom_appbar_class.dart';

class SettingsLanguageBuilder extends StatefulWidget {
  @override
  _SearchableListViewState createState() => _SearchableListViewState();
}

class _SearchableListViewState extends State<SettingsLanguageBuilder> {
  // list of items to display in the ListView
  final List<String> _items = [
    'Single-Click Save',
    'IDE ListView & MetaData OverView',
    'Proactive Save -VS Code',
    'Share Code with Shareable Links',
    'Automatic Smart Descriptions',
    'Shareable Links',
    'Renaming an Asset',
    'Reclassifying an Asset',
    'Workflow Activity View',
    'Snippet Discovery',
    'Getting Started with VS Code',
    'Insert a Snippet',
    'Custom Subdomains',
    'Working with Sensitives',
    'Information View',
    'AutoComplete',
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
    return  Container(
      color: Colors.grey,
      child: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  leading: Image.asset('user.jpg'),
                  title: Text(
                    'Setting' ?? '',
                    style: ParticleFont.bodyText1(
                      context,
                      customization: TextStyle(fontSize: 15, color: Colors.black),
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Subtitle' ?? '',
                        style: ParticleFont.bodyText1(
                          context,
                          customization: TextStyle(fontSize: 10, color: Colors.black),
                        ),
                      ),
                      // Text(
                      //   'os: ${StatisticsSingleton().statistics?.version}' ?? '',
                      //   style: ParticleFont.bodyText1(
                      //     context,
                      //     customization: TextStyle(fontSize: 10, color: Colors.black),
                      //   ),
                      // ),
                    ],
                  ),
                  trailing: Icon(
                    Icons.add_box_outlined,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  // leading: Image.asset('APFD.jpeg'),
                  // title: Text('Snippets: ${StatisticsSingleton().statistics?.snippetsSaved}' ?? ''),
                  // subtitle: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 12.0),
                  //       child: Text('Tags: ${StatisticsSingleton().statistics?.tags.length}' ?? ''),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 12.0),
                  //       child: Text(
                  //           'Links: ${StatisticsSingleton().statistics?.relatedLinks.length}' ??
                  //               ''),
                  //     ),
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 12.0),
                  //       child: Text(
                  //           'Shares: ${StatisticsSingleton().statistics?.shareableLinks}' ?? ''),
                  //     ),
                  //
                  //     ///
                  //     Padding(
                  //       padding: const EdgeInsets.only(top: 14.0, bottom: 8),
                  //       child: Text(
                  //           'People: ${StatisticsSingleton().statistics?.persons.length}' ?? ''),
                  //     ),
                  //   ],
                  // ),
                ),


                // Padding(
                //   padding: const EdgeInsets.only(
                //     left: 12,
                //     top: 5.0,
                //   ),
                //   child: Text(
                //     '${StatisticsSingleton().statistics?.classifications} ',
                //     style: ParticleFont.subtitle1(
                //       context,
                //       customization: TextStyle(
                //         fontSize: 14,
                //         color: Colors.black54,
                //       ),
                //     ),
                //   ),
                // ),

                Divider(
                  color: Colors.grey,
                ),
                ListTile(
                  leading: FloatingActionButton(
                    focusColor: Colors.green,
                    tooltip: 'power tips',
                    hoverColor: Colors.grey,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.tips_and_updates_outlined,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () {
                    //   showDialog(
                    //     context: context,
                    //     builder: (context) {
                    //       return
                    //         FloatingProTipButton();
                    //     },
                    //   );
                    },
                  ),
                  trailing: FloatingActionButton(
                    focusColor: Colors.green,
                    tooltip: 'power tips',
                    hoverColor: Colors.grey,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      Icons.settings,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //     return
                      //       FloatingSettingsButton();
                      //   },
                      // );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
