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
                                              Text(
                                                'Copy',
                                                style: TitleText(),
                                              ),
                                              Icon(
                                                Icons.copy,
                                                color: Colors.black,
                                              ),
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
                                          child: Text(
                                            'Copy',
                                            style: TitleText(),
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

                            /// Displays an image or code snippet with a
                            /// toggleable code editor,
                            /// highlighting syntax and
                            /// increasing font size for readability.
                            child: SizedBox(
                              width: 450,
                              height: 450,
                              child: uint8list != null
                                  ? Image.memory(
                                    uint8list,
                                    fit: BoxFit.contain,
                                  )

                                  /// Displays a widget with the
                                  /// name and classification of an asset,
                                  /// along with a code snippet that
                                  /// can be toggled between a
                                  /// read-only view and an editable view.
                                  : Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        AppBar(
                                          leading: Icon(Icons.code),
                                          backgroundColor: Colors.black12,
                                          elevation: 0,
                                          centerTitle: true,
                                          title: SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Text(
                                              'name: ${asset.name ?? ''}',
                                              style: TitleText(),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                  asset.original.reference?.classification.specific
                                                          .value
                                                          .toUpperCase() ??
                                                      '',
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Colors.grey),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Visibility(
                                          visible: !showCodeEditor,
                                          child: Container(
                                            height: 250,
                                            child: SingleChildScrollView(
                                              child: HighlightView(
                                                rawString ?? '',
                                                language:
                                                    '${StatisticsSingleton().statistics?.classifications.keys.elementAt(index) ?? ''}',
                                                theme: githubTheme,
                                                textStyle: TitleText(),
                                                padding: EdgeInsets.all(16),
                                              ),
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
                                              enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(4.0)),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    BorderSide(color: Colors.grey, width: 1.0),
                                                borderRadius:
                                                    BorderRadius.all(Radius.circular(4.0)),
                                              ),
                                            ),
                                          ),
                                        ),
                                        ToggleableWidget(
                                          value: showCodeEditor,
                                          onChanged: (value) {
                                            setState(() {
                                              showCodeEditor = value;
                                              if (showCodeEditor) {
                                                codeEditorController.text = StatisticsSingleton()
                                                        .statistics
                                                        ?.snippetsListRaw
                                                        .toList()
                                                        .elementAt(index) ??
                                                    '';
                                              } else {
                                                rawString = StatisticsSingleton()
                                                        .statistics
                                                        ?.snippetsListRaw
                                                        .toList()
                                                        .elementAt(index) ??
                                                    '';
                                              }
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                            ),
                          ),
                        );
                      },
                    );
                  },

                  /// Displays an asset's name, original reference, and image (if available)
                  /// in a card format, with an option to view more details in a dialog box.
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            asset.name ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                            asset.original.reference?.classification.specific.value ?? '',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                      // Divider(
                      //   color: Colors.grey,
                      //   thickness: 2,
                      // ),
                      /// Creates a box with a fixed height of 8.0.
                      SizedBox(
                        height: 2.0,
                      ),
                      if (asset.original.reference?.fragment?.string?.raw != null &&
                          uint8list == null)

                        /// Displays a code snippet with syntax highlighting and
                        /// allows the user to copy the code to the clipboard or share it.
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                SingleChildScrollView(
                                  child: HighlightView(
                                    asset.original.reference?.fragment?.string?.raw ?? '',
                                    language:
                                        '${StatisticsSingleton().statistics?.classifications.keys.toString().toLowerCase() ?? ''}',
                                    theme: githubTheme,
                                    padding: EdgeInsets.all(16),
                                    textStyle: TitleText(),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,

                                  /// This code creates a row with two buttons,
                                  /// one to copy an image to the clipboard and
                                  /// another to share it.
                                  /// When the copy button is pressed,
                                  /// the image is encoded as base64 and
                                  /// copied to the clipboard, and a
                                  /// snackbar is displayed to users
                                  child: Row(
                                    children: [
                                      TextButton(
                                        onPressed: () async {
                                          if (uint8list != null) {
                                            final byteData = uint8list.buffer.asByteData();
                                            final base64Image =
                                                base64.encode(Uint8List.view(byteData.buffer));
                                            await Clipboard.setData(
                                                ClipboardData(text: base64Image));
                                          } else if (rawString != null) {
                                            await Clipboard.setData(ClipboardData(text: rawString));
                                          }
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Copied to Clipboard',
                                                style: TitleText(),
                                              ),
                                              backgroundColor: Colors.black12,
                                              duration: Duration(milliseconds: 1030),
                                            ),
                                          );
                                        },
                                        style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.resolveWith(
                                              (states) => Colors.white),
                                          side: MaterialStateProperty.all(
                                            BorderSide(
                                              color: Colors.grey,
                                              width: 1.0,
                                            ),
                                          ),
                                          shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(20.0),
                                            ),
                                          ),
                                          overlayColor: MaterialStateProperty.all(
                                            Colors.black12,
                                          ),
                                          // foregroundColor: MaterialStateProperty.resolveWith((states) => states.contains(MaterialState.hovered) ? Colors.white : Colors.black),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.copy_outlined,
                                              color: Colors.black,
                                              size: 12,
                                            ),
                                            SizedBox(width: 4),
                                            Text(
                                              'copy',
                                              style: PluginsAndMore(),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.white, // button color
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              child: MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 200),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(color: Colors.grey),
                                                  ),
                                                  child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.share,
                                                      color: Colors.black,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                // share image
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      /// Displays an image from a byte array and
                      /// provides options to
                      /// copy or share the image using the device's clipboard.
                      if (uint8list != null)
                        Expanded(
                          child: Card(
                            elevation: 4,
                            child: Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.memory(
                                    uint8list,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      MouseRegion(
                                        cursor: SystemMouseCursors.click,
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 200),
                                          child: TextButton(
                                            onPressed: () async {
                                              if (uint8list != null) {
                                                final byteData = uint8list.buffer.asByteData();
                                                final base64Image = base64
                                                    .encode(Uint8List.view(byteData.buffer));
                                                await Clipboard.setData(
                                                    ClipboardData(text: base64Image));
                                              } else if (rawString != null) {
                                                await Clipboard.setData(
                                                    ClipboardData(text: rawString));
                                              }
                                              ScaffoldMessenger.of(context).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Copied to Clipboard',
                                                    style: TextStyle(color: Colors.white),
                                                  ),
                                                  backgroundColor: Colors.grey,
                                                  duration: Duration(milliseconds: 1030),
                                                ),
                                              );
                                            },
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    states.contains(MaterialState.hovered)
                                                        ? Colors.grey
                                                        : Colors.white,
                                              ),
                                              foregroundColor:
                                                  MaterialStateProperty.resolveWith(
                                                (states) =>
                                                    states.contains(MaterialState.hovered)
                                                        ? Colors.white
                                                        : Colors.black,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.copy_outlined,
                                                  color: Colors.black,
                                                  size: 12,
                                                ),
                                                SizedBox(width: 4),
                                                Text(
                                                  'copy',
                                                  style: TextStyle(fontSize: 12),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Padding(
                                        padding: const EdgeInsets.only(right: 8),
                                        child: ClipOval(
                                          child: Material(
                                            color: Colors.white, // button color
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              child: MouseRegion(
                                                cursor: SystemMouseCursors.click,
                                                child: AnimatedContainer(
                                                  duration: Duration(milliseconds: 200),
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    border: Border.all(color: Colors.grey),
                                                  ),
                                                  child: SizedBox(
                                                    width: 30,
                                                    height: 30,
                                                    child: Icon(
                                                      Icons.share,
                                                      color: Colors.black,
                                                      size: 12,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              onTap: () {
                                                // share image
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
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
