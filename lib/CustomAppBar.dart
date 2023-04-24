// ignore_for_file: omit_local_variable_types

import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/statistics_singleton.dart';
import 'package:runtime_client/particle.dart';
import 'package:flutter/services.dart';
import 'Dashboard/custom_classes.dart';

import 'package:url_launcher/url_launcher.dart';

import '../statistics_singleton.dart';
import 'dart:html';

import 'google_sheets/attach_pieces.dart';
import 'material_buttons/file_picker.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    String userPic = StatisticsSingleton().statistics?.picture.toString() ?? '';

    // backgroundImage: NetworkImage(
    //   userPic,
    //   scale: 1,
    // ),
    return Container(
      color: Colors.white,
      child: ListTile(
        leading: SizedBox(
          height: 30,
          width: 30,
          child: CircleAvatar(
            backgroundColor: Colors.black87,
            foregroundImage: AssetImage('icon_path_white.png'),
            radius: 35,
          ),
        ),
        title: Text(
          title,
          style: ParticleFont.micro(
            context,
            customization: TextStyle(color: Colors.black),
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilePickerWidget(
              textEditingController: _textFieldController,
              textButtonBuilder: (BuildContext) {
                return Text('data');
              },
              // textButtonBuilder: (BuildContext context) {
              //   return Text('hello');
              // },
            ),
            TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: Text(
                        'Create a Custom Snippet:',
                        style: ParticleFont.subtitle1(
                          context,
                          customization: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      content: SizedBox(
                        height: 220,
                        child: Column(
                          children: [
                            Container(
                              color: Colors.white,
                              height: 200,
                              width: 500,
                              child: TextField(
                                autofocus: true,
                                style: ParticleFont.micro(context,
                                    customization: TextStyle(color: Colors.black, fontSize: 14)),
                                toolbarOptions: ToolbarOptions(
                                  copy: true,
                                  paste: true,
                                  selectAll: true,
                                ),
                                cursorHeight: 12,
                                cursorColor: Colors.black,
                                minLines: 10,
                                maxLines: 10,
                                autocorrect: true,
                                controller: _textFieldController,
                                decoration: InputDecoration(
                                  labelStyle: ParticleFont.micro(
                                    context,
                                    customization: TextStyle(color: Colors.black, fontSize: 16),
                                  ),
                                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                                  labelText: 'Type something...',
                                  hintStyle: ParticleFont.micro(context,
                                      customization: TextStyle(color: Colors.black)),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      style: BorderStyle.solid,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      actions: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ///close button Teams
                            /// This code creates a button
                            /// that, when pressed,
                            /// sends data to an API to create a new asset
                            /// and clears a text field.
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
                                    width: 24,
                                    height: 24,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'save & copy',
                                    style: TitleText(),
                                  ),
                                ],
                              ),
                            ),

                            /// The code displays a button with an image and text.
                            /// When pressed,
                            /// it copies some text to the clipboard,
                            /// creates a new asset,
                            /// and launches a URL.
                            /// It also displays a SnackBar with a message.
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
hello chat GPT, please give me an explanation and example about the text below:
                                                 
                                
'  ${_textFieldController ?? ''}',
                              

                                ''');
                                await Clipboard.setData(data);
                                // Navigator.of(context).pop();

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
                                      height: 20, width: 18, child: Image.asset('black_gpt.png')),
                                  Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Text(
                                      'reference',
                                      style: TitleText(),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// Displays a confirmation dialog
                            /// with "Yes" and "No" buttons.
                            /// If "Yes" is pressed,
                            /// it closes the current screen and clears a text field.
                            TextButton(
                              onPressed: () async {
                                final confirmed = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    /// Displays an alert dialog with a confirmation message and two buttons,
                                    /// "Yes" and "No".
                                    /// The "Yes" button returns true
                                    /// The 'No' button returns false when pressed.
                                    return AlertDialog(
                                      // title: Text('Confirm Close'),
                                      content: Text(
                                        'Are you sure?',
                                        style: TitleText(),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(false),
                                          child: Text(
                                            'No',
                                            style: TitleText(),
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(true),
                                          child: Text(
                                            'Yes',
                                            style: TitleText(),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                                if (confirmed) {
                                  Navigator.of(context).pop();
                                  _textFieldController.clear();
                                }
                              },
                              // style: ButtonStyle(
                              //   // foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                              // ),
                              child: Row(
                                children: [
                                  // Icon(
                                  //   Icons.close_sharp,
                                  //   color: Colors.black,
                                  // ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.close_sharp,
                                        size: 14,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        'close',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                );
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add_box_outlined,
                    size: 18,
                    color: Colors.black,
                  ),
                  Text(
                    'Create',
                    style: TitleText(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}

final TextEditingController _textFieldController = TextEditingController();
