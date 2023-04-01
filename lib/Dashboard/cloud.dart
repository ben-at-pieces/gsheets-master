// Creates a custom alert dialog with a text field for users to modify and share a code snippet.
// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types, prefer_const_constructors, use_key_in_widget_constructors
import 'dart:html';

import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Tab_Plugins_and_More/plugins_and_more.dart';
import '../statistics_singleton.dart';
import 'custom_classes.dart';

class CustomAlertDialog extends StatefulWidget {
  final String initialText;

  CustomAlertDialog({required this.initialText});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  late TextEditingController _textController;

  int index = StatisticsSingleton().statistics?.asset.length.toInt() ?? 0;
  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        height: 450,
        width: 450,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TextField(
                autofocus: true,
                style: ParticleFont.micro(context,
                    customization:
                        TextStyle(color: Colors.black, fontSize: 14)),
                toolbarOptions: ToolbarOptions(
                  copy: true,
                  paste: true,
                  selectAll: true,
                ),
                cursorHeight: 12,
                cursorColor: Colors.black,
                minLines: 15,
                maxLines: 15,
                autocorrect: true,
                controller: _textController,
                decoration: InputDecoration(
                  labelStyle: ParticleFont.micro(
                    context,
                    customization: TitleText(),
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  labelText: 'Modify your snippet and share',
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  suffixIcon: IconButton(
                    iconSize: 15,
                    icon: Icon(
                      Icons.clear,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      _textController.clear();
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.solid,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 150,
                  width: 450,
                  child: SingleChildScrollView(
                    child: Text(
                      '${StatisticsSingleton().statistics?.asset.elementAt(index).description}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.black54,
                          child: TextButton(
                            child: Text(
                              'share',
                              style: ParticleFont.micro(
                                context,
                                customization: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.black54,
                          child: TextButton(
                            child: Text(
                              'save',
                              style: ParticleFont.micro(
                                context,
                                customization: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            onPressed: () async {
                              String port = '1000';
                              String host = 'http://localhost:$port';
                              final AssetsApi assetsApi =
                                  AssetsApi(ApiClient(basePath: host));

                              final ApplicationsApi applicationsApi =
                                  await ApplicationsApi(
                                      ApiClient(basePath: host));

                              Applications applicationsSnapshot =
                                  await applicationsApi.applicationsSnapshot();

                              var first = applicationsSnapshot.iterable.first;

                              final Asset response =
                                  await assetsApi.assetsCreateNewAsset(
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
                                          raw: _textController.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                  type: SeedTypeEnum.ASSET,
                                ),
                              );
                              _textController.clear();

                              Navigator.of(context).pop;

                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //
                              //   },
                              // );
                            },
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.black54,
                          child: TextButton(
                            child: Text(
                              'close',
                              style: ParticleFont.micro(
                                context,
                                customization: TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
