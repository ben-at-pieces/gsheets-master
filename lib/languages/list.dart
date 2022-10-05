// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart' hide Theme;
import 'package:core_openapi/api_client.dart';

String host = 'http://localhost:1000';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));
// void main() async {
Future<void> dart() async {
  /// (2) snapshot
  final assetsSnapshot = await assetsApi.assetsSnapshot();

  List<String> collection = [
    'C',
    'C#',
    'CoffeeScript',
    'C++',
    'CSS',
    'Dart',
    'Erlang',
    'Go',
    'Haskell',
    'HTML',
    'Java',
    'JavaScript',
    'json',
    'Lua',
    'Markdown',
    'MatLab',
    'objective C',
    'PHP',
    'Perl',
    'Powershell',
    'Python',
    'R',
    'Ruby',
    'Rust',
    'Scala',
    'Shell',
    'SQL',
    'Swift',
    'TypeScript',
    'TeX',
    'Text',
    'TOML',
    'Yaml',
    'Image',
  ];
  int languageCount = collection.length;
  print(languageCount);

  List<Asset> assetCount = assetsSnapshot.iterable;

  /// batch
  List<Asset> filterBatch = assetCount
      .where((element) =>
          element.original.reference?.classification.specific == ClassificationSpecificEnum.dart)
      .toList();

  /// dart
  List<Asset> filterDart = assetCount
      .where((element) =>
          element.original.reference?.classification.specific == ClassificationSpecificEnum.dart)
      .toList();

  var languageLength = filterDart.length;

  List<dynamic> batch = [
    '${filterBatch.length}',
  ];
  List<dynamic> dart = [
    '${filterDart.length}',
  ];

  List<dynamic> headers = [
    'snippet count:',
    'tag count:',
    'related links:',
  ];

  print(batch.length);
  print(dart.length);

  // List<dynamic> dart = ['$filterDart'];
  //
  // const List<String> languages = [
  //   'Batchfile',
  //   'C',
  //   'C#',
  //   'CoffeeScript',
  //   'C++',
  //   'CSS',
  //   'Dart',
  //   'Erlang',
  //   'Go',
  //   'Haskell',
  //   'HTML',
  //   'Java',
  //   'JavaScript',
  //   'json',
  //   'Lua',
  //   'Markdown',
  //   'MatLab',
  //   'objective C',
  //   'PHP',
  //   'Perl',
  //   'Powershell',
  //   'Python',
  //   'R',
  //   'Ruby',
  //   'Rust',
  //   'Scala',
  //   'Shell',
  //   'SQL',
  //   'Swift',
  //   'TypeScript',
  //   'TeX',
  //   'Text',
  //   'TOML',
  //   'Yaml',
  //   'Image',
  // ];
}
