// ignore_for_file: omit_local_variable_types
import 'dart:io';
import 'dart:ui';
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
import '../google_sheets/Pieces_for_X.dart';
import '../google_sheets/attach_pieces.dart';
import '../google_sheets/chrome.dart';
import '../google_sheets/jetbrains.dart';
import '../google_sheets/vs_code.dart';
import '../material_buttons/delete_button.dart';
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
  TextEditingController _nameController = TextEditingController();

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
                        final TextEditingController _textFieldController = TextEditingController();

                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: Container(
                            width: 700,
                            height: 520,
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
                                            AppBar(
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
                                                  '${asset.name ?? ''}',
                                                  style: TitleText(),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                            ),

                                            /// This code creates a row with several child widgets including icons and alerts.
                                            /// When the copy icon is tapped,
                                            /// an image is decoded and copied to the clipboard with a snackbar message displayed.
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Row(
                                                  children: [
                                                    // Text('${StatisticsSingleton().statistics?.asset.elementAt(index).original.reference?.tags?.iterable.elementAt(index)}' ?? ''),

                                                    /// Adds padding to a container with an image inside,
                                                    /// specifying its height and width.
                                                    /// The image is loaded from a byte array and set to cover the container.
                                                    Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Container(
                                                        height: 300,
                                                        width: 450,
                                                        child: Image.memory(
                                                          uint8list,
                                                          fit: BoxFit.contain,
                                                        ),
                                                      ),
                                                    ),

                                                    Padding(
                                                      padding: const EdgeInsets.all(2.0),
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () async {
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(
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
                                                                    microseconds: 10,
                                                                  ),
                                                                ),
                                                              );

                                                              if (bytes != null) {
                                                                final image =
                                                                    await decodeImageFromList(
                                                                        Uint8List.fromList(bytes));
                                                                if (image != null) {
                                                                  final pngBytes =
                                                                      await image.toByteData(
                                                                          format:
                                                                              ImageByteFormat.png);
                                                                  await Clipboard.setData(
                                                                    ClipboardData(
                                                                      text:
                                                                          '${pngBytes?.buffer.asInt8List()}',
                                                                    ),
                                                                  );
                                                                }
                                                              }
                                                            },
                                                            child: IconButton(
                                                              icon: Icon(
                                                                Icons.copy,
                                                                color: Colors.black,
                                                                size: 20,
                                                              ),
                                                              onPressed: () async {},
                                                            ),
                                                          ),
                                                          Pieces_Gsheets(),
                                                          VSCodeAlertDialog(),
                                                          JetBrainsAlertDialog(),
                                                          ChromeAlertDialog(),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                IconButton(
                                                  icon: Icon(Icons.edit),
                                                  onPressed: () async {
                                                    final port = '1000';
                                                    final host = 'http://localhost:$port';
                                                    AssetsApi assetsApi =
                                                        AssetsApi(ApiClient(basePath: host));
                                                    AssetApi assetApi =
                                                        AssetApi(ApiClient(basePath: host));
                                                    Assets assets =
                                                        await assetsApi.assetsSnapshot();
                                                    Asset asset = assets.iterable.elementAt(index);
                                                    String initialDescription =
                                                        asset.description ?? '';
                                                    if (initialDescription !=
                                                        _nameController.text) {
                                                      Asset response =
                                                          await assetApi.assetUpdate(asset: asset);
                                                      response.description;
                                                    }
                                                  },
                                                ),
                                                SizedBox(
                                                    height: 50,
                                                    width: 400,
                                                    child: SingleChildScrollView(
                                                      scrollDirection: Axis.vertical,
                                                      child: Text(
                                                          '${StatisticsSingleton().statistics?.asset.elementAt(index).description}' ??
                                                              ''),
                                                    )),
                                              ],
                                            ),
                                            Container(
                                              height: 45.0,
                                              width: 400,
                                              child: TextField(
                                                enableInteractiveSelection: true,
                                                cursorHeight: 12,
                                                autofocus: true,
                                                showCursor: true,
                                                cursorColor: Colors.black,
                                                toolbarOptions: ToolbarOptions(
                                                  copy: true,
                                                  paste: true,
                                                  selectAll: true,
                                                  cut: true,
                                                ),
                                                maxLines: 5,
                                                controller: _nameController,
                                                decoration: InputDecoration(
                                                  // label: FilePickerSheets(textEditingController: _textFieldController,),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      style: BorderStyle.solid,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            AppBar(
                                              leading: Icon(
                                                Icons.code,
                                                color: Colors.black87,
                                              ),
                                              backgroundColor: Colors.white,
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
                                                      style: TitleGreyText(),
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
                                                      height: 350,
                                                      width: 250,
                                                      child: SingleChildScrollView(
                                                        child: HighlightView(
                                                          rawString ?? '',
                                                          language: 'css',
                                                          // theme: githubTheme,
                                                          // textStyle: TitleText(),
                                                          padding: const EdgeInsets.all(2),
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
                                      style: TitleText(),
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 30, top: 30.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Padding(
                                      padding: const EdgeInsets.all(2.0),
                                      child: Container(
                                        height: 250,
                                        child: Text(
                                          asset.original.reference?.classification.specific.value ??
                                              '',
                                          style: TitleText(),
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: HighlightView(
                                      asset.original.reference?.fragment?.string?.raw ?? '',
                                      language: 'dart',
                                      // '${StatisticsSingleton().statistics?.classifications.keys.toString().toLowerCase() ?? ''}',
                                      theme: githubTheme,
                                      padding: EdgeInsets.all(16),
                                      textStyle: TitleText(),
                                    ),
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
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      /// ==============================================
                                      /// This code creates a button with an icon that, when pressed, displays a short message indicating that the content has been copied to the clipboard.
                                      IconButton(
                                          icon: Icon(
                                            Icons.copy,
                                            color: Colors.black,
                                            size: 20,
                                          ),
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
                                                  microseconds: 10,
                                                ),
                                              ),
                                            );

                                            ClipboardData data = ClipboardData(
                                              text:
                                                  asset.original.reference?.fragment?.string?.raw ??
                                                      '',
                                            );
                                            await Clipboard.setData(data);
                                          }),

                                      // CopyToClipboardButton(),
                                      SizedBox(width: 8),
                                      IconButton(
                                        onPressed: () async {
                                          await showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text('Are you sure you want this deleted?'),
                                                content: SingleChildScrollView(
                                                  child: HighlightView(
                                                    asset.original.reference?.fragment?.string
                                                            ?.raw ??
                                                        '',
                                                    language: 'dart',
                                                    theme: githubTheme,
                                                    padding: EdgeInsets.all(16),
                                                    textStyle: TitleText(),
                                                  ),
                                                ),
                                                actions: [
                                                  /// This code creates a button with an icon that, when pressed, shows a brief message and copies some text to the clipboard.

                                                  TextButton(
                                                    onPressed: () => Navigator.of(context).pop(),
                                                    child: Text('cancel'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context).pop();
                                                      Asset findAsset =
                                                          (await assetsApi.assetsSnapshot())
                                                              .iterable
                                                              .elementAt(index);

                                                      /// (2) define your indexed asset ID (string) from your assets snapshot
                                                      String deleted = await assetsApi
                                                          .assetsDeleteAsset(findAsset.id);

                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content:
                                                              Text('Asset deleted successfully.'),
                                                          duration: Duration(seconds: 2),
                                                        ),
                                                      );
                                                    },
                                                    child: Text('delete'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: Icon(Icons.delete, size: 20),
                                      )
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
                                      style: TitleText(),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 50.0),
                                  child: SizedBox(
                                    // height: 250,
                                    // width: 250,
                                    child: Image.memory(
                                      uint8list,
                                      fit: BoxFit.contain,
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
                                        /// This code creates a button with an icon that, when pressed, shows a brief message and copies some text to the clipboard.
                                        GestureDetector(
                                          onTap: () async {
                                            if (bytes != null) {
                                              final image = await decodeImageFromList(
                                                  Uint8List.fromList(bytes));
                                              if (image != null) {
                                                final pngBytes = await image.toByteData(
                                                    format: ImageByteFormat.png);
                                                await Clipboard.setData(
                                                  ClipboardData(
                                                    text: '${await pngBytes}',
                                                  ),
                                                );
                                              }
                                            }
                                            ;
                                          },
                                          child: IconButton(
                                              icon: Icon(
                                                Icons.copy,
                                                color: Colors.black,
                                                size: 20,
                                              ),
                                              onPressed: () {
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
                                                      microseconds: 10,
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),

                                        /// Deletes the indexed asset from a list of assets
                                        /// and displays a delete icon button.
                                        IconButton(
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.resolveWith(
                                                (states) => Colors.white12),
                                            side: MaterialStateProperty.all(
                                                BorderSide(color: Colors.grey, width: 1.0)),
                                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20.0))),
                                            overlayColor: MaterialStateProperty.all(Colors.black12),
                                          ),
                                          icon: Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                          onPressed: () async {
                                            final shouldDelete = await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(
                                                    'Are you sure you want to delete this asset?'),
                                                content: SizedBox(
                                                  height: 150,
                                                  width: 150,
                                                  child: Image.memory(
                                                    uint8list!,
                                                    fit: BoxFit.fitHeight,
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () =>
                                                        Navigator.of(context).pop(false),
                                                    child: Text(
                                                      'Cancel',
                                                      style: TitleText(),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      Navigator.of(context).pop(true);
                                                    },
                                                    child: Text(
                                                      'Delete',
                                                      style: TitleText(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );

                                            if (shouldDelete != null && shouldDelete) {
                                              try {
                                                final deletedAsset =
                                                    await assetsApi.assetsDeleteAsset(asset.id);
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Asset deleted successfully.'),
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                );
                                              } catch (e) {
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  SnackBar(
                                                    content: Text('Error deleting asset: $e'),
                                                    duration: Duration(seconds: 2),
                                                  ),
                                                );
                                              }
                                            }
                                          },
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
          Divider(
            height: 30,
          ),
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
        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }

  ///===============================================================================
}
