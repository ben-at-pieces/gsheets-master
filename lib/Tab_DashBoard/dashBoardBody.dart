// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/Tab_Plugins_and_More/plugins_and_more.dart';
import 'package:gsheets/Tab_DashBoard/getRelatedItems.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:runtime_client/particle.dart';

import '../Dashboard/custom_classes.dart';
import '../Dashboard/faqs.dart';
import '../Dashboard/reference_GPT.dart/gpt_modify_text.dart';
import '../statistics_singleton.dart';
import 'custom_text_buttons.dart';

class DashboardBody extends StatefulWidget {
  DashboardBody({Key? key}) : super(key: key);

  @override
  State<DashboardBody> createState() => _DashboardBodyState();
}

class _DashboardBodyState extends State<DashboardBody> {
  String input = '';
  List<String> related = [];
  List<String> snippy = [];
  List<Asset> list = StatisticsSingleton().statistics?.asset.toList() ?? [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Card(
                    elevation: 2,
                    shadowColor: Colors.black,
                    child: Container(
                      width: 490,
                      height: 40,
                      color: Colors.white,
                      child: TextField(

                        controller: _textEditController,
                        enableInteractiveSelection: true,
                        cursorHeight: 12,
                        autofocus: true,
                        // showCursor: true,
                        cursorColor: Colors.black,
                        toolbarOptions: ToolbarOptions(
                          copy: true,
                          paste: true,
                          selectAll: true,
                          cut: true,
                        ),
                        style: TitleText(),
                        decoration: InputDecoration(
                          // label: Text('profile'),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 12,
                            color: Colors.grey,
                          ),
                          suffixIcon:  IconButton(
                            iconSize: 15,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              _textEditController.clear();
                            },
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                          hintText: 'search...',
                        ),
                        onChanged: (value) {
                          setState(() {
                            input = value;
                            related = getRelatedItems(input);
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: FloatingActionButton(
                  // focusColor: Colors.green,
                  tooltip: 'frequently asked questions',
                  hoverColor: Colors.white,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  child: Text(
                    'FAQ',
                    style: ParticleFont.micro(
                      context,
                      customization: TextStyle(color: Colors.grey),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return FloatingSettingsButton();
                      },
                    );
                  },
                ),
              ),
            ],
          ),

          /// GridView Builder ----------------------------------------------------------------------
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                ),
                // shrinkWrap: true,
                itemCount: related.length,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // SizedBox(height: 30, width: 30, child: Image.asset('img_3.png')),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Card(
                          elevation: 4,
                          shadowColor: Colors.black,
                          child: Container(
                            color: Colors.white,
                            width: 200,
                            height: 130,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(
                                    related[index],
                                    softWrap: true,
                                    style: TitleText(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      // Divider(
                      //   color: Colors.white,
                      //   thickness: 2,
                      // ),
                      /// copy button
                      SizedBox(
                        height: 50,
                        child:

                            /// teams
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            /// This code creates a button with an icon that, when pressed, shows a brief message and copies some text to the clipboard.
                            IconButton(
                              // tooltip: 'copy',
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
                                        microseconds: 10),
                                  ),
                                );
                                ClipboardData data = ClipboardData(text: related[index]);
                                await Clipboard.setData(data);
                              },
                            ),

                            // /// teams button
                            /// teams button
                            TextButton(
                              child: SizedBox(
                                height: 20,
                                width: 20,
                                child: Icon(
                                  Icons.people,
                                  size: 20,
                                  color: Colors.black,
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return GPTCustomAlertDialog(
                                      initialText: related[index],
                                    );
                                  },
                                );
                              },
                            ),

