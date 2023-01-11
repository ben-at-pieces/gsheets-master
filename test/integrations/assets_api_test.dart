import 'package:collection/collection.dart';
import 'package:connector_openapi/api.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// /assets [GET]
/// /assets/{asset} [GET]
/// /assets/create] [POST]
/// /assets/{asset}/delete [POST]
/// /assets/related [GET]
/// /assets/search?query=string [GET]
/// TODO standardize db between all tests

Future<void> main() async {
  String port = '1000';
  String host = 'http://localhost:$port';

  /// this is a future instance of assetsApi and
  /// allows for it to be referenced in other tests within this file
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

  group('AssetsApi Group', () {
    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /assets [GET]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/assets [GET]', () async {
      /// (1) call assetsSnapshot
      Assets assetsSnapshot = await assetsApi.assetsSnapshot();

      /// (2) expect assetsSnapshot to return a type --> Assets
      ///  TODO when using a standardized db we will update this expect to reflect the size that we are actually expecting
      ///  TODO modify transferrables to reflect true and false (verify that users are getting what they expect)
      expect(assetsSnapshot.runtimeType, Assets);
    });

    test('/assets [GET] with suggested true', () async {
      /// (1) call assetsSnapshot
      Assets _assets = await assetsApi.assetsSnapshot(suggested: true, transferables: false);

      print('results: ${_assets.iterable.length}');

      /// (2) expect assetsSnapshot to return a type --> Assets
      expect(_assets.runtimeType, Assets);

      /// (3) expect that the # of results from transferables false and transferables true is the exact same.
      expect(
        const ListEquality().equals(
            (await assetsApi.assetsSnapshot(suggested: true)).iterable.map((Asset _asset) => _asset.id).toList(),
            _assets.iterable
                .map(
                  (Asset _asset) => _asset.id,
                )
                .toList()),
        true,
      );
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /assets/related [GET]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    /// Goal: is to get all the related assets with in our database that are related to the first asset wihtin our db:)
    test('/assets/related [GET]', () async {
      /// (1) call assetsSnapshot, just to get our first asset
      Assets assetsSnapshot = await assetsApi.assetsSnapshot();

      if (assetsSnapshot.iterable.isEmpty) {
        throw Exception('/assets/related [POST] failed because our assets snapshot is empty.');
      }

      /// (2) get the first asset
      Asset first = assetsSnapshot.iterable.first;

      /// (4) trying to get all the related assets, that are related to our first asset
      Assets related = await assetsApi.assetsGetRelatedAssets(assets: Assets(iterable: <Asset>[first]));

      /// (5) TODO  Expect the we get 1 or more related assets to our first asset
      // expect(related.iterable.isNotEmpty, true);
      /// but for now there is no logic behind the related assets endpoint so it is just going to be empty.
      expect(related.runtimeType, Assets);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /assets/{asset} [GET]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/assets/{asset} [GET]', () async {
      /// (1) call assetsSnapshot
      Assets assetsSnapshot = await assetsApi.assetsSnapshot();

      /// (2) get the first Asset from the AssetsSnapshot
      Asset asset = assetsSnapshot.iterable.first;

      /// (3) call the endpoint assetsSpecificSnapshot
      Asset assetsSpecificSnapshot = await assetsApi.assetsSpecificAssetSnapshot(asset.id);

      /// (4) expect assetsSpecificSnapshot to be of type --> Asset
      expect(assetsSpecificSnapshot.runtimeType, Asset);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^  /assets/search?query=string [GET]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    /// TODO look for different search queries ie empty quotes as well as super long queries
    /// as well as unique characters like emojis or other thing.(edge cases)

    test('/assets/search?query=string [GET]', () async {
      /// (1) define your string query to be searched
      String query = 'dart';

      /// (2) call the endpoint --> assets Search
      SearchedAssets assetsSearchAssets = await assetsApi.assetsSearchAssets(query: query);

      /// (3) expect assetsSearchAssets to be of type --> SearchedAssets
      expect(assetsSearchAssets.runtimeType, SearchedAssets);
    });

    test('/assets/search?searchable_tags=string [GET]', () async {
      /// (1) define your string query to be searched
      String searchableTags = 'dart, html';

      /// (2) call the endpoint --> assets Search
      SearchedAssets assetsSearchAssets = await assetsApi.assetsSearchAssets(searchableTags: searchableTags);

      /// (3) expect assetsSearchAssets to be of type --> SearchedAssets
      expect(assetsSearchAssets.runtimeType, SearchedAssets);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^    /assets/asset/delete [POST]     v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    /// TODO test your edge case(empty, a uuid that does exist)
    test('/assets/asset/delete [POST]', () async {
      /// (1) call assetsSnapshot
      Asset firstAsset = (await assetsApi.assetsSnapshot()).iterable.first;

      /// (2) define your first asset ID (string) from your assets snapshot
      String deleted = await assetsApi.assetsDeleteAsset(firstAsset.id);

      /// (3) expect deleted to be of type --> String
      expect(deleted.runtimeType, String);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^    /assets/create [POST]     v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    /// TODO for this test different cases here
    /// images, text, code, different languages, different parameters within the metadata(tags, websites, classifications))
    ///
    test('/assets/create [POST]', () async {
      /// (1) register or get an application first
      final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

      /// (2) get your application
      Application application = (await connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.VS_CODE,
            platform: PlatformEnum.MACOS,
            version: '1.5.8',
          ),
        ),
      ))
          .application;
      // print('application?? ${application}');

      /// (3) call the endpoint --> assetsCreateNewAsset
      Asset created = await assetsApi.assetsCreateNewAsset(
        seed: Seed(
          asset: SeededAsset(
              application: application,
              format: SeededFormat(
                fragment: SeededFragment(
                  string: TransferableString(
                    raw: ' new snippet Added via assetsCreateNewAsset ',
                  ),
                ),
              )),
          type: SeedTypeEnum.ASSET,
        ),
      );
      // print('created: ${created.original.reference?.application}');

      /// TODO for when this PR merges to main
      // expect(response.name?.contains('jpeg'), true);
      // expect(response.description?.contains('jpeg'), true);
      expect(created.runtimeType, Asset);
      // print(response);
    });
  });

  test('/assets/draft [POST]', () async {
    /// (1) register or get an application first
    final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

    /// (2) get your application
    Application application = (await connectorApi.connect(
      seededConnectorConnection: SeededConnectorConnection(
        application: SeededTrackedApplication(
          name: ApplicationNameEnum.VS_CODE,
          platform: PlatformEnum.MACOS,
          version: '1.5.8',
        ),
      ),
    ))
        .application;

    Seed seed = Seed(
      asset: SeededAsset(
          application: application,
          format: SeededFormat(
            fragment: SeededFragment(
              string: TransferableString(
                raw: ' new snippet Added via assetsCreateNewAsset ',
              ),
            ),
          )),
      type: SeedTypeEnum.ASSET,
    );

    Seed output = await assetsApi.assetsDraft(seed: seed);

    expect(output.runtimeType, Seed);
  });
}

/// Documentation upgrades??
///
/// ENDPOINTS THAT I WILL TEST IN MORE DEPTH AFTER PR MERGE
// /assets [GET]
// /assets/{asset} [GET]
// /assets/create [POST]
// /assets/{asset}/delete [POST]
// /assets/related [GET]
// /assets/search?query=string [GET]

/// ! Note: on  when calling create from the core, the application allows any string to be passed in
/// Mark made the adjustment and the test reflects Marks implementation of the connectorApi

//
//
/// notes:
// /// - triple '/'

///ENDPOINTS NO LONGER IN USE
///  /assets/usage/create [POST]
///  /assets/usage/delete [POST]
///  /assets/usage/search [POST]
///  /assets/{asset}/formats [GET]

/// from /assets [GET]
/// TODO check the total number of assets returned
/// TODO check that the first asset and last are different
/// TODO check snapshot against an empty db
///
/// from /assets/related [GET]
/// TODO verbiage is confusing
///
/// Tsavo Knott
/// This test is also a bit confusing as we are saying “give me all assets”
/// and then saying “give me related assets that are related to all assets”
///
/// from /assets/{asset} [GET]
/// TODO elaborate more on the specific expected outcome
/// TODO want to expand on testing this endpoint -->
/// check against asset ID
/// check against asset name
/// check against asset description
