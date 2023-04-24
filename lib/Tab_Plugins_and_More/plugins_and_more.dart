import 'package:flutter/material.dart';
import 'package:gsheets/Tab_Plugins_and_More/pluginButton.dart';
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
                          padding: const EdgeInsets.only(top: 15.0, right: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomTextButton(
                                imageAssetPath: 'roundedpfd.png',
                                text: 'Desktop App',
                                url: 'https://code.pieces.app/install',
                              ),                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // color: Colors.grey,
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
                              CustomTextButton(
                                imageAssetPath: 'vscode.png',
                                text: 'Pieces for VS Code',
                                url:
                                    'https://marketplace.visualstudio.com/items?itemName=MeshIntelligentTechnologiesInc.pieces-vscode',
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                              imageAssetPath: 'jetbrains.png',
                              text: 'Pieces for JetBrains',
                              url:
                                  'https://plugins.jetbrains.com/plugin/17328-pieces--save-search-share--reuse-code-snippets',
                            ),
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
                              CustomTextButton(
                                imageAssetPath: 'toml-white.jpg',
                                text: 'Code From Screenshot',
                                url: 'https://www.codefromscreenshot.com/',
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                              imageAssetPath: 'text.jpg',
                              text: 'Text From Screenshot',
                              url: 'https://www.textfromscreenshot.com/',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                              imageAssetPath: 'bettercode.jpg',
                              text: 'Code Plus Plus',
                              url: 'https://www.codeplusplus.app/',
                            ),
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
                              CustomTextButton(
                                imageAssetPath: 'Chrome.png',
                                text: 'Pieces for Chrome',
                                url:
                                    'https://chrome.google.com/webstore/detail/pieces-save-code-snippets/igbgibhbfonhmjlechmeefimncpekepm',
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                              imageAssetPath: 'Safari.png',
                              text: 'Pieces for Safari',
                              url: '',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                              imageAssetPath: 'Firefox.png',
                              text: 'Pieces for FireFox',
                              url: '',
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomTextButton(
                              imageAssetPath: 'brave.png',
                              text: 'Pieces for Brave',
                              url: '',
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextButton(
                        imageAssetPath: 'docs.png',
                        text: '',
                        url: 'https://docs.google.com/document/u/0/?tgif=d',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextButton(
                        imageAssetPath: 'gsheets.png',
                        text: '',
                        url:
                            'https://docs.google.com/spreadsheets/d/18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM/edit#gid=1601436512',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextButton(
                        imageAssetPath: 'calendar.png',
                        text: '',
                        url: 'https://calendar.google.com/calendar/u/0/r',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextButton(
                        imageAssetPath: 'teams.png',
                        text: '',
                        url: '',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomTextButton(
                        imageAssetPath: 'drive.png',
                        text: '',
                        url: 'https://drive.google.com/drive/u/0/my-drive',
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Padding(
            //   padding: const EdgeInsets.only(left: 10.0, top: 15),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.start,
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       // Padding(
            //       //   padding: const EdgeInsets.only(left: 10.0, top: 5),
            //       //   child: TextButton(
            //       //     child: Row(
            //       //       children: [
            //       //         SizedBox(
            //       //           height: 40,
            //       //           width: 40,
            //       //           child: Image.asset('pfd.png'),
            //       //         ),
            //       //         Text(
            //       //           '',
            //       //         ),
            //       //       ],
            //       //     ),
            //       //     onPressed: () async {
            //       //       String linkUrl = 'https://code.pieces.app/install';
            //       //
            //       //       linkUrl = linkUrl; //Twitter's URL
            //       //       if (await canLaunch(linkUrl)) {
            //       //         await launch(
            //       //           linkUrl,
            //       //         );
            //       //       } else {
            //       //         throw 'Could not launch $linkUrl';
            //       //       }
            //       //     },
            //       //   ),
            //       // ),
            //
            //       /// linkedin
            //
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10.0, top: 5),
            //         child: TextButton(
            //           child: Row(
            //             children: [
            //               SizedBox(
            //                 height: 20,
            //                 width: 20,
            //                 child: Image.asset('linkedin.png'),
            //               ),
            //               Text(
            //                 '',
            //               ),
            //             ],
            //           ),
            //           onPressed: () async {
            //             var linkUrl = 'https://www.linkedin.com/company/getpieces/mycompany/';
            //
            //             linkUrl = linkUrl; //Twitter's URL
            //             if (await canLaunch(linkUrl)) {
            //               await launch(
            //                 linkUrl,
            //               );
            //             } else {
            //               throw 'Could not launch $linkUrl';
            //             }
            //           },
            //         ),
            //       ),
            //
            //       /// twitter
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10.0, top: 5),
            //         child: TextButton(
            //           child: Row(
            //             children: [
            //               SizedBox(
            //                 height: 20,
            //                 width: 20,
            //                 child: Image.asset('twitter.png'),
            //               ),
            //               Text(
            //                 '',
            //               ),
            //             ],
            //           ),
            //           onPressed: () async {
            //             var linkUrl = 'https://twitter.com/getpieces';
            //
            //             linkUrl = linkUrl; //Twitter's URL
            //             if (await canLaunch(linkUrl)) {
            //               await launch(
            //                 linkUrl,
            //               );
            //             } else {
            //               throw 'Could not launch $linkUrl';
            //             }
            //           },
            //         ),
            //       ),
            //
            //       /// facebook
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10.0, top: 5),
            //         child: TextButton(
            //           child: Row(
            //             children: [
            //               SizedBox(
            //                 height: 20,
            //                 width: 20,
            //                 child: Image.asset('facebook.png'),
            //               ),
            //               Text(
            //                 '',
            //               ),
            //             ],
            //           ),
            //           onPressed: () async {
            //             var linkUrl =
            //                 'https://www.facebook.com/520508470288885/posts/559057106234021';
            //
            //             linkUrl = linkUrl; //Twitter's URL
            //             if (await canLaunch(linkUrl)) {
            //               await launch(
            //                 linkUrl,
            //               );
            //             } else {
            //               throw 'Could not launch $linkUrl';
            //             }
            //           },
            //         ),
            //       ),
            //
            //
            //
            //       /// youtube
            //       Padding(
            //         padding: const EdgeInsets.only(left: 10.0, top: 5),
            //         child: TextButton(
            //           child: Row(
            //             children: [
            //               SizedBox(
            //                 height: 30,
            //                 width: 30,
            //                 child: Image.asset('youtube.png'),
            //               ),
            //               Text(
            //                 '',
            //               ),
            //             ],
            //           ),
            //           onPressed: () async {
            //             var linkUrl =
            //                 'https://www.youtube.com/channel/UCD3ZXdxCqTd9mMgQnN1hWbw';
            //
            //             linkUrl = linkUrl; //Twitter's URL
            //             if (await canLaunch(linkUrl)) {
            //               await launch(
            //                 linkUrl,
            //               );
            //             } else {
            //               throw 'Could not launch $linkUrl';
            //             }
            //           },
            //         ),
            //       ),
            //
            //       // /// github
            //       // Padding(
            //       //   padding: const EdgeInsets.only(left: 10.0, top: 5),
            //       //   child: TextButton(
            //       //
            //       //     child: Row(
            //       //       children: [
            //       //         SizedBox(
            //       //           height: 30,
            //       //           width: 30,
            //       //           child: Image.asset('GPT.png'),
            //       //         ),
            //       //         Text(
            //       //           '',
            //       //         ),
            //       //       ],
            //       //     ),
            //       //     onPressed: () async {
            //       //       String linkUrl = '';
            //       //
            //       //       linkUrl = linkUrl; //Twitter's URL
            //       //       if (await canLaunch(linkUrl)) {
            //       //         await launch(
            //       //           linkUrl,
            //       //         );
            //       //       } else {
            //       //         throw 'Could not launch $linkUrl';
            //       //       }
            //       //     },
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
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
