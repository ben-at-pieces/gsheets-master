import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../CustomAppBar.dart';
import '../Dashboard/custom_classes.dart';
import '../Dashboard/sidebar.dart';
import '../Tab_Plugins_and_More/plugins_and_more.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../Tab_DashBoard/checkbox_class.dart';
import '../statistics_singleton.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "ListView.builder",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        home: RelatedLinksWidget());
  }
}

class RelatedLinksWidget extends StatelessWidget {
  RelatedLinksWidget({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Related Links',
      ),
      body: Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            itemCount: StatisticsSingleton().statistics?.relatedLinks.length,
            itemBuilder: (BuildContext context, int index) {
              String linkUrl = '${StatisticsSingleton().statistics?.relatedLinks[index]}';

              return Container(
                decoration: BoxDecoration(
                  // border: Border(
                  //   bottom: BorderSide(
                  //     color: Colors.grey,
                  //     width: .85,
                  //   ),
                  // ),
                ),
                child: Card(
                  child: ListTile(

                    tileColor: Colors.white,
                    subtitle: Row(
                      children: [
                        /// copy =====================================================================
                        IconButton(

                          tooltip: 'copy',
                          splashRadius: 2,
                          icon: Icon(
                            Icons.copy,
                            color: Colors.black,
                            size: 18,
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
                                    microseconds: 10),
                              ),
                            );
                            ClipboardData data = ClipboardData(text: linkUrl);
                            await Clipboard.setData(data);
                          },
                        ),

                        /// share =====================================================================
                        IconButton(
                          tooltip: 'go to',
                          splashRadius: 2,
                          icon: Icon(
                            Icons.launch,
                            color: Colors.blue,
                            size: 18,
                          ),
                          onPressed: () async {
                            linkUrl = linkUrl; //Twitter's URL
                            if (await canLaunch(linkUrl)) {
                              await launch(
                                linkUrl,
                              );
                            } else {
                              throw 'Could not launch $linkUrl';
                            }
                          },
                        ),
                      ],
                    ),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SelectableText(
                              linkUrl,
                              style: TitleText(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // leading: MyCheckBoxWidgget(),
                    trailing: Icon(
                      Icons.link,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
              // title: Text('Person: $index'));
            }),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
