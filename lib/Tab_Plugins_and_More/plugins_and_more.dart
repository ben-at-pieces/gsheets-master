import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:runtime_client/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../CustomAppBar.dart';
import '../Dashboard/custom_classes.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../create/create_function.dart';
import '../init/src/gsheets.dart';
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
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
        home: Plugins());
  }
}

class Plugins extends StatelessWidget {
  Plugins({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      appBar: CustomAppBar(
        title: 'Plugins & More',
      ),
      body: Container(
        // width: 500,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),

              /// =========================================
              child: Row(
                children: [
                  SizedBox(
                    height: 200,
                    width: 120,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CustomIcon(Icons.auto_awesome),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Pieces',
                                       style: ParticleFont.micro(
                                    context,
                                    customization: TextStyle(color: Colors.black, fontSize: 20),
                                  ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(
                                  'Desktop App',
                                  style: PluginsAndMore(),
                                ),
                                onPressed: () async {
                                  var linkUrl = 'https://code.pieces.app/install';

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
                              SizedBox(height: 25, width: 25, child: Image.asset('roundedpfd.png')),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 165,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomIcon(Icons.devices_outlined),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Develop',
                                  style: ParticleFont.micro(
                                context,
                                customization: TextStyle(color: Colors.black, fontSize: 20),
                              ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(
                                  'Pieces for VS Code',
                                  style: PluginsAndMore(),
                                ),
                                onPressed: () async {
                                  var linkUrl =
                                      'https://marketplace.visualstudio.com/items?itemName=MeshIntelligentTechnologiesInc.pieces-vscode';

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
                              SizedBox(height: 20, width: 20, child: Image.asset('vscode.png')),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
                                'Pieces for JetBrains',
                                style: PluginsAndMore(),
                              ),
                              onPressed: () async {
                                var linkUrl =
                                    'https://plugins.jetbrains.com/plugin/17328-pieces--save-search-share--reuse-code-snippets';

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
                            SizedBox(height: 20, width: 20, child: Image.asset('jetbrains.png')),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 170,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CustomIcon(Icons.auto_fix_high),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Enhance',
                                    style: ParticleFont.micro(
                                      context,
                                      customization: TextStyle(color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(
                                  'Code From Screenshot',
                                  style: PluginsAndMore(),
                                ),
                                onPressed: () async {
                                  var linkUrl = 'https://www.codefromscreenshot.com/';

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
                              CustomIcon(Icons.screenshot_monitor_outlined),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
                                'Text From Screenshot',
                                style: PluginsAndMore(),
                              ),
                              onPressed: () async {
                                var linkUrl = 'https://www.textfromscreenshot.com/';

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
                            CustomIcon(Icons.screenshot_monitor_outlined),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
                                'Code Plus Plus',
                                style: PluginsAndMore(),
                              ),
                              onPressed: () async {
                                var linkUrl = 'https://www.codeplusplus.app/';

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
                            CustomIcon(Icons.developer_mode_sharp),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    width: 150,
                    child: ListView(
                      padding: const EdgeInsets.all(10),
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                CustomIcon(Icons.travel_explore_outlined),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Browse',
                                    style: ParticleFont.micro(
                                      context,
                                      customization: TextStyle(color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                child: Text(
                                  'Pieces for Chrome',
                                  style: PluginsAndMore(),
                                ),
                                onPressed: () async {
                                  var linkUrl =
                                      'https://chrome.google.com/webstore/detail/pieces-save-code-snippets/igbgibhbfonhmjlechmeefimncpekepm';

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
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset('Chrome.png'),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
                                'Pieces for Safari',
                                style: PluginsAndMore(),
                              ),
                              onPressed: () async {
                                var linkUrl = '';

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
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset('Safari.png'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
                                'Pieces for FireFox',
                                style: PluginsAndMore(),
                              ),
                              onPressed: () async {
                                var linkUrl = '';

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
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset('Firefox.png'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Text(
                                'Pieces for Brave',
                                style: PluginsAndMore(),
                              ),
                              onPressed: () async {
                                var linkUrl = '';

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
                            SizedBox(
                              height: 20,
                              width: 20,
                              child: Image.asset('brave.png'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [

                /// docs
                Padding(
                  padding: const EdgeInsets.only(left: 20.0, top: 15),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(

                            onPressed: () async {

                              /// redirect to docs in browser
                              String linkUrl = 'https://docs.google.com/document/u/0/?tgif=d';

                              linkUrl = linkUrl; //Twitter's URL
                              if (await canLaunch(linkUrl)) {
                                await launch(
                                  linkUrl,
                                );
                              } else {
                                throw 'Could not launch $linkUrl';
                              }

                            },
                            child: Image.asset('docs.png'),),
                        ),
                      ),


                      /// sheets
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 30,
                          width: 30,
                          child: TextButton(

                            onPressed: () async {


                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'hold tight while we gather your snapshot!',
                                  ),
                                  duration: Duration(
                                      days: 0,
                                      hours: 0,
                                      minutes: 0,
                                      seconds: 4,
                                      milliseconds: 30,
                                      microseconds: 10),
                                ),
                              );



                              final gsheets = GSheets(credentials);

                              final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';

                              final ssheet = await gsheets.spreadsheet(spreadsheetID);

                              Worksheet? ws = await ssheet.worksheetByTitle('Indy');


                              await ws?.values
                                  .insertRow(1, ['Languages', 'Count', '', 'People', 'Links', 'Tags'], fromColumn: 1);

                              /// Languages Column
                              await ws?.values.insertColumn(1, languages, fromRow: 2);


                              /// count Column
                              await ws?.values.insertColumn(2, languageCounts, fromRow: 2);


                              /// added a blank placeholder
                              List<String> people =  StatisticsSingleton().statistics?.persons.toList() ?? [];
                              people.add('');

                              /// people Column
                              await ws?.values.insertColumn(4, people, fromRow: 2);
                              /// added a blank placeholder
                              List<String> links =  StatisticsSingleton().statistics?.relatedLinks.toList() ?? [];
                              links.add('');

                              /// Tags Column
                              await ws?.values.insertColumn(5, links , fromRow: 2);

                              /// added a blank placeholder
                              List<String> tagsList =  StatisticsSingleton().statistics?.tags.toList() ?? [];
                              tagsList.add('');
                              /// tags Column
                              await ws?.values.insertColumn(6, tagsList, fromRow: 2);





                              /// redirect to gsheets in browser
                              String linkUrl = 'https://docs.google.com/spreadsheets/d/18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM/edit#gid=1601436512';

                              linkUrl = linkUrl; //Twitter's URL
                              if (await canLaunch(linkUrl)) {
                                await launch(
                                  linkUrl,
                                );
                              } else {
                                throw 'Could not launch $linkUrl';
                              }

                            },
                            child: Image.asset('gsheets.png'),),
                        ),
                      ),

                      /// calendar
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: TextButton(

                            onPressed: () async {



                              /// redirect to gsheets in browser
                              String linkUrl = 'https://calendar.google.com/calendar/u/0/r';

                              linkUrl = linkUrl; //Twitter's URL
                              if (await canLaunch(linkUrl)) {
                                await launch(
                                  linkUrl,
                                );
                              } else {
                                throw 'Could not launch $linkUrl';
                              }

                            },
                            child: Image.asset('calendar.png'),),
                        ),
                      ),

                      /// teams
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: TextButton(

                            onPressed: () async {

                              /// redirect to gsheets in browser
                              String linkUrl = '';

                              linkUrl = linkUrl; //Twitter's URL
                              if (await canLaunch(linkUrl)) {
                                await launch(
                                  linkUrl,
                                );
                              } else {
                                throw 'Could not launch $linkUrl';
                              }

                            },
                            child: Image.asset('teams.png'),),
                        ),
                      ),

                      /// drive
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          width: 40,
                          child: TextButton(

                            onPressed: () async {

                              /// redirect to gsheets in browser
                              String linkUrl = 'https://drive.google.com/drive/u/0/my-drive';

                              linkUrl = linkUrl; //Twitter's URL
                              if (await canLaunch(linkUrl)) {
                                await launch(
                                  linkUrl,
                                );
                              } else {
                                throw 'Could not launch $linkUrl';
                              }

                            },
                            child: Image.asset('drive.png'),),
                        ),
                      ),
                    ],
                  ),
                ),



                Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0, top: 5),
                      //   child: TextButton(
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           height: 40,
                      //           width: 40,
                      //           child: Image.asset('pfd.png'),
                      //         ),
                      //         Text(
                      //           '',
                      //         ),
                      //       ],
                      //     ),
                      //     onPressed: () async {
                      //       String linkUrl = 'https://code.pieces.app/install';
                      //
                      //       linkUrl = linkUrl; //Twitter's URL
                      //       if (await canLaunch(linkUrl)) {
                      //         await launch(
                      //           linkUrl,
                      //         );
                      //       } else {
                      //         throw 'Could not launch $linkUrl';
                      //       }
                      //     },
                      //   ),
                      // ),

                      /// linkedin

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5),
                        child: TextButton(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset('linkedin.png'),
                              ),
                              Text(
                                '',
                              ),
                            ],
                          ),
                          onPressed: () async {
                            var linkUrl = 'https://www.linkedin.com/company/getpieces/mycompany/';

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
                      ),

                      /// twitter
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5),
                        child: TextButton(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset('twitter.png'),
                              ),
                              Text(
                                '',
                              ),
                            ],
                          ),
                          onPressed: () async {
                            var linkUrl = 'https://twitter.com/getpieces';

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
                      ),

                      /// facebook
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 5),
                        child: TextButton(
                          child: Row(
                            children: [
                              SizedBox(
                                height: 20,
                                width: 20,
                                child: Image.asset('facebook.png'),
                              ),
                              Text(
                                '',
                              ),
                            ],
                          ),
                          onPressed: () async {
                            var linkUrl =
                                'https://www.facebook.com/520508470288885/posts/559057106234021';

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
                      ),

                      // /// github
                      // Padding(
                      //   padding: const EdgeInsets.only(left: 10.0, top: 5),
                      //   child: TextButton(
                      //
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           height: 30,
                      //           width: 30,
                      //           child: Image.asset('GPT.png'),
                      //         ),
                      //         Text(
                      //           '',
                      //         ),
                      //       ],
                      //     ),
                      //     onPressed: () async {
                      //       String linkUrl = '';
                      //
                      //       linkUrl = linkUrl; //Twitter's URL
                      //       if (await canLaunch(linkUrl)) {
                      //         await launch(
                      //           linkUrl,
                      //         );
                      //       } else {
                      //         throw 'Could not launch $linkUrl';
                      //       }
                      //     },
                      //   ),
                      // ),
                    ],
                  ),
                ),



              ],
            ),
          ],
        ),
      ),
    );
  }
}

