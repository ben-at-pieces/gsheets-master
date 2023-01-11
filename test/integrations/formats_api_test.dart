import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';

/// /formats[GET]
/// /formats/{format}[GET]
/// TODO fetch transferable:true,
/// TODO attempt to fetch a format that doesnt exist
/// TODO work with classifications and verify the classification.specific.name.
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  FormatsApi formatsApi = FormatsApi(ApiClient(basePath: host));

  group('FormatsApi Group', () {
    test('/formats [GET]', () async {
      /// (1) initiate FormatsApi

      /// (2) get the formats of all of your assets (returns a list)
      Formats formats = await formatsApi.formatsSnapshot(transferables: false);

      /// (3) Expect Statement
      expect(formats.runtimeType, Formats);
    });

    test('/formats/{format} [GET]', () async {
      /// (1) get the formats of all of your assets (returns a list)
      Formats formats = await formatsApi.formatsSnapshot(transferables: false);

      /// (2) get the first format from your formats list 'formatSnapshot
      Format first = formats.iterable.first;

      /// (3) get the first format ID
      String format = first.id;

      /// (4) use your first format ID in junction with formatsSpecificSnapshot
      Format snapshot = await formatsApi.formatsSpecificFormatSnapshot(format);

      /// (5) Expect formatsSpecific Snapshot to be of type Format
      expect(snapshot.runtimeType, Format);
    });
  });
}
