// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api_client.dart';

String host = 'http://localhost:1000';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));

class BatchCount {}

Future batchFile() async {
  /// (2) snapshot
  final assetsSnapshot = await assetsApi.assetsSnapshot();

  List<Asset> assetCount = assetsSnapshot.iterable;

  /// c
  List<Asset> filterBatchFile = assetCount
      .where((element) =>
          element.original.reference?.classification.specific == ClassificationSpecificEnum.bat)
      .toList();

  var languageLength = filterBatchFile.length;
  List<double> Doubles = [languageLength.toDouble()];
  print(Doubles);
  print(Doubles);
  if (languageLength != 0) ;
  return Doubles.elementAt(0);
}
