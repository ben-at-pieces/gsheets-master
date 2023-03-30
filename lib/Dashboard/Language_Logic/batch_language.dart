// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/CustomAppBar.dart';

import 'package:gsheets/statistics_singleton.dart';

import 'package:flutter/services.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Asset Buttons Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Asset Buttons Sample'),
        ),
        body: Center(
          child: AssetButtons(),
        ),
      ),
    );
  }
}

class AssetButtons extends StatefulWidget {
  @override
  _AssetButtonsState createState() => _AssetButtonsState();
}

class _AssetButtonsState extends State<AssetButtons> {
  bool showRawStringAssets = false;

  @override
  Widget build(BuildContext context) {



    /// This code displays a modal bottom sheet in a Flutter app that shows a list of discovered assets.
    /// Each asset in the list is displayed as a card with its
    /// name, description, and other details.
    /// The user can interact with each asset by tapping on
    void _showDiscoveredAssets(BuildContext context, List<Asset> discoveredAssetsList) {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                height: 56,
                child: Container(
                  color: Colors.grey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(width: 16),
                      Text(
                        'Discovered (${discoveredAssetsList.length})',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.close),
                        color: Colors.white,
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: discoveredAssetsList.length,
                  itemBuilder: (context, index) {
                    TextEditingController _textEditController = TextEditingController();
                    final discoveredAsset = discoveredAssetsList[index];
                    return Card(
                      shadowColor: Colors.black,
                      elevation: 4,
                      child: ListTile(
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text('${index + 1}'),
                            IconButton(
                              icon: Icon(Icons.more_vert),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Snippet Placeholder'),
                                      content: TextField(
                                        readOnly: false,
                                        controller: _textEditController,
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('Close'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            await Clipboard.setData(ClipboardData(
                                                text:
                                                '${StatisticsSingleton().statistics?.suggestionsListed ?? ''}'));
                                            Navigator.of(context).pop();
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(content: Text('Copied to clipboard')),
                                            );
                                          },
                                          child: Text('Copy'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.copy),
                              onPressed: () async {
                                await Clipboard.setData(ClipboardData(text: 'rawSnippet'));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Copied to clipboard')),
                                );
                              },
                            ),
                          ],
                        ),
                        title: Text(discoveredAsset.name ?? ''),
                        subtitle: Text(discoveredAsset.description ?? ''),
                        onTap: () => _showAssetDetails(
                            context, discoveredAsset.name ?? '', discoveredAsset.description ?? ''),
                        trailing: Text(StatisticsSingleton()
                            .statistics
                            ?.discoveredAssetsList
                            .elementAt(index)
                            .original
                            .reference
                            ?.classification
                            .specific
                            .value ??
                            ''),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    }



    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          child: Text('Suggested', style: TextStyle(fontSize: 18)),
          onPressed: () => _showSuggestedSnippets(context),
        ),
        TextButton(
            child: Text('Discovered', style: TextStyle(fontSize: 18)),
          onPressed: () {
            void _showDiscoveredAssets(BuildContext context, List<Asset> discoveredAssetsList) {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                        ),
                        height: 56,
                        child: Container(
                          color: Colors.grey,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(width: 16),
                              Text(
                                'Discovered (${discoveredAssetsList.length})',
                                style: TextStyle(fontSize: 16, color: Colors.white),
                              ),
                              IconButton(
                                icon: Icon(Icons.close),
                                color: Colors.white,
                                onPressed: () => Navigator.pop(context),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: discoveredAssetsList.length,
                          itemBuilder: (context, index) {
                            TextEditingController _textEditController = TextEditingController();
                            final discoveredAsset = discoveredAssetsList[index];
                            return Card(
                              shadowColor: Colors.black,
                              elevation: 4,
                              child: ListTile(
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('${index + 1}'),
                                    IconButton(
                                      icon: Icon(Icons.more_vert),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              title: Text('Snippet Placeholder'),
                                              content: TextField(
                                                readOnly: false,
                                                controller: _textEditController,
                                              ),
                                              actions: [
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: Text('Close'),
                                                ),
                                                TextButton(
                                                  onPressed: () async {
                                                    await Clipboard.setData(ClipboardData(
                                                        text:
                                                        '${StatisticsSingleton().statistics?.suggestionsListed ?? ''}'));
                                                    Navigator.of(context).pop();
                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                      SnackBar(content: Text('Copied to clipboard')),
                                                    );
                                                  },
                                                  child: Text('Copy'),
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.copy),
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(text: 'rawSnippet'));
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Copied to clipboard')),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                title: Text(discoveredAsset.name ?? ''),
                                subtitle: Text(discoveredAsset.description ?? ''),
                                onTap: () => _showAssetDetails(
                                    context, discoveredAsset.name ?? '', discoveredAsset.description ?? ''),
                                trailing: Text(StatisticsSingleton()
                                    .statistics
                                    ?.discoveredAssetsList
                                    .elementAt(index)
                                    .original
                                    .reference
                                    ?.classification
                                    .specific
                                    .value ??
                                    ''),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                },
              );
            }

          }

        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Images', style: TextStyle(fontSize: 18)),
            Switch(
              activeColor: Colors.black,
              value: showRawStringAssets,
              onChanged: (value) {
                setState(() {
                  showRawStringAssets = value;
                });
              },
            ),
            Text('Snippets', style: TextStyle(fontSize: 18)),
          ],
        ),
      ],
    );
  }
}




/// This code displays a modal bottom sheet with a list of suggested snippets,
/// including their names, descriptions, and classifications.
/// The user can copy the snippet to the clipboard or view more details.
void _showSuggestedSnippets(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            height: 56,
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 16),
                  Text(
                    'Suggested (${StatisticsSingleton().statistics?.suggestedCount ?? 1})',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: StatisticsSingleton().statistics?.suggestedCount ?? 0,
              itemBuilder: (context, index) {
                String rawSnippet = StatisticsSingleton()
                        .statistics
                        ?.suggestionsListed
                        .elementAt(index)
                        .original
                        .reference
                        ?.fragment
                        ?.string
                        ?.raw ??
                    '';

                return Card(
                  shadowColor: Colors.black,
                  elevation: 4,
                  child: ListTile(
                    trailing: Text(
                        '${StatisticsSingleton().statistics?.suggestionsListed.elementAt(index).original.reference?.classification.specific.value}'),
                    subtitle: Container(
                      // height: 30,
                      child: Text(
                          StatisticsSingleton().statistics?.suggestedDesc.elementAt(index) ?? ''),
                    ),
                    title: Text(
                        StatisticsSingleton().statistics?.suggestedNames.elementAt(index) ?? ''),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${index + 1}'),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('snippet place holder'),
                                  content: TextField(
                                    readOnly: false,
                                    controller: codeEditorController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('Close'),
                                    ),
                                    TextButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text:
                                                '${StatisticsSingleton().statistics?.suggestionsListed ?? ''}'));
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Copied to clipboard')),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text('Copy'),
                                          Icon(Icons.copy),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: rawSnippet));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Copied to clipboard')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

/// Displays a modal bottom sheet with
/// the name and description of an asset in a column format.
void _showAssetDetails(BuildContext context, String name, String description) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(description),
        ],
      );
    },
  );
}

TextEditingController codeEditorController = TextEditingController();


