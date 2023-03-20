// ignore_for_file: omit_local_variable_types

import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/CustomAppBar.dart';
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

  Widget build(BuildContext context) {


    CircularProgressIndicator();
    // if (assets == null) {
    //   return Center(child: CircularProgressIndicator());
    // }
    return Scaffold(
      appBar: CustomAppBar(title: 'Materials'),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Images  /  Code',
            style: TextStyle(fontSize: 16.0),
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
 /// The code creates a row of buttons and images that allow the user to copy an asset to the clipboard, share it, or close the current view.
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Copy image to clipboard
                                      },
                                      child: Row(
                                        children: [
                                          Icon(Icons.copy_outlined, color: Colors.black,),
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
}
