// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/CustomAppBar.dart';
import 'package:gsheets/materials/suggested/suggested_assets.dart';
import 'package:gsheets/materials/toggle_material_widget.dart';
import 'package:gsheets/statistics_singleton.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../Dashboard/custom_classes.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

import '../Dashboard/reference_GPT.dart/gpt_modify_text.dart';
import '../material_buttons/material_copy_button.dart';
import '../material_buttons/share button.dart';
import 'discovered/discovered_assets.dart';

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
  @override
  Widget build(BuildContext context) {
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
              SuggestedAssetsButton(),
              DiscoveredAssetsButton(),
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
          Divider(
            height: 30,
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
              itemCount: getAssetsToShow().toList().length,
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
                            width: 600,
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
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: 500,
                                  height: 500,
                                  child: uint8list != null
                                      ? Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Card(
                                              elevation: 4,
                                              shadowColor: Colors.black,
                                              child: AppBar(
                                                leading: Icon(
                                                  Icons.image,
                                                  color: Colors.grey,
                                                ),
                                                backgroundColor: Colors.white,
                                                elevation: 0,
                                                centerTitle: true,
                                                title: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Text(
                                                    'image name: ${asset.name ?? ''}',
                                                    style: TitleText(),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                height: 350,
                                                width: 500,
                                                child: Image.memory(
                                                  uint8list,
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              ),
                                            ),
                                            Card(
                                              elevation: 4,
                                              shadowColor: Colors.black,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(Icons.copy),
                                                    onPressed: () async {
                                                      // await Clipboard.setData(ClipboardData(text: uint8list));
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            content: Text('Copied to clipboard')),
                                                      );
                                                    },
                                                  ),
                                                  SizedBox(
                                                    width: 30,
                                                  ),
                                                  IconButton(
                                                    icon: Icon(Icons.people_alt_outlined),
                                                    onPressed: () async {
                                                      // await Clipboard.setData(ClipboardData(text: uint8list));
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                            content: Text('Copied to clipboard')),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
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
                                              leading: Icon(
                                                Icons.code,
                                                color: Colors.black87,
                                              ),
                                              backgroundColor: Colors.black12,
                                              elevation: 0,
                                              centerTitle: true,
                                              title: SingleChildScrollView(
                                                scrollDirection: Axis.horizontal,
                                                child: Text(
                                                  '${asset.name ?? ''}',
                                                  style: TitleText(),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),

                                              /// Displays a horizontally scrollable text widget with a bold,
                                              /// uppercase classification value,
                                              /// or an empty string if the value is null.
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SingleChildScrollView(
                                                    scrollDirection: Axis.horizontal,
                                                    child: Text(
                                                      asset.original.reference?.classification
                                                              .specific.value
                                                              ?.toUpperCase() ??
                                                          '',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 20,
                                                        color: Colors.grey,
                                                      ),
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 500,
                                              child: Row(
                                                children: [
                                                  Visibility(
                                                    visible: !showCodeEditor,
                                                    child: Container(
                                                      height: 225,
                                                      width: 250,
                                                      child: SingleChildScrollView(
                                                        child: HighlightView(
                                                          rawString ?? '',
                                                          language: getAssetsToShow()
                                                                  .elementAt(index)
                                                                  .original
                                                                  .reference
                                                                  ?.classification
                                                                  .generic
                                                                  .value ??
                                                              'css',
                                                          theme: githubTheme,
                                                          textStyle: TitleText(),
                                                          padding: const EdgeInsets.all(16),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  EditableTextWidget(
                                                    initialText: getAssetsToShow()
                                                            .elementAt(index)
                                                            .original
                                                            .reference
                                                            ?.fragment
                                                            ?.string
                                                            ?.raw ??
                                                        '',
                                                  ),
                                                ],
                                              ),
                                            ),

                                            // ToggleableWidget(),
                                          ],
                                        ),
                                ),
                              ],
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
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(8.0),
                      //     child: Text(
                      //       asset.name?.toUpperCase() ?? '',
                      //       style: TextStyle(fontWeight: FontWeight.bold),
                      //       textAlign: TextAlign.start,
                      //     ),
                      //   ),
                      // ),
                      // SingleChildScrollView(
                      //   scrollDirection: Axis.horizontal,
                      //   child: Padding(
                      //     padding: const EdgeInsets.all(2.0),
                      //     child: Text(
                      //       asset.original.reference?.classification.specific.value ?? '',
                      //       style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 12,
                      //         color: Colors.grey,
                      //       ),
                      //       textAlign: TextAlign.start,
                      //     ),
                      //   ),
                      // ),
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
                                  scrollDirection: Axis.horizontal,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      asset.name?.toUpperCase() ?? '',
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
                                      CopyToClipboardButton(),
                                      SizedBox(width: 8),

                                      /// This code creates a circular button with a share icon that,
                                      /// when clicked, triggers a function to share an image.
                                      ShareIconButton(
                                        onTap: () {
                                          // Do something
                                        },
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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(asset.name?.toUpperCase() ?? '',
                                        style: TextStyle(fontWeight: FontWeight.bold)),
                                    SizedBox(height: 2),
                                    Text(
                                      asset.original.reference?.classification.specific.value ?? '',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          backgroundColor: Colors.white),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: SizedBox(
                                    height: 250,
                                    width: 250,
                                    child: Image.memory(
                                      uint8list,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    color: Colors.white,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        TextButton.icon(
                                          onPressed: () async {
                                            // Copy to clipboard
                                          },
                                          icon: Icon(Icons.copy_outlined,
                                              size: 12, color: Colors.black),
                                          label: Text(
                                            'Copy',
                                            style: TitleText(),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.white, // button color
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Icon(Icons.share,
                                                    color: Colors.black, size: 12),
                                              ),
                                              onTap: () {
                                                // share image
                                              },
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        ClipOval(
                                          child: Material(
                                            color: Colors.white, // button color
                                            child: InkWell(
                                              splashColor: Colors.grey,
                                              child: SizedBox(
                                                width: 30,
                                                height: 30,
                                                child: Icon(Icons.delete,
                                                    color: Colors.black, size: 12),
                                              ),
                                              onTap: () {
                                                // delete image
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
