// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import '../Dashboard/custom_classes.dart';

class EditableTextWidget extends StatefulWidget {
  final String initialText;

  EditableTextWidget({required this.initialText});

  @override
  _EditableTextWidgetState createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late TextEditingController _textController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(
                    _isEditing ? 'CANCEL' : 'EDIT',
                    style: TitleText(),
                  ),
                ),

              ],
            ),
          ],
        ),
        if (_isEditing)
          Column(
            children: [
              Container(
                width: 250,
                height: 300,
                child: TextField(
                  autofocus: false,
                  maxLines: null,
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: EditingTextStyle(),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () async {    String port = '1000';
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
                    child: Text(
                      'save',
                      style: TitleText(),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {

                      _textController.clear();
                      Navigator.of(context).pop();


                    },
                    child: Text(
                      'close',
                      style: TitleText(),
                    ),
                  ), ],
              ),
            ],
          )
        else if (_textController.text.isNotEmpty)
          Container(
            height: 200,
            width: 250,
            child: Text(''),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
