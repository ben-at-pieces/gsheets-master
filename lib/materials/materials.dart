// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/CustomAppBar.dart';
import 'package:gsheets/materials/textPreview.dart';
import 'package:gsheets/materials/zoom.dart';
import 'package:gsheets/statistics_singleton.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../Dashboard/Language_Logic/batch_language.dart';
import '../Dashboard/custom_classes.dart';
import '../Dashboard/reference_GPT.dart/gpt_modify_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Asset Grid Sample',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MaterialsPage(),
    );
  }
}

class MaterialsPage extends StatefulWidget {
  @override
  _AssetGridPageState createState() => _AssetGridPageState();
}

class _AssetGridPageState extends State<MaterialsPage> {
  Assets? assets;
  late AssetApi assetApi;
  late AssetsApi assetsApi;
  bool showRawStringAssets = false;
  bool showCodeEditor = false;
  TextEditingController codeEditorController = TextEditingController();

  @override
  void initState() {
    super.initState();
    assetApi = AssetApi(ApiClient(basePath: 'http://localhost:1000'));
    assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));
    fetchAssets();
  }

  Future<void> fetchAssets() async {
    if (assets == null) {
      assets = await assetsApi.assetsSnapshot(transferables: true);
      setState(() {});
    }
  }

  List<Asset> getAssetsToShow() {
    if (showRawStringAssets) {
      return assets?.iterable
              .where((asset) => asset.original.reference?.fragment?.string?.raw != null)
              .toList() ??
          [];
    } else {
      return assets?.iterable
              .where((asset) => asset.original.reference?.file?.bytes?.raw != null)
              .toList() ??
          [];
    }
  }

  ///===============================================================================
  Widget build(BuildContext context) {
    Future<Assets> getAssetsSnapshot() async {
      return await assetsApi.assetsSnapshot(suggested: true, transferables: false);
    }

    Future<List<Asset>> getDiscoveredAssetsList() async {
      Assets assets = await assetsApi.assetsSnapshot(suggested: true, transferables: false);
      return assets.iterable.where((asset) => asset.discovered == true).toList() ?? [];
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
                              StatisticsSingleton().statistics?.suggestedDesc.elementAt(index) ??
                                  ''),
                        ),
                        title: Text(
                            StatisticsSingleton().statistics?.suggestedNames.elementAt(index) ??
                                ''),
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
                                      title: Text('snippet place holder'),
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

    CircularProgressIndicator();
    // if (assets == null) {
    /// This code fetches a snapshot of assets and displays a modal bottom sheet with a list of suggested snippets.
    //   return Center(child: CircularProgressIndicator());
    // }

    /// UI for the main menu for Materials Page.
    return Scaffold(
      appBar: CustomAppBar(title: 'Materials'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FutureBuilder<Assets>(
                future: getAssetsSnapshot(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final assets = snapshot.data?.iterable.toList() ?? [];
                    return TextButton(
                      child: Text(
                        'Suggested: (${assets.length})',
                        style: TitleText(),
                      ),
                      onPressed: () => _showSuggestedSnippets(context),
                    );
                  } else {
                    return const Text('No data found.');
                  }
                },
              ),
              FutureBuilder<List<Asset>>(
                future: getDiscoveredAssetsList(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text('Loading...');
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final assets = snapshot.data ?? [];
                    return TextButton(
                      child: Text('Discovered: (${assets.length})', style: TitleText()),
                      onPressed: () => _showDiscoveredAssets(context, assets),
                    );
                  } else {
                    return const Text('No data found.');
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${StatisticsSingleton().statistics?.image.length ?? ''} Images ',
                    style: TitleText(),
                  ),
                  Switch(
                    activeColor: Colors.black,
                    value: showRawStringAssets,
                    onChanged: (value) {
                      setState(() {
                        showRawStringAssets = value;
                      });
                    },
                  ),
                  Text(
                    'Snippets',
                    // ' ${StatisticsSingleton().statistics?.classifications.length ?? ''}',
                    style: TitleText(),
                  ),
                ],
              ),
            ],
          ),

          /// The code displays a grid of assets with their
          /// names, original references, and images (if available).
          /// When an asset is tapped,
          /// a dialog box appears with options to copy the asset to the clipboard,
          /// share it, or close the view.
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: getAssetsToShow().length,
              itemBuilder: (BuildContext context, int index) {
                Asset asset = getAssetsToShow()[index];
                List<int>? bytes = asset.original.reference?.file?.bytes?.raw.toList();
                Uint8List? uint8list;
                String? rawString;

                if (bytes != null) {
                  uint8list = Uint8List.fromList(bytes);
                } else {
                  rawString = asset.original.reference?.fragment?.string?.raw;
                }

                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: SizedBox(
                              width: 400,
                              height: 250,
                              child: uint8list != null
                                  ? Image.memory(
                                      uint8list,
                                      fit: BoxFit.contain,
                                    )
                                  : SingleChildScrollView(
                                      scrollDirection: Axis.vertical,
                                      child: Column(
                                        children: [
                                          Visibility(
                                            visible: !showCodeEditor,
                                            child: Container(
                                              child: HighlightView(
                                                rawString ?? '',
                                                language: 'dart',
                                                // Change this to the language of the code
                                                theme: githubTheme,
                                                textStyle: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                // Increase font size for better readability
                                                padding: EdgeInsets.all(16),
                                              ),
                                            ),
                                          ),
                                          Visibility(
                                            visible: showCodeEditor,
                                            child: TextField(
                                              controller: codeEditorController,
                                              maxLines: null,
                                              keyboardType: TextInputType.multiline,
                                              decoration: InputDecoration(
                                                hintText: 'Enter code snippet...',
                                                contentPadding: EdgeInsets.all(16),
                                                border: OutlineInputBorder(),
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 16),
                                          ToggleableWidget(
                                            value: showCodeEditor,
                                            onChanged: (value) {
                                              setState(
                                                () {
                                                  showCodeEditor = value;
                                                  if (showCodeEditor) {
                                                    codeEditorController.text =
                                                        StatisticsSingleton()
                                                                .statistics
                                                                ?.snippetsListRaw
                                                                .toList()
                                                                .elementAt(index) ??
                                                            '';
                                                  } else {
                                                    rawString = codeEditorController.text;
                                                  }
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  },

                  /// Displays an asset's name, original reference, and image (if available)
                  /// in a card format, with an option to view more details in a dialog box.
                  child: Card(
                    elevation: 4,
                    shadowColor: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              asset.name ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              asset.original.reference?.classification.specific.value ?? '',
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          if (asset.original.reference?.fragment?.string?.raw != null &&
                              uint8list == null)
                            Expanded(
                              child: SingleChildScrollView(
                                child: HighlightView(
                                  asset.original.reference?.fragment?.string?.raw ?? '',
                                  language: 'dart',
                                  theme: githubTheme,
                                  padding: EdgeInsets.all(16),
                                  textStyle: TextStyle(fontSize: 18),
                                ),
                              ),
                            ),
                          if (uint8list != null)
                            Expanded(
                              child: Image.memory(
                                uint8list,
                                fit: BoxFit.cover,
                              ),
                            ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (uint8list != null) {
                                    final byteData = uint8list.buffer.asByteData();
                                    final base64Image =
                                        base64.encode(Uint8List.view(byteData.buffer));
                                    await Clipboard.setData(ClipboardData(text: base64Image));
                                  } else if (rawString != null) {
                                    await Clipboard.setData(ClipboardData(text: rawString));
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Copied to Clipboard',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      backgroundColor: Colors.black54,
                                      duration: Duration(milliseconds: 1030),
                                    ),
                                  );
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.copy_outlined,
                                      color: Colors.black,
                                      size: 16,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'copy',
                                      style: TitleText(),
                                    ),
                                  ],
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Copy image to clipboard
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'img_2.png',
                                      width: 20,
                                      height: 20,
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'share',
                                      style: TitleText(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }

  ///===============================================================================
}

final TextEditingController _textEditController = TextEditingController();
