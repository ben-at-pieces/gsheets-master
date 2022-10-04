// ignore_for_file: omit_local_variable_types

/// =========================
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:gsheets/create/create_function.dart';
import 'package:gsheets/init/src/gsheets.dart';
import 'package:test/test.dart' hide Tags;
import 'package:test/test.dart';

final port = '1000';
final host = 'http://localhost:$port';

void main() async {
  group('first asset', () {
    ///
    test('metadata', () async {
      final ssheet = await gsheets.spreadsheet(spreadsheetID);

      /// (gsheet)
      Worksheet? ws = await ssheet.worksheetByTitle('tests');
      Worksheet? ws1 = await ssheet.worksheetByTitle('batchfile');

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
          ],
          fromColumn: 1);

      ///batchfile
      List<Asset> filterBatchfile = assetCount
          .where((element) =>
              element.original.reference?.classification.specific == ClassificationSpecificEnum.bat)
          .toList();

      var languageLength = filterBatchfile.length;

      if (languageLength == 0) ;
      {
        await ws1?.values.insertColumn(1, ['Total: ${filterBatchfile.length}'], fromRow: 1);
        if (languageLength != 0) {
          await ws1?.values.insertColumn(1, ['Total: $languageLength'], fromRow: 1);
        }

        // print(languageLength);

        /// ===============================================================================

        if (filterBatchfile.isEmpty) {
          await ws?.values.insertColumn(
              3,
              [
                '0',
              ],
              fromRow: 4);
        } else if (filterBatchfile.isNotEmpty) {
          await ws?.values.insertColumn(
              3,
              [
                '${filterBatchfile.first.original.reference?.fragment?.string?.raw}',
              ],
              fromRow: 3);
          await ws1?.values.insertColumn(
              3, ['${filterBatchfile.first.original.reference?.fragment?.string?.raw}'],
              fromRow: 4);
        }
        bool? discovered = filterBatchfile.first.formats.asset.discovered;
        await ws1?.values.insertColumn(1, ['$discovered'], fromRow: 4);

        String? name = filterBatchfile.first.name;
        await ws1?.values.insertColumn(2, ['$name'], fromRow: 4);

        String? description = filterBatchfile.first.description;
        await ws1?.values.insertColumn(4, ['$description'], fromRow: 4);

        String? classification =
            filterBatchfile.first.original.reference?.classification.specific.value;
        await ws1?.values.insertColumn(5, ['$classification'], fromRow: 4);

        String? tag = filterBatchfile.first.tags?.iterable.first.text;
        await ws1?.values.insertColumn(6, ['$tag'], fromRow: 4);

        String? url = filterBatchfile.first.websites?.iterable.first.url;
        await ws1?.values.insertColumn(7, ['$url'], fromRow: 4);

        String? person = filterBatchfile.first.persons?.iterable.first.type.platform?.name;
        await ws1?.values.insertColumn(8, ['$person'], fromRow: 4);
      }
    });
  });
}
// test('.text', () async {});
// test('.yaml', () async {});
// test('.cmake', () async {});
