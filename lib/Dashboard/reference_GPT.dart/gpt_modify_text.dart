// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types, prefer_const_constructors, use_key_in_widget_constructors
import 'dart:html';

import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';

import '../../Tab_Peoples_List/peoples_list.dart';
import '../../Tab_Plugins_and_More/plugins_and_more.dart';
import '../../Tab_DashBoard/checkbox_class.dart';
import '../../statistics_singleton.dart';
import '../custom_classes.dart';

class GPTCustomAlertDialog extends StatefulWidget {
  final String initialText;

  GPTCustomAlertDialog({required this.initialText});

  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<GPTCustomAlertDialog> {
  late TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    /// The code creates an alert dialog with a text field, two buttons ("save & copy" and "close"), and a scrollable list of items with checkboxes. The "save & copy" button sends data to an API to create a new asset
    return AlertDialog(
      content: Container(
        color: Colors.white,
        height: 450,
        width: 450,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  TextField(
                    autofocus: false,
                    style: TitleText(),
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
                      labelStyle: TitleText(),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      labelText: 'Need to make update before sending?',
                      hintStyle: PluginsAndMore(),
                      suffixIcon: IconButton(
                        iconSize: 15,
                        icon: Icon(
                          Icons.clear,
                          color: Colors.black,
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
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      height: 25,
                      width: 450,
                      color: Colors.white,
                    ),
                  ),

                  /// Creates two buttons: one sends data to an API to create a new asset and clears a text field, while the other displays a confirmation dialog and closes the current screen if "Yes" is pressed.
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                                      raw: _textController.text,
                                    ),
                                  ),
                                ),
                              ),
                              type: SeedTypeEnum.ASSET,
                            ),
                          );
                          _textController.clear();
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

                      /// Displays a confirmation dialog with "Yes" and "No" buttons. If "Yes" is pressed, it closes the current screen and clears a text field.
                      TextButton(
                        onPressed: () async {
                          final confirmed = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              /// Displays an alert dialog with a confirmation message and two buttons, "Yes" and "No". The "Yes" button returns true and the "No" button returns false when pressed.
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
                            _textController.clear();
                          }
                        },
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                        ),
                        child: Row(
                          children: [
                            // Icon(
                            //   Icons.close_sharp,
                            //   color: Colors.black,
                            // ),
                            SizedBox(width: 8),
                            Text(
                              'close',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// This code creates a scrollable list of items with checkboxes, displaying the names of persons stored in a statistics object.
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 70,
                      width: 450,
                      color: Colors.white,
                      child: ListView.builder(
                          itemCount: StatisticsSingleton().statistics?.persons.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              tileColor: Colors.white,
                              // leading: Icon(
                              //   Icons.account_circle_sharp,
                              //   color: Colors.black,
                              // ),
                              title: Text(
                                '${StatisticsSingleton().statistics?.persons.elementAt(index)}  ',
                                style: ParticleFont.bodyText1(context,
                                    customization: TextStyle(color: Colors.black)),
                              ),
                              trailing: MyCheckBoxWidgget(),
                            );
                            // title: Text('Person: $index'));
                          }),
                    ),
                  ),
                ],
              ),
              // SizedBox(height: 10),
            ],
          ),
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

final TextEditingController _descriptionController = TextEditingController();
