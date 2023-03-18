// ignore_for_file: omit_local_variable_types

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/CustomAppBar.dart';
import 'Bottom_bar/bottom_appbar_class.dart';
import 'Dashboard/custom_classes.dart';
import 'api.dart';
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
    assets = await assetsApi.assetsSnapshot();
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
    if (assets == null) {
      return Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: CustomAppBar(title: 'Images'),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Images/Snippets',
                  style: TextStyle(fontSize: 16.0),
                ),
                Switch(
                  value: showRawStringAssets,
                  onChanged: (value) {
                    setState(() {
                      showRawStringAssets = value;
                    });
                  },
                ),
              ],
            ),
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
                List<int>? bytes = asset.original.reference?.file?.bytes?.raw?.toList();
                Uint8List? uint8list;
                if (bytes != null) {
                  uint8list = Uint8List.fromList(bytes);
                }

                return Card(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          asset.name ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 8.0),
                        if (uint8list != null)
                          Expanded(
                            child: Image.memory(uint8list, fit: BoxFit.cover),
                          ),
                        if (asset.original.reference?.fragment?.string?.raw != null &&
                            uint8list == null)
                          Expanded(
                            child: Text(
                              '${asset.original.reference?.fragment?.string?.raw}',
                              textAlign: TextAlign.start,
                            ),
                          ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// copy and reference
                            /// Displays an icon button with an image and a tooltip, and performs various actions when pressed, including showing a snackbar, copying data to the clipboard, making API calls, and launching a URL.

                            TextButton(
                              onPressed: () async {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Copied, now paste when redirected!',
                                    ),
                                    duration: Duration(
                                        days: 0,
                                        hours: 0,
                                        minutes: 0,
                                        seconds: 5,
                                        milliseconds: 30,
                                        microseconds: 10),
                                  ),
                                );
                                ClipboardData data = ClipboardData(text: '''


Instructions:
hello chat GPT, please give me an explanation and example about the text below:
                            
                            
                          
                            
'  ${asset.original.reference?.fragment?.string?.raw ?? ''}',
                          

                            ''');
                                await Clipboard.setData(data);
                                Navigator.of(context).pop();

                                String port = '1000';
                                String host = 'http://localhost:$port';
                                final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

                                final ApplicationsApi applicationsApi =
                                await ApplicationsApi(ApiClient(basePath: host));

                                Applications applicationsSnapshot =
                                await applicationsApi.applicationsSnapshot();

                                var first = applicationsSnapshot.iterable.first;

                                final Asset response = await assetsApi.assetsCreateNewAsset(
                                  seed: Seed(
                                    asset: SeededAsset(
                                      application: Application(
                                        privacy: first.privacy,
                                        name: first.name,
                                        onboarded: first.onboarded,
                                        platform: first.platform,
                                        version: first.version,
                                        id: first.id,
                                      ),
                                      format: SeededFormat(
                                        ///=======
                                        fragment: SeededFragment(
                                          string: TransferableString(
                                            raw:
                                            '  ${asset.original.reference?.fragment?.string?.raw ?? ''}',
                                          ),
                                        ),
                                      ),
                                    ),
                                    type: SeedTypeEnum.ASSET,
                                  ),
                                );

                                String linkUrl = 'https://chat.openai.com/chat';

                                linkUrl = linkUrl; //Twitter's URL
                                if (await canLaunch(linkUrl)) {
                                  await launch(
                                    linkUrl,
                                  );
                                } else {
                                  throw 'Could not launch $linkUrl';
                                }
                              },
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 15, width: 15, child: Image.asset('black_gpt.png')),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'reference',
                                      style: TitleText(),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            ],
                        ),
                      ],
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
