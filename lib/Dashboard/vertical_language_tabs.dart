// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types, prefer_const_constructors, use_key_in_widget_constructors
import 'dart:html';

import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
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

    List<Image> images = [];

    return Scaffold(
        backgroundColor: Colors.black87,
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
                backgroundColor: Colors.black12,
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
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0, top: 10),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),                              child: Container(
                                width: 200,
                                color: Colors.black12,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    list.elementAt(index).name ?? '',
                                    style: TextStyle(color: Colors.white, fontSize: 12),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Divider(color: Colors.white, ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            color: Colors.black87,
                            width: 200,
                            height: 130,
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
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
                                  style: ProductTitleText(),
                                  softWrap: false,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 45,
                          color: Colors.black12,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                tooltip: '${ StatisticsSingleton()
                        .statistics
                        ?.asset
                        .toList()
                        .elementAt(index)
                        .description ??
                    ''}',
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
                                          ' ${StatisticsSingleton().statistics?.asset.toList().elementAt(index).original.reference?.fragment?.string?.raw}');
                                  await Clipboard.setData(data);
                                },
                                icon: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    height: 30,
                                    width: 30,
                                    child: Icon(
                                      Icons.copy,
                                      color: Colors.white,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ),

                              /// teams button
                              TextButton(
                                child: SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Image.asset('teams.png'),
                                  ),
                                ),
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return GPTCustomAlertDialog(
                                        initialText: StatisticsSingleton()
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
                                      );
                                    },
                                  );
                                },
                              ),
                              SizedBox(
                                height: 50,
                                width: 50,
                                child: TextButton(
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


                    hello, please tell me about this :


                    ${StatisticsSingleton().statistics?.asset.toList().elementAt(index).original.reference?.fragment?.string?.raw ?? ''}

                    and show me an example?

                    ''');
                                    await Clipboard.setData(data);

                                    await Future.delayed(Duration(seconds: 4));

                                    String port = '1000';
                                    String host = 'http://localhost:$port';
                                    final AssetsApi assetsApi =
                                        AssetsApi(ApiClient(basePath: host));

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
                                    _textFieldController.clear();

                                    Navigator.of(context).pop;

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
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(4),
                                        child: Container(
                                          // color: Colors.white,
                                          height: 30,
                                          width: 30,
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Image.asset(
                                              'img.png',
                                            ),
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