                            /// copy and reference
                            /// Displays an icon button with an image and a tooltip, and performs various actions when pressed, including showing a snackbar, copying data to the clipboard, making API calls, and launching a URL.
                            IconButton(
                              icon: SizedBox(
                                  height: 40, width: 40, child: Image.asset('black_gpt.png')),
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
                            
                            
                          
                            
'${related[index]}',
                          

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
          Divider(
            color: Colors.white,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                LabeledChipButton(
                  chipLabel: 'profile' ?? '',
                  onPressed: () {
                    setState(() {
                      input = 'profile';
                      related = getRelatedItems(input);
                    });
                  },
                ),
                LabeledChipButton(
                  chipLabel: 'snippets: ${StatisticsSingleton().statistics?.asset.length}' ?? '',
                  onPressed: () {
                    setState(() {
                      input = 'snippets';
                      related = getRelatedItems(input);
                    });
                  },
                ),
                LabeledChipButton(
                  chipLabel: 'people: ${StatisticsSingleton().statistics?.persons.length}' ?? '',
                  onPressed: () {
                    setState(() {
                      input = 'people';
                      related = getRelatedItems(input);
                    });
                  },
                ),
                LabeledChipButton(
                  chipLabel: 'tags: ${StatisticsSingleton().statistics?.tags.length}' ?? '',
                  onPressed: () {
                    setState(() {
                      input = 'tags';
                      related = getRelatedItems(input);
                    });
                  },
                ),
                LabeledChipButton(
                  chipLabel: 'links: ${StatisticsSingleton().statistics?.relatedLinks.length}' ?? '',
                  onPressed: () {
                    setState(() {
                      input = 'links';
                      related = getRelatedItems(input);
                    });
                  },
                ),
                LabeledChipButton(
                  chipLabel: 'learn: ',
                  onPressed: () {
                    setState(() {
                      input = 'learn!';
                      related = getRelatedItems(input);
                    });
                  },
                ),

                // TextButton(
                //   child: SizedBox(
                //     height: 50,
                //     width: 50,
                //     child: Padding(
                //       padding: const EdgeInsets.all(3.0),
                //       child: Image.asset(
                //         'img_3.png',
                //       ),
                //     ),
                //   ),
                //   onPressed: () {
                //     showDialog(
                //       context: context,
                //       builder: (context) {
                //         return Scaffold(
                //           body: AlertDialog(
                //             backgroundColor: Colors.white,
                //             title: SizedBox(
                //               // height: 450,
                //               width: 450,
                //               child: Text(
                //                 'Enrich your message with Chat GPT:',
                //                 style: TitleBlackText(),
                //               ),
                //             ),
                //             content: SizedBox(
                //               height: 260,
                //               child: Column(
                //                 children: [
                //                   Container(
                //                     color: Colors.white,
                //                     height: 250,
                //                     width: 500,
                //                     child: TextField(
                //                       autofocus: true,
                //                       style: ParticleFont.micro(context,
                //                           customization: TextStyle(color: Colors.black, fontSize: 14)),
                //                       toolbarOptions: ToolbarOptions(
                //                         copy: true,
                //                         paste: true,
                //                         selectAll: true,
                //                       ),
                //                       cursorHeight: 12,
                //                       cursorColor: Colors.black,
                //                       minLines: 20,
                //                       maxLines: 20,
                //                       autocorrect: true,
                //                       controller: _textFieldController,
                //                       decoration: InputDecoration(
                //                         labelStyle: ParticleFont.micro(
                //                           context,
                //                           customization: TextStyle(color: Colors.black, fontSize: 16),
                //                         ),
                //                         floatingLabelBehavior: FloatingLabelBehavior.auto,
                //                         labelText: 'Type something...',
                //                         hintStyle: ParticleFont.micro(context,
                //                             customization: TextStyle(color: Colors.black)),
                //                         suffixIcon: Column(
                //                           children: [
                //                             IconButton(
                //                               iconSize: 15,
                //                               icon: Icon(
                //                                 Icons.clear,
                //                                 color: Colors.grey,
                //                               ),
                //                               onPressed: () {
                //                                 _textFieldController.clear();
                //                               },
                //                             ),
                //                           ],
                //                         ),
                //                         enabledBorder: OutlineInputBorder(
                //                           borderSide: BorderSide(
                //                             style: BorderStyle.solid,
                //                             color: Colors.black,
                //                           ),
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //             actions: [
                //               /// Save to Pieces ------------------------------------------------------------
                //               Padding(
                //                 padding: const EdgeInsets.all(15.0),
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(8),
                //                   child: Container(
                //                     color: Colors.black54,
                //                     child: TextButton(
                //                       child: Text(
                //                         'save',
                //                         style: ParticleFont.micro(
                //                           context,
                //                           customization: TextStyle(
                //                             color: Colors.white,
                //                             fontSize: 12,
                //                           ),
                //                         ),
                //                       ),
                //                       onPressed: () async {
                //                         String port = '1000';
                //                         String host = 'http://localhost:$port';
                //                         final AssetsApi assetsApi =
                //                             AssetsApi(ApiClient(basePath: host));
                //
                //                         final ApplicationsApi applicationsApi =
                //                             await ApplicationsApi(ApiClient(basePath: host));
                //
                //                         Applications applicationsSnapshot =
                //                             await applicationsApi.applicationsSnapshot();
                //
                //                         var first = applicationsSnapshot.iterable.first;
                //
                //                         final Asset response = await assetsApi.assetsCreateNewAsset(
                //                           seed: Seed(
                //                             asset: SeededAsset(
                //                               application: Application(
                //                                 privacy: first.privacy,
                //                                 name: first.name,
                //                                 onboarded: first.onboarded,
                //                                 platform: first.platform,
                //                                 version: first.version,
                //                                 id: first.id,
                //                               ),
                //                               format: SeededFormat(
                //                                 ///=======
                //                                 fragment: SeededFragment(
                //                                   string: TransferableString(
                //                                     raw: _textFieldController.text,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                             type: SeedTypeEnum.ASSET,
                //                           ),
                //                         );
                //                         _textFieldController.clear();
                //
                //                         Navigator.of(context).pop;
                //                         ScaffoldMessenger.of(context).showSnackBar(
                //                           SnackBar(
                //                             content: Text(
                //                               'successfully saved to pieces!',
                //                             ),
                //                             duration: Duration(
                //                                 days: 0,
                //                                 hours: 0,
                //                                 minutes: 0,
                //                                 seconds: 4,
                //                                 milliseconds: 30,
                //                                 microseconds: 10),
                //                           ),
                //                         );
                //
                //                         //   },
                //                         // );
                //                       },
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //
                //               /// Reference Button --------------------------------------------------------------
                //               Padding(
                //                 padding: const EdgeInsets.all(15.0),
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(8),
                //                   child: Container(
                //                     color: Colors.black54,
                //                     child: TextButton(
                //                       child: Text(
                //                         'reference',
                //                         style: ParticleFont.micro(
                //                           context,
                //                           customization: TextStyle(color: Colors.white, fontSize: 12),
                //                         ),
                //                       ),
                //                       onPressed: () async {
                //                         Navigator.of(context).pop();
                //                         ScaffoldMessenger.of(context).showSnackBar(
                //                           SnackBar(
                //                             content: Text(
                //                               'Copied to clipboard, now reference it on chat gpt!',
                //                             ),
                //                             duration: Duration(
                //                                 days: 0,
                //                                 hours: 0,
                //                                 minutes: 0,
                //                                 seconds: 5,
                //                                 milliseconds: 30,
                //                                 microseconds: 10),
                //                           ),
                //                         );
                //                         ClipboardData data = ClipboardData(text: '''
                //
                //
                //                       hello, please tell me about this :
                //
                //
                //                       $_textFieldController
                //
                //                       and show me an example?
                //
                //                       ''');
                //                         await Clipboard.setData(data);
                //
                //                         await Future.delayed(Duration(seconds: 4));
                //
                //                         String port = '1000';
                //                         String host = 'http://localhost:$port';
                //                         final AssetsApi assetsApi =
                //                         AssetsApi(ApiClient(basePath: host));
                //
                //                         final ApplicationsApi applicationsApi =
                //                         await ApplicationsApi(ApiClient(basePath: host));
                //
                //                         Applications applicationsSnapshot =
                //                         await applicationsApi.applicationsSnapshot();
                //
                //                         var first = applicationsSnapshot.iterable.first;
                //
                //                         final Asset response = await assetsApi.assetsCreateNewAsset(
                //                           seed: Seed(
                //                             asset: SeededAsset(
                //                               application: Application(
                //                                 privacy: first.privacy,
                //                                 name: first.name,
                //                                 onboarded: first.onboarded,
                //                                 platform: first.platform,
                //                                 version: first.version,
                //                                 id: first.id,
                //                               ),
                //                               format: SeededFormat(
                //                                 ///=======
                //                                 fragment: SeededFragment(
                //                                   string: TransferableString(
                //                                     raw: data.text,
                //                                   ),
                //                                 ),
                //                               ),
                //                             ),
                //                             type: SeedTypeEnum.ASSET,
                //                           ),
                //                         );
                //                         _textFieldController.clear();
                //
                //                         Navigator.of(context).pop;
                //
                //                         String linkUrl = 'https://chat.openai.com/chat';
                //
                //                         linkUrl = linkUrl; //Twitter's URL
                //                         if (await canLaunch(linkUrl)) {
                //                           await launch(
                //                             linkUrl,
                //                           );
                //                         } else {
                //                           throw 'Could not launch $linkUrl';
                //                         }
                //                       },
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //
                //               /// Close Button --------------------------------------------------------------
                //               Padding(
                //                 padding: const EdgeInsets.all(15.0),
                //                 child: ClipRRect(
                //                   borderRadius: BorderRadius.circular(8),
                //                   child: Container(
                //                     color: Colors.black54,
                //                     child: TextButton(
                //                       child: Text(
                //                         'close',
                //                         style: ParticleFont.micro(
                //                           context,
                //                           customization: TextStyle(color: Colors.white, fontSize: 12),
                //                         ),
                //                       ),
                //                       onPressed: () {
                //                         Navigator.of(context).pop();
                //                         _textFieldController.clear();
                //                       },
                //                     ),
                //                   ),
                //                 ),
                //               ),
                //
                //
                //             ],
                //           ),
                //         );
                //       },
                //     );
                //   },
                // ),
              ],
            ),
          ),

          /// ==========================================================
        ],
      ),
    );
  }
}

final TextEditingController _textFieldController = TextEditingController();

final TextEditingController _textEditController = TextEditingController();
