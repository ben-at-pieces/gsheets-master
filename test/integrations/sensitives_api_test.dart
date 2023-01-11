import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the sensitives api.
/// routes:
/// '/sensitives/create [POST]'
/// '/sensitives [GET]'
/// '/sensitives/{sensitive}/delete [POST]'
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final SensitivesApi sensitivesApi = SensitivesApi(ApiClient(basePath: host));
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

  /// TODO check our edge cases what if an asset isn't present??
  test('/sensitives/create [POST]', () async {
    /// (1) get the asset we are going to create a sensitive on.
    String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

    /// (2) create our sensitive.
    Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
      seededSensitive: SeededSensitive(
        asset: asset,
        text: 'hello here is some sensitive information',
        category: SensitiveCategoryEnum.API_KEY,
        severity: SensitiveSeverityEnum.HIGH,
        name: 'stripe key',
        description: 'this is the key used for stripe.',
      ),
    );

    /// expect
    /// TODO check all our properties are present.
    expect(created.runtimeType, Sensitive);
  });

  /// TODO check our edge cases (empty)
  test('/sensitives [GET]', () async {
    /// (1) call /sensitives endpoint
    Sensitives sensitives = await sensitivesApi.sensitivesSnapshot();

    /// expect RuntimeType: Asset
    expect(sensitives.runtimeType, Sensitives);
  });

  /// TODO check dedge cases if the sensitive doesnt exist.
  test('/sensitives/{sensitive}/delete [POST]', () async {
    /// (1) call /sensitives endpoint
    Sensitives sensitives = await sensitivesApi.sensitivesSnapshot();

    if (sensitives.iterable.isEmpty) {
      throw Exception(
        '/sensitives/{sensitive}/delete [POST] FAILED, b/c our iterable is empty and cannot truely test our test.',
      );
    }

    /// (2) delete the first sensitive we have.
    await sensitivesApi.sensitivesDeleteSensitive(sensitives.iterable.first.id);
  });
}
