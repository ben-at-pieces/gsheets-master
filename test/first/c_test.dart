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
 // This is a multi-line comment that creates a ASCII art of a repeating pattern of dots and dashes.
  ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
  /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
  ///        `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

  group('first asset', () {
    ///
    ///     ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
    //     /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
    //     ///        `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
    test('metadata', () async {
      final ssheet = await gsheets.spreadsheet(spreadsheetID);

      /// (gsheet)
      Worksheet? ws = await ssheet.worksheetByTitle('tests');
      Worksheet? ws1 = await ssheet.worksheetByTitle('c');

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

      ///c
      List<Asset> filterC = assetCount
          .where((element) =>
              element.original.reference?.classification.specific == ClassificationSpecificEnum.c)
          .toList();

      var languageLength = filterC.length;

      if (languageLength == 0) ;
      {
        await ws1?.values.insertColumn(1, ['Total: ${filterC.length}'], fromRow: 1);
        if (languageLength != 0) {
          await ws1?.values.insertColumn(1, ['Total: $languageLength'], fromRow: 1);
        }

        // print(languageLength);

        /// ===============================================================================

        if (filterC.isEmpty) {
          await ws?.values.insertColumn(
              3,
              [
                '0',
              ],
              fromRow: 4);
        } else if (filterC.isNotEmpty) {
          await ws?.values.insertColumn(
              3,
              [
                '${filterC.first.original.reference?.fragment?.string?.raw}',
              ],
              fromRow: 3);
          await ws1?.values.insertColumn(
              3, ['${filterC.first.original.reference?.fragment?.string?.raw}'],
              fromRow: 4);
        }
        bool? discovered = filterC.first.formats.asset.discovered;
        await ws1?.values.insertColumn(1, ['$discovered'], fromRow: 4);

        String? name = filterC.first.name;
        await ws1?.values.insertColumn(2, ['$name'], fromRow: 4);

        String? description = filterC.first.description;
        await ws1?.values.insertColumn(4, ['$description'], fromRow: 4);

        String? classification = filterC.first.original.reference?.classification.specific.value;
        await ws1?.values.insertColumn(5, ['$classification'], fromRow: 4);

        String? tag = filterC.first.tags?.iterable.first.text;
        await ws1?.values.insertColumn(6, ['$tag'], fromRow: 4);

        String? url = filterC.first.websites?.iterable.first.url;
        await ws1?.values.insertColumn(7, ['$url'], fromRow: 4);

        String? person = filterC.first.persons?.iterable.first.type.platform?.name;
        await ws1?.values.insertColumn(8, ['$person'], fromRow: 4);
      }
    });
  });
}
// test('.text', () async {});
// test('.yaml', () async {});
// test('.cmake', () async {});
