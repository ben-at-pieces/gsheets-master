// ignore_for_file: omit_local_variable_types

import 'dart:core';

import 'package:core_openapi/api/linkify_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

final port = '1000';
final host = 'http://localhost:$port';

void main() async {
  String host = 'http://localhost:1000';
  LinkifyApi linkifyApi = await LinkifyApi(ApiClient(basePath: host));

  test('distributions', () async {
    Future<Shares> linkify = linkifyApi.linkify();
    print(linkify);
  });
}
