// // AssetsApi assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));
// // Assets assetsSnapshot = await assetsApi.assetsSnapshot();
// // List<Asset> assetCount = assetsSnapshot.iterable;
//
// // ignore_for_file: omit_local_variable_types
//
// import 'package:core_openapi/api/asset_api.dart';
// import 'package:core_openapi/api/assets_api.dart' hide Tags;
// import 'package:core_openapi/api_client.dart';
//
// /// Recipe #3: I want to get a list of all of my code assets
//
// String host = 'http://localhost:1000';
// AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
// AssetApi assetApi = AssetApi(ApiClient(basePath: host));
//
// class BatchFile {
//   Future<List> getBatchFile() async {
//     try {
//       final assetsSnapshot = await assetsApi.assetsSnapshot();
//       List<Asset> assetCount = assetsSnapshot.iterable;
//     } catch (e) {
//       print('Error connecting to Pieces OS.. $e');
//     }
//
//     List<Asset> filterBatchFile = assetCount
//         .where((element) =>
//             element.original.reference?.classification.specific == ClassificationSpecificEnum.bat)
//         .toList();
//     var batchLength = filterBatchFile.length;
//     // print(filterBatchFile.length);
//     // print(filterC.length);
//   }
// }
//
// // class BatchFile {
// //   Future<int> getZBatAssets() async {
// //     String host = 'http://localhost:1000';
// //     AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
// //     AssetApi assetApi = AssetApi(ApiClient(basePath: host));
// //     final assetsSnapshot = await assetsApi.assetsSnapshot();
// //     List<Asset> assetCount = assetsSnapshot.iterable;
// //     List<Asset> filterBatchFile = assetCount
// //         .where((element) =>
// //             element.original.reference?.classification.specific == ClassificationSpecificEnum.bat)
// //         .toList();
// //     var batchLength = filterBatchFile.length;
// //
// //     return batchLength;
// //     print('$assetsSnapshot ');
// //
// //     try {
// //       List<Asset> assetCount = assetsSnapshot.iterable;
// //       // print('==============================================$assets');
// //     } catch (e) {
// //       // print('Error connecting to Pieces OS.. $e');
// //     }
// //
// //     // return assetsSnapshot;
// //   }
// // }
