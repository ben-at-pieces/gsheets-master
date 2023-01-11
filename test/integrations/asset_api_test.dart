import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runtime_common_library/model/export_type_enum.dart';

void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  final AssetApi assetApi = AssetApi(ApiClient(basePath: host));

  ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /asset/{asset} POST  v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

  test('/asset/{asset}', () async {
    /// (1) call /assets endpoint
    Assets assets = await assetsApi.assetsSnapshot(transferables: false);

    ///(2) get the first asset
    Asset firstAsset = assets.iterable.first;

    /// (3) call SpecificAssetsSnapshot
    Asset specificAssetSnapshot = await assetApi.assetSnapshot(firstAsset.id);

    /// (4) optional print
    // print(specificAssetSnapshot);

    /// expect RuntimeType: Asset
    expect(specificAssetSnapshot.runtimeType, Asset);
  });

  ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /asset/update POST  v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
  /// TODO for the future go super deep on updating and check all properties that they are truely updated.
  test('/asset/update POST', () async {
    /// (1) call assetsSnapshot
    Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

    /// (2) get the first asset
    Asset firstAsset = assetsSnapshot.iterable.first;

    /// (3) give your first asset a relevant name, so that it is reflected within our db
    firstAsset.name = 'testing name update';

    /// (4) call the endpoint /asset/update POST
    Asset assetUpdate = await assetApi.assetUpdate(asset: firstAsset);

    // print('/asset/update POST: ${assetUpdate}');
    /// expect RuntimeType: AssetUpdate
    expect(assetUpdate.runtimeType, Asset);
  });

  ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Reclassify POST    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
  /// TODO in the future check all different iterations of a language
  /// as well as text -> code and vise versa.
  test('/asset/reclassify POST', () async {
    /// (1) lets get our assets
    Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

    /// (2) get the first asset
    Asset asset = assetsSnapshot.iterable.first;

    /// (3) call the endpoint (AssetReclassification)
    Asset assetReclassification = await assetApi.assetReclassify(
        assetReclassification: AssetReclassification(ext: ClassificationSpecificEnum.dart, asset: asset));

    // print('/asset/update POST: ${assetReclassify}');

    /// expect RuntimeType: Asset
    expect(assetReclassification.runtimeType, Asset);
  });

  test('/asset/{asset}/export POST', () async {
    /// (1) lets get our assets
    Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

    /// (2) get the first asset
    Asset asset = assetsSnapshot.iterable.first;

    // not support images just yet...
    // TODO add image support on the server.
    if (asset.original.reference?.classification.generic == ClassificationGenericEnum.IMAGE) {
      throw Exception('/asset/{asset}/export POST, fail because our first asset was an image asset.');
    }

    /// (3) call the endpoint (Asset export)
    ExportedAsset exported = await assetApi.assetSpecificAssetExport(asset.id, ExportTypeEnum.HTML.value);

    try {
      /// This is just here to see if we have a syntax highlighted format already.
      Format exists = asset.formats.iterable
          .firstWhere((Format _format) => _format.classification.rendering == ClassificationRenderingEnum.HTML);
      print(exists.id);
    } catch (error) {
      /// ignore because we are do this just for testing.
    }
    // print(exported.raw.string?.raw);

    /// expect that we have our highlighted format.
    expect(exported.raw.string?.raw?.isNotEmpty ?? false, true);
  });

  test('/asset/{asset}/export POST for MD', () async {
    /// (1) lets get our assets
    Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

    /// (2) get the first asset
    Asset asset = assetsSnapshot.iterable.first;

    // not support images just yet...
    // TODO add image support on the server.
    if (asset.original.reference?.classification.generic == ClassificationGenericEnum.IMAGE) {
      throw Exception('/asset/{asset}/export POST, fail because our first asset was an image asset.');
    }

    /// (3) call the endpoint (Asset export)
    ExportedAsset exported = await assetApi.assetSpecificAssetExport(asset.id, ExportTypeEnum.MD.value);

    print(exported.raw.string?.raw);

    /// expect that we have our highlighted format.
    expect(exported.raw.string?.raw?.isNotEmpty ?? false, true);
  });
}

/// (1) aggregate a list of endpoints from the documentation
///
/// AssetApi  ^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
///
/// [asset/{asset} [GET]
/// [asset/update [POST]
/// [asset/reclassify [POST]

/// NOT ACTIVE ============================================================
/// [asset/{asset}/formats [GET]  <- shown in stoplight  (not active)
/// [asset/usage/rename [POST]  <- mismatch in stoplight  (not active)

/// AssetsApi  ^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
///
/// assets [GET]
/// assets/{asset} [GET]
/// assets/create [POST]
/// assets/{asset}/delete [POST]
/// assets/related [GET]
/// assets/search?query=string [GET]
///

/// NOT ACTIVE ============================================================
/// assets/usage/create [POST]      <- shown in stoplight  (not active)
/// GET assets/usage/delete [POST]  <- mismatch in stoplight  (not active)
/// GET assets/usage/search [POST]  <- shown in stoplight  (not active)
/// assets/{asset}/formats          <- shown in stoplight  (not active)///
///
///
///
/// (3) shell out all the endpoint tests within an api.
/// ie.
// test('/asset/assetReclassify POST', () async {
//     ///
//     /// /asset/assetReclassify  Runtime Type -<*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*><*>
//     ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
//     /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
//     /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
//     ///
//   });
// });
/// (4) start to jump in to each one of the tests
///
/// next phase: add the implementation of each test
/// (1) comment out your test
/// (2) fill in your comments
/// (3) test to ensure it is working
/// (4) ask your self (1) am i calling an api
/// (4a) how to check? be your devils advocate here.
/// (4b) click in to the function you are calling that is your api and 2 run os_server on development and verify that the endpoint you are calling is showing up with in the os_server logs.
/// (5) add a simple expect statement
/// (6) add all your todos to make this legendary 100% coverage for the future
/// (7) ask your self is there anything that i am repeating from test to test that i can abstract??
///
///
/// (2) you have 2 options here either at the top our your test declare all the apis you need, so that you dolt have to redeclare them every test(my rec)
///  but if this helps you theres really no difference other than just using best coding practices "if you copy paste the same code thrice then you can likely abstract" (abstract meaning move to a variable, a function a class ETC.)
///
///
///
/// when mark writes code:
/// (1) write what im doing in my note book
/// (2) write my comments first
/// (3) fill out my comments with actual code
/// (3a) test
/// (4) evaluate && consolidate
/// (5) clean and test && repeat.
