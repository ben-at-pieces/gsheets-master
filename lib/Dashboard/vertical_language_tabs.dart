// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types, prefer_const_constructors, use_key_in_widget_constructors
import 'dart:html';

import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api/persons_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/Dashboard/reference_GPT.dart/gpt_modify_text.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import '../CustomAppBar.dart';
import '../Tab_Plugins_and_More/plugins_and_more.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../statistics_singleton.dart';
import 'custom_classes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
// This widget is
//the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyDashBoard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyDashBoard extends StatefulWidget {
  @override
  String input = '';
  List<String> related = [];

  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyDashBoard> {
  int selectedIndex = 0;

  int get index => StatisticsSingleton().statistics?.nestedList.length ?? 0;

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 0;

    PageController _pageController = PageController();

    Iterable<String>? classifications = StatisticsSingleton().statistics?.classifications.keys;

    int count = StatisticsSingleton().statistics?.asset.toList().length ?? 0;

    List<Asset> list = StatisticsSingleton().statistics?.asset.toList() ?? [];



    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: CustomBottomAppBar(),
        appBar: CustomAppBar(
          title: 'Grid Snippet Descriptions',
        ),
        body: PageView(
          controller: _pageController,
          children: [
            MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: Colors.white,
                body: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    // childAspectRatio: 2,
                    crossAxisCount: 3,
                    // mainAxisExtent: 260,
                  ),
                  itemCount: count,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Divider(
                          color: Colors.black,
                          thickness: 2,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Container(
                              width: 200,
                              height: 20,
                              color: Colors.transparent,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  list.elementAt(index).name ?? '',
                                  style: TitleBlackText(),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // This code creates a row with two icons aligned to the right: a copy icon and an info icon, both with a size of 14.
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              // tooltip: 'copy',
                              icon: Icon(
                                Icons.people,
                                color: Colors.black,
                                size: 10,
                              ),
                              splashRadius: 2,
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
                                    text: StatisticsSingleton()
                                            .statistics
                                            ?.asset
                                            .toList()
                                            .elementAt(index)
                                            .original
                                            .reference
                                            ?.fragment
                                            ?.string
                                            ?.raw ??
                                        '');
                                await Clipboard.setData(data);
                              },
                            ),

                            /// This code creates a button with an icon that, when pressed, shows a brief message and copies some text to the clipboard.
                            IconButton(
                              // tooltip: 'copy',
                              icon: Icon(
                                Icons.copy,
                                color: Colors.black,
                                size: 10,
                              ),
                              splashRadius: 2,
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
                                    text: StatisticsSingleton()
                                            .statistics
                                            ?.asset
                                            .toList()
                                            .elementAt(index)
                                            .original
                                            .reference
                                            ?.fragment
                                            ?.string
                                            ?.raw ??
                                        '');
                                await Clipboard.setData(data);
                              },
                            ),
                            Icon(
                              Icons.info_outline,
                              size: 10,
                            )
                          ],
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Card(
                            elevation: 4,
                            shadowColor: Colors.black,
                            child: Container(
                              color: Colors.white,
                              width: 200,
                              height: 120,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                  child: Text(
                                    // StatisticsSingleton()
                                    //         .statistics
                                    //         ?.asset
                                    //         .toList()
                                    //         .elementAt(index)
                                    //         .description ??
                                    StatisticsSingleton()
                                            .statistics
                                            ?.asset
                                            .toList()
                                            .elementAt(index)
                                            .original
                                            .reference
                                            ?.fragment
                                            ?.string
                                            ?.raw ??
                                        '',
                                    style: PluginsAndMore(),
                                    softWrap: false,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          height: 45,
                          child:

                              /// Creates two buttons: one sends data to an API to create a new asset and clears a text field, while the other displays a confirmation dialog and closes the current screen if "Yes" is pressed.
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
                            
                            
                          
                            
'  ${StatisticsSingleton().statistics?.asset.toList().elementAt(index).original.reference?.fragment?.string?.raw ?? ''}',
                          

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
                                                  '  ${StatisticsSingleton().statistics?.asset.toList().elementAt(index).original.reference?.fragment?.string?.raw ?? ''}',
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

                              ///close button Teams
                              /// This code creates a button that, when pressed, sends data to an API to create a new asset and clears a text field.
                              TextButton(
                                onPressed: () async {
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
                                          fragment: SeededFragment(
                                            string: TransferableString(
                                              raw: _textFieldController.text,
                                            ),
                                          ),
                                        ),
                                      ),
                                      type: SeedTypeEnum.ASSET,
                                    ),
                                  );
                                  _textFieldController.clear();
                                  Navigator.of(context).pop();
                                },
                                child: Row(
                                  children: [
                                    Image.asset(
                                      'img_2.png',
                                      width: 15,
                                      height: 15,
                                    ),
                                    SizedBox(width: 8),
                                    Text(
                                      'save',
                                      style: TitleText(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ));
  }
}

final TextEditingController _textFieldController = TextEditingController();
