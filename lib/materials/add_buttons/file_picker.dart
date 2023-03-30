// ignore_for_file: omit_local_variable_types

import 'dart:io';


import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../../Dashboard/custom_classes.dart';

class FilePickerWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  const FilePickerWidget({
    Key? key,
    required this.textEditingController,
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
                        child: Text('Close'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_fileBytes != null) {
                            Asset createdAsset = await createImageAsset(_fileBytes!);
                            print('Created asset: ${createdAsset.toJson()}');
                          }

                          _fileBytes?.toList();

                          Navigator.of(context).pop();
                        },
                        child: Text('Save'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              children: [
                Icon(Icons.image, color: Colors.black, size: 18),
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
            bytes: TransferableBytes(raw: imageData.toList()), // Use imageData instead of _fileBytes
          ),
        ),
      ),
      type: SeedTypeEnum.ASSET,
    ),
  );

  return response;
}
