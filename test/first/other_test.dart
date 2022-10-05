// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart' hide Theme;
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final port = '1000';
  final host = 'http://localhost:$port';
  final api = AssetsApi(ApiClient(basePath: host));
  final assetApi = AssetApi(ApiClient(basePath: host));

  test('update an Asset description', () async {
    /// (1) lets get our assets
    final initialResponse = await api.assetsSnapshot();

    /// (2) get the first one

    Asset dbAsset = initialResponse.iterable.first;
    // print('init Success');
    String initialName = dbAsset.name ?? 'no name.';
    dbAsset.name = 'Newly added Asset Name!';

    print('$initialResponse');

    /// send a modification
    final Asset response = await assetApi.assetUpdate(asset: dbAsset);
    // print('result: $response id: ${response.id}');
    expect(initialName != response.description, isTrue);
  });

  test('update an Asset description', () async {
    /// (1) lets get our assets
    final initialResponse = await api.assetsSnapshot();

    /// (2) get the first one

    Asset dbAsset = initialResponse.iterable.first;
    // print('init Success');
    String initialName = dbAsset.description ?? 'no name.';
    dbAsset.description = 'Newly added Asset Name!';

    print('$initialResponse');

    /// send a modification
    final Asset response = await assetApi.assetUpdate(asset: dbAsset);
    // print('result: $response id: ${response.id}');
    expect(initialName != response.description, isTrue);
  });
}
