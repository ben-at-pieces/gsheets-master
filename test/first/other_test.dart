// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart' hide Theme;
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final port = '1000';
  final host = 'http://localhost:$port';
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  AssetApi assetApi = AssetApi(ApiClient(basePath: host));

  test('update an Asset description', () async {
    /// (1) lets get our assets
    Assets assets = await assetsApi.assetsSnapshot();

    /// (2) get the first one

    Asset first = assets.iterable.first;
    // print('init Success');
    String initialName = first.name ?? 'no name.';
    first.name = 'Newly added Asset Name!';

    print('$assets');

    /// send a modification
    final Asset response = await assetApi.assetUpdate(asset: first);
    // print('result: $response id: ${response.id}');
    expect(initialName != response.description, isTrue);
  });

  test('update an Asset description', () async {
    /// (1) lets get our assets
    final initialResponse = await assetsApi.assetsSnapshot();

    /// (2) get the first one

    Asset dbAsset = initialResponse.iterable.first;
    // print('init Success');
    String initialDescription = dbAsset.description ?? 'no description.';
    dbAsset.description = 'Newly added Asset description!';

    print('$initialResponse');

    /// send a modification
    final Asset response = await assetApi.assetUpdate(asset: dbAsset);
    // print('result: $response id: ${response.id}');
    expect(initialDescription != response.description, isTrue);
  });
}