// https://www.codeplusplus.app/
//https://www.facebook.com/getpieces?hc_ref=ARTty9yMKDnC6EOC_dukOB8gsP09WwI5IUY7joQePSgH_eL8mwtbaDQcRwGymY7PSgI&fref=nf&__xts__[0]=68.ARArJRvE3X4gZQbgIIJ4o3jEHlG8obp9EF2jC70I6Z9Jc_ol75UDquczKVgZGoc2Vmky-PzPlcPQD26uZUlAcXu48nDQl8gEO_Wd7V1Bhg8rHq0NxfvuuOul8XypYOy86m8gtisqe_3AF5bZLImHCtbtasfrtvxTXtPCoFClqP6TIxHJp0PUXROvHGV-1doBtEBlqJ9BxPWUpefeLXNO8KgafE7V3M_ohQi7ZEheRc1y4Zi02St-vdArwbzSkmsl6qDh-KFPJqLVDlztD4sk_OPsRlxFvukPVrGRFFA68UpjKJpPmaI
class Language {
  List languages = [
    'batchfile',
    'c',
    'sharp',
    'coffees',
    'cpp',
    'css',
    'dart',
    'erlang',
    'go',
    'haskell',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'markdown',
    'matlab',
    'objective-c',
    'perl',
    'php',
    'powershell',
    'python',
    'r',
    'ruby',
    'rust',
    'scala',
    'sql',
    'swift',
    'typescript',
    'tex',
    'text',
    'toml',
    'yaml',
  ];
}



