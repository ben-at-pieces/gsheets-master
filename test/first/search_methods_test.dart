// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart'
    show Asset, Assets, AssetsApi, FlattenedAssets, SearchApi, SearchedAssets;
import 'package:core_openapi/api_client.dart';
import 'package:runtime_common_library/model/searched_asset.dart';
import 'package:runtime_common_library/model/seeded_asset_tag.dart';
import 'package:test/test.dart';

void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

  test('Assets', () async {
    Assets _assets = await assetsApi.assetsSnapshot(suggested: true, transferables: false);

    print(_assets.iterable.toList().length);

    List<Asset> returnedAssets = _assets.iterable;

    // print(returnedAssets.toList());
    List <Asset> listedAssets = returnedAssets.toList();


    // print(listedAssets ?? '');



  });

 // This code searches for assets with a specific query string using an API and expects the result to be of a certain type.
  test('/assets/search?query=string [GET]', () async {
    /// (1) define your string query to be searched
    String query = 'dart';

    /// (2) call the endpoint --> assets Search
    SearchedAssets assetsSearchAssets = await assetsApi.assetsSearchAssets(query: query);

    //shows # of suggested searches
    print(assetsSearchAssets.suggested);
    // print(assetsSearchAssets.iterable.toList());

    List<SearchedAsset> returnedAssets = assetsSearchAssets.iterable.toList() ?? [];

    // print(returnedAssets.length);

    /// (3) expect assetsSearchAssets to be of type --> SearchedAssets
    expect(assetsSearchAssets.runtimeType, SearchedAssets);
  });
}
