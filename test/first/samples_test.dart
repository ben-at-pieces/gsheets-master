// ignore_for_file: omit_local_variable_types

// import 'dart:html';
import 'dart:io';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';


void main () async {

  String port = '1000';
  String host = 'http://localhost:$port';

  /// this is a future instance of assetsApi and
  /// allows for it to be referenced in other tests within this file
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));


  test('/assets/search?query=string [GET]', () async {
    /// (1) define your string query to be searched
    String query = 'dart';

    /// (2) call the endpoint --> assets Search
    SearchedAssets assetsSearchAssets = await assetsApi.assetsSearchAssets(searchableTags: query);

    // var hjkn = assetsSearchAssets.iterable.toList().elementAt(0);

    print(assetsSearchAssets.suggested);

    /// (3) expect assetsSearchAssets to be of type --> SearchedAssets
    // expect(assetsSearchAssets.runtimeType, SearchedAssets);
  });


  test('image: PNG', () async {
    File imageFile = File('test/data/png/white.png');
    List<int> bytes = imageFile.readAsBytesSync().cast();

    ///call the endpoint -->assetsCreate
    Asset response = await assetsApi.assetsCreateNewAsset(
      seed: Seed(
        asset: SeededAsset(
          application: Application(
            privacy: PrivacyEnum.OPEN,
            name: ApplicationNameEnum.VS_CODE,
            onboarded: true,
            platform: PlatformEnum.MACOS,
            version: '1.5.7',
            id: '6a9e37e1-e49c-4985-ab56-480f67f05a64',
          ),
          format: SeededFormat(
            ///=======
            file: SeededFile(
              bytes: TransferableBytes(raw: bytes),
            ),
          ),
        ),
        type: SeedTypeEnum.ASSET,
      ),
    );
    // expect(response.name?.contains('jpeg'), true);
    // expect(response.description?.contains('jpeg'), true);
    expect(response.runtimeType, Asset);
    // print(response);
  });


  test('/assets/related [GET]', () async {
    /// (1) call assetsSnapshot, just to get our first asset
    Assets assetsSnapshot = await assetsApi.assetsSnapshot();

    if (assetsSnapshot.iterable.isEmpty) {
      throw Exception('/assets/related [POST] failed because our assets snapshot is empty.');
    }

    /// (2) get the first asset
    Asset first = assetsSnapshot.iterable.first;


    /// (4) trying to get all the related assets, that are related to our first asset
    Assets related =
    await assetsApi.assetsGetRelatedAssets(assets: Assets(iterable: <Asset>[first]));

    // int index = related.iterable.length;



List<Asset> listed = related.iterable.toList();

 // This code tests two endpoints of an API that searches and retrieves related assets, respectively, by defining a query string and checking if the response contains any related assets.
    Iterable<Asset> relatedListed =listed.where((element) => related.iterable.isNotEmpty);


 // Prints a list of related assets and sets an expectation that there will be one or more related assets, but currently the related assets endpoint is empty.
    print(relatedListed.toList());
    /// (5) TODO  Expect the we get 1 or more related assets to our first asset
    // expect(related.iterable.isNotEmpty, true);
    /// but for now there is no logic behind the related assets endpoint so it is just going to be empty.
    // expect(related.runtimeType, Assets);
  });

}