// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/CustomAppBar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: CustomAppBar(title: 'Search'),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final _searchController = TextEditingController();
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));

  Future<Assets> getAssetsSnapshot() async {
    return await assetsApi.assetsSnapshot(suggested: true, transferables: false);
  }

  Future<List<SearchedAsset>> searchAssets(String query) async {
    SearchedAssets assetsSearchAssets = await assetsApi.assetsSearchAssets(query: query);
    return assetsSearchAssets.iterable?.toList() ?? [];
  }


  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('My Widget'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            /// This code retrieves a list of searched assets based on user input and
            /// displays the number of assets found.
            /// It also handles loading and error states.
            FutureBuilder<List<SearchedAsset>>(
              future: searchAssets(_searchController.text),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text('Loading...');
                } else if (snapshot.hasError) {
                  return Text('search your materials...');
                } else if (snapshot.hasData) {
                  final assets = snapshot.data ?? [];
                  return Text('Found ${assets.length}assets.');
                } else {
                  return const Text('No data found.');
                }
              },
            ),

            /// This code creates a search bar for assets and
            /// displays the number of search results in real-time.
            Card(
              child: ListTile(
                title: Text(''),
                subtitle: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search assets...',
                  ),
                  onChanged: (query) {
                    setState(() {}); // re-build the widget when the search query changes
                  },
                ),
              ),
            ),



            /// This code displays a card with a title "Suggested Materials" and
            /// a button that shows the number of suggested snippets.
            /// The button retrieves data asynchronously and
            /// displays a loading message while waiting for the data to load.
            Card(
              child: ListTile(
                title: Text('Suggested Materials'),
                subtitle: FutureBuilder<Assets>(
                  future: getAssetsSnapshot(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text('Loading...');
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      final assets = snapshot.data?.iterable?.toList() ?? [];
                      return TextButton(
                        child: Text('View Suggested Snippets (${assets.length})'),
                        onPressed: () => _showSuggestedSnippets(context),
                      );
                    } else {
                      return const Text('No data found.');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
void _showSuggestedSnippets(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 300,
        child: ListView.builder(
          itemCount: 9,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text('Snippet ${index + 1}'),
              title: Text('Suggested Snippet ${index + 1}'),
            );
          },
        ),
      );
    },
  );
}