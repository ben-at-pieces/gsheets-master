import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:runtime_client/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import '../CustomAppBar.dart';
import '../Dashboard/custom_classes.dart';
import '../bottom_appbar_class.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

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
        color: Colors.black87,
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
                                    customization: TextStyle(color: Colors.white, fontSize: 20),
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
                                  String linkUrl = 'https://code.pieces.app/install';

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
                                customization: TextStyle(color: Colors.white, fontSize: 20),
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
                                  String linkUrl =
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
                                String linkUrl =
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
                                      customization: TextStyle(color: Colors.white, fontSize: 20),
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
                                  String linkUrl = 'https://www.codefromscreenshot.com/';

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
                                String linkUrl = 'https://www.textfromscreenshot.com/';

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
                                String linkUrl = 'https://www.codeplusplus.app/';

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
                                      customization: TextStyle(color: Colors.white, fontSize: 20),
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
                                  String linkUrl =
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
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0, top: 5),
                  //   child: TextButton(
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           height: 35,
                  //           width: 35,
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
                        String linkUrl = 'https://www.linkedin.com/company/getpieces/mycompany/';

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
                        String linkUrl = 'https://twitter.com/getpieces';

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
                        String linkUrl =
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



