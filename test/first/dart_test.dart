// ignore_for_file: omit_local_variable_types

/// =========================
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:flutter_test/flutter_test.dart';
import 'package:testing/create/create_function.dart'hide assetsApi;
import 'package:testing/init/src/gsheets.dart';

import '../connect.dart';

final port = '1000';
final host = 'http://localhost:$port';

void main() async {
  group('first asset', () {
    ///
    test('metadata', () async {
      final ssheet = await gsheets.spreadsheet(spreadsheetID);

      /// (gsheet)
      Worksheet? ws = await ssheet.worksheetByTitle('tests');
      Worksheet? ws1 = await ssheet.worksheetByTitle('DART');

      /// (2) snapshot
      final assetsSnapshot = await assetsApi.assetsSnapshot();

      List<Asset> assetCount = assetsSnapshot.iterable;

      await ws1?.values.insertRow(
          3,
          [
            'DISCOVERED',
            'NAME',
            'SNIPPET',
            'DESCRIPTION',
            'LANGUAGE',
            'TAG(S)',
            'URLS',
          ],
          fromColumn: 1);

      ///batchfile
      List<Asset> filterDart = assetCount
          .where((element) =>
              element.original.reference?.classification.specific ==
              ClassificationSpecificEnum.dart)
          .toList();

      var languageLength = filterDart.length.toDouble();
      print(languageLength);

      if (languageLength == 0) ;
      {
        await ws1?.values.insertColumn(1, ['Total: ${filterDart.length}'], fromRow: 1);
        if (languageLength != 0) {
          await ws1?.values.insertColumn(1, ['Total: $languageLength'], fromRow: 1);
        }

        // print(languageLength);

        /// ===============================================================================

        if (filterDart.isEmpty) {
          await ws?.values.insertColumn(
              3,
              [
                '0',
              ],
              fromRow: 4);
        } else if (filterDart.isNotEmpty) {
          await ws?.values.insertColumn(
              3,
              [
                '${filterDart.first.original.reference?.fragment?.string?.raw}',
              ],
              fromRow: 3);
          await ws1?.values.insertColumn(
              3, ['${filterDart.first.original.reference?.fragment?.string?.raw}'],
              fromRow: 4);
        }
        bool? discovered = filterDart.first.formats.asset.discovered;
        await ws1?.values.insertColumn(1, ['$discovered'], fromRow: 4);

        String? name = filterDart.first.name;
        await ws1?.values.insertColumn(2, ['$name'], fromRow: 4);

        String? description = filterDart.first.description;
        await ws1?.values.insertColumn(4, ['$description'], fromRow: 4);

        String? classification = filterDart.first.original.reference?.classification.specific.value;
        await ws1?.values.insertColumn(5, ['$classification'], fromRow: 4);

        String? tag = filterDart.first.tags?.iterable.first.text;
        await ws1?.values.insertColumn(6, ['$tag'], fromRow: 4);

        String? url = filterDart.first.websites?.iterable.first.url;
        await ws1?.values.insertColumn(7, ['$url'], fromRow: 4);

        String? person = filterDart.first.persons?.iterable.first.type.platform?.name;
        await ws1?.values.insertColumn(8, ['$person'], fromRow: 4);
      }
    });
  });
}
// test('.text', () async {});
// test('.yaml', () async {});
// test('.cmake', () async {});
