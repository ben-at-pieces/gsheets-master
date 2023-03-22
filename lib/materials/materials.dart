// ignore_for_file: omit_local_variable_types

import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/CustomAppBar.dart';
import 'package:gsheets/materials/zoom.dart';
import 'package:gsheets/statistics_singleton.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../Dashboard/custom_classes.dart';
import '../Dashboard/reference_GPT.dart/gpt_modify_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

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
      home: AssetGridPage(),
    );
  }
}

class AssetGridPage extends StatefulWidget {
  @override
  _AssetGridPageState createState() => _AssetGridPageState();
}

class _AssetGridPageState extends State<AssetGridPage> {
  late final Assets assets;
  late final AssetApi assetApi;
  late final AssetsApi assetsApi;
  bool showRawStringAssets = false;

  @override
  void initState() {
    super.initState();
    assetApi = AssetApi(ApiClient(basePath: 'http://localhost:1000'));
    assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));
    fetchAssets();
  }

  Future<void> fetchAssets() async {
    assets = await assetsApi.assetsSnapshot(transferables: true);
    setState(() {});
  }

  List<Asset> getAssetsToShow() {
    if (showRawStringAssets) {
      return assets.iterable
          .where((asset) => asset.original.reference?.fragment?.string?.raw != null)
          .toList();
    } else {
      return assets.iterable
          .where((asset) => asset.original.reference?.file?.bytes?.raw != null)
          .toList();
    }
  }

  ///===============================================================================
  Widget build(BuildContext context) {
    Future<Assets> getAssetsSnapshot() async {
      return await assetsApi.assetsSnapshot(suggested: true, transferables: false);
    }

    Future<List<Asset>> getDiscoveredAssetsList() async {
      Assets assets = await assetsApi.assetsSnapshot(suggested: true, transferables: false);
      return assets.iterable?.where((asset) => asset.discovered == true).toList() ?? [];
    }

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
                        'Suggested (${StatisticsSingleton().statistics?.suggestedCount ?? 0})',
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
                        trailing: Text(StatisticsSingleton().statistics?.discoveredAssetsList.elementAt(index).original.reference?.classification.specific.value ?? ''),
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Images  /  Code',
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
                ],
              ),
            ],
          ),
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
                if (bytes != null) {
                  uint8list = Uint8List.fromList(bytes);
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
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  width: 400,
                                  height: 350,
                                  child: Image.memory(
                                    uint8list!,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 16),

                                /// The code creates a row of buttons and images that
                                /// allow the user to
                                /// copy an asset to the clipboard, share it, or close the current view.
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Copy image to clipboard
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.copy_outlined,
                                            color: Colors.black,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'copy',
                                            style: TitleText(),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// A button with an image and text that allows
                                    /// the user to copy an image to the clipboard when pressed.
                                    TextButton(
                                      onPressed: () {
                                        // Copy image to clipboard
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'img_2.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'share',
                                            style: TitleText(),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// Displays a button with an image and text that when pressed,
                                    /// copies a string to the clipboard and displays a brief notification.
                                    TextButton(
                                      onPressed: () async {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Copied to Clipboard',
                                            ),
                                            duration: Duration(
                                                days: 0,
                                                hours: 0,
                                                minutes: 0,
                                                seconds: 1,
                                                milliseconds: 30,
                                                microseconds: 10),
                                          ),
                                        );
                                        ClipboardData data = ClipboardData(
                                            text:
                                                '${asset.original.reference?.fragment?.string?.raw ?? ''}');
                                        await Clipboard.setData(data);
                                      },
                                      child: Row(
                                        children: [
                                          Image.asset(
                                            'FigmaLogo.png',
                                            width: 24,
                                            height: 24,
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            'share',
                                            style: TitleText(),
                                          ),
                                        ],
                                      ),
                                    ),

                                    /// Creates a button with an icon and text that,
                                    /// when pressed, closes the current screen and returns to the previous one.
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.close,
                                            size: 24,
                                            color: Colors.black,
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            'Close',
                                            style: TitleText(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },

                  /// Displays an asset's name, original reference, and image (if available) in a card format, with an option to view more details in a dialog box.
                  child: Card(
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
                          Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          SizedBox(height: 8.0),
                          if (asset.original.reference?.fragment?.string?.raw != null &&
                              uint8list == null)
                            Expanded(
                              child: Text(
                                '${asset.original.reference?.fragment?.string?.raw}',
                                textAlign: TextAlign.start,
                              ),
                            ),
                          if (uint8list != null)
                            Expanded(
                              child: Image.memory(uint8list, fit: BoxFit.cover),
                            ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // TextButton(
                              //   child: SizedBox(
                              //     height: 20,
                              //     width: 20,
                              //     child: Icon(
                              //       Icons.people_alt_outlined,
                              //       size: 20,
                              //       color: Colors.black,
                              //     ),
                              //   ),
                              //   onPressed: () {
                              //     showDialog(
                              //       context: context,
                              //       builder: (context) {
                              //         return GPTCustomAlertDialog(
                              //           initialText:
                              //               asset.original.reference?.fragment?.string?.raw ?? '',
                              //         );
                              //       },
                              //     );
                              //   },
                              // ),
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
