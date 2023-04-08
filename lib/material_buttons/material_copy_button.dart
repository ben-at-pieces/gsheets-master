// ignore_for_file: omit_local_variable_types

import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/statistics_singleton.dart';

import '../Dashboard/custom_classes.dart';

class CopyToClipboardButton extends StatelessWidget {
  final String? rawString;
  final Uint8List? uint8list;

  const CopyToClipboardButton({Key? key, this.rawString, this.uint8list}) : super(key: key);

  Future<void> _copyCodeToClipboard(BuildContext context) async {
    Assets? assets = await AssetsApi(
      ApiClient(
        basePath: 'http://localhost:1000',
      ),
    ).assetsSnapshot(transferables: true);

    List<Asset> assetsList = assets?.iterable ?? [];
    String? assetString = assetsList
        .firstWhere(
          (asset) => asset.original.reference?.fragment?.string?.raw != null,
          // orElse: () => null,
        )
        ?.original
        .reference
        ?.fragment
        ?.string
        ?.raw;

    if (assetString != null) {
      await FlutterClipboard.copy('${assetsList.toList().elementAt(assetsList.length)}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Copied to Clipboard',
            // style: TitleText(),
          ),
          backgroundColor: Colors.black,
          duration: const Duration(milliseconds: 1030),
        ),
      );
    }
  }

  Future<void> _copyImageToClipboard(Uint8List imageData, BuildContext context) async {
    await FlutterClipboard.writeImage(imageData);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(
          'Copied image to Clipboard',
          // style: TitleText(),
        ),
        backgroundColor: Colors.white,
        duration: const Duration(milliseconds: 1030),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        if (rawString != null) {
          await _copyCodeToClipboard(context);
        } else if (uint8list != null) {
          await _copyImageToClipboard(uint8list!, context);
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
        side: MaterialStateProperty.all(BorderSide(color: Colors.grey, width: 1.0)),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0))),
        overlayColor: MaterialStateProperty.all(Colors.black12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(
            Icons.copy_outlined,
            color: Colors.black,
            size: 12,
          ),
          SizedBox(width: 4),
          Text(
            'copy',
            style: TextStyle(color: Colors.black, fontSize: 10),
          ),
        ],
      ),
    );
  }
}

class FlutterClipboard {
  static Future<void> copy(String text) async {
    await Clipboard.setData(
      ClipboardData(
        text: text,
      ),
    );
  }

  static Future<void> writeImage(Uint8List imageData) async {
    await Clipboard.setData(
      ClipboardData(
        text: 'data:image/png;base64,' + base64.encode(imageData.toList()),
      ),
    );
  }
}
