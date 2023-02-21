// ignore_for_file: omit_local_variable_types

import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/statistics_singleton.dart';
import 'package:runtime_client/particle.dart';



class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    String userPic = StatisticsSingleton().statistics?.picture.toString() ?? '';

    return Container(
      color: Colors.black87,
      child: ListTile(
        leading:CircleAvatar(
          backgroundImage: NetworkImage(
            userPic,
          ),
          radius: 20,
        ),
        title: Text(
          title,
          style: ParticleFont.micro(
            context,
            customization: TextStyle(color: Colors.white),
          ),
        ),
        trailing:  FloatingActionButton(
          focusColor: Colors.green,
          tooltip: 'create',
          hoverColor: Colors.grey,
          elevation: 2,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.add_box_outlined,
            size: 20,
            color: Colors.white,
          ),
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
                          height: 250,
                          width: 500,
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
                              suffixIcon: Column(
                                children: [
                                  IconButton(
                                    iconSize: 15,
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.grey,
                                    ),
                                    onPressed: () {
                                      _textFieldController.clear();
                                    },
                                  ),
                                ],
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
                      ],
                    ),
                  ),
                  actions: [
                    /// Save to Pieces ------------------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.black54,
                          child: TextButton(
                            child: Text(
                              'save to pieces',
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
                                          raw: _textFieldController.text,
                                        ),
                                      ),
                                    ),
                                  ),
                                  type: SeedTypeEnum.ASSET,
                                ),
                              );
                              _textFieldController.clear();

                              Navigator.of(context).pop;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'successfully saved to pieces!',
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

                    /// Close Button --------------------------------------------------------------
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          color: Colors.black54,
                          child: TextButton(
                            child: Text(
                              'close',
                              style: ParticleFont.micro(
                                context,
                                customization: TextStyle(color: Colors.white, fontSize: 12),
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              _textFieldController.clear();
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
        ),

      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}

final TextEditingController _textFieldController = TextEditingController();
