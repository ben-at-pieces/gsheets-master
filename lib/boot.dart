// ignore_for_file: omit_local_variable_types

import 'dart:convert';

import 'package:core_openapi/api.dart' hide Theme;
import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api_client.dart';
import 'package:http/http.dart' as http;

/// Recipe #3: I want to get a list of all of my code assets

String host = 'http://localhost:1000';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));

/// The code attempts to connect to a server at localhost:1000 with an application named SUBLIME, version debug, and platform MACOS. It sends a POST request with the application information and prints a success message if the connection is established.
class Boot {
  Future<bool> connect() async {
    print('Trying to connect..');

    String base = 'localhost:1000';

    Map<String, Map<String, String>> application = {
      'application': {'name': 'SUBLIME', 'version': 'debug', 'platform': 'MACOS'}
    };

    Uri url = Uri.http(base, '/connect');

    try {
      http.Response response = await http.post(url, body: json.encode(application));
      dynamic decode = json.decode(response.body);
      print('Successful connection to Pieces OS: ');
      // print(decode);
      // '${decode['application']['id']}');
    } catch (e) {
      print('Error connecting to Pieces OS.. $e');
    }

    return true;
  }

  Future<List> getAssets() async {
    String base = 'localhost:1000';
    Uri url = Uri.http(base, '/assets');
    List assets = [];

    try {
      http.Response response = await http.get(url);
      dynamic decode = json.decode(response.body);
      // print('THIS: ${decode["iterable"]}');

      assets = (decode['iterable'] as List);
      // print('==============================================$assets');
    } catch (e) {
      // print('Error connecting to Pieces OS.. $e');
    }
    final assetsSnapshot = await assetsApi.assetsSnapshot();
    List assetCount = assets;

    int total = assets.length;
    print('successfully acquired ${total} assets:');

    return assets;
  }
}

// Future getFormats() async {
//   String base = 'localhost:1000';
//   Uri url = Uri.http(base, '/formats');
//   List formats = [];
//
//   try {
//     http.Response response = await http.get(url);
//     dynamic decode = json.decode(response.body);
//     print('THIS: ${decode["iterable"]}');
//
//     formats = (decode['iterable'] as List);
//   } catch (err) {
//     print('Your formats error upon call: $err');
//   }
//   print('successfully acquired formats: ${formats}');
//   return formats;
// }
