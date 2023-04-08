// ignore_for_file: omit_local_variable_types

import 'dart:io';

import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../Dashboard/custom_classes.dart';

class FilePickerWidget extends StatefulWidget {
  final TextEditingController textEditingController;
  final Widget Function(BuildContext) textButtonBuilder; // new parameter

  const FilePickerWidget({
    Key? key,
    required this.textEditingController,
    required this.textButtonBuilder, // initialize new parameter
  }) : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  Uint8List? _fileBytes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['png', 'svg', 'jpg', 'jpeg', 'txt', 'stl'],
            );
            if (result != null) {
              setState(() {
                _fileBytes = result.files.single.bytes;
                widget.textEditingController.text = result.files.single.name;
              });

              await showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('File Details'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (_fileBytes != null && (_fileBytes!.lengthInBytes < 10000000))
                            Image.memory(
                              _fileBytes!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Close',
                          style: TitleText(),
                        ),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_fileBytes != null) {
                            Asset createdAsset = await createImageAsset(_fileBytes!);
                            // print('Created asset: ${createdAsset.toJson().entries}');
                          }

                          _fileBytes?.toList();

                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Save',
                          style: TitleText(),
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
                              height: 40,
                              width: 40,
                              child: Image.asset('black_gpt.png'),
                            ),
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
                  );
                },
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Row(
              children: [
                Icon(Icons.attach_file_outlined, color: Colors.black, size: 20),
                Text(
                  'attach',
                  style: TitleText(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

Future<Asset> createImageAsset(Uint8List imageData) async {
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));

  Asset response = await assetsApi.assetsCreateNewAsset(
    seed: Seed(
      asset: SeededAsset(
        application: Application(
          privacy: PrivacyEnum.OPEN,
          name: ApplicationNameEnum.VS_CODE,
          onboarded: true,
          platform: PlatformEnum.WINDOWS,
          version: '4.1.1',
          id: '8ccad095-9ebd-4f41-b6aa-c084cd0d462f',
        ),
        format: SeededFormat(
          file: SeededFile(
            bytes:
                TransferableBytes(raw: imageData.toList()), // Use imageData instead of _fileBytes
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  return response;
}

final TextEditingController _textFieldController = TextEditingController();
