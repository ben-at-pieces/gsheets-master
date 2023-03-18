// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart' hide Theme;
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

Future<void> main() async {
  final port = '1000';
  final host = 'http://localhost:$port';
  final api = AssetsApi(ApiClient(basePath: host));
  final assetApi = AssetApi(ApiClient(basePath: host));

  test('Person creation with missing required fields fails', () async {
    final String port = '1000';
    final String host = 'http://localhost:$port';
    final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
    final PersonsApi personsApi = PersonsApi(ApiClient(basePath: host));

    // Get the ID of an existing asset
    final String assetId = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

    // Try to create a person with missing required fields
    final SeededPerson seededPerson = SeededPerson(
      access: PersonAccess(),
      type: PersonType(basic: PersonBasicType(username: '@mark')), // <-- Missing required fields
      asset: assetId,
      mechanism: MechanismEnum.MANUAL,
    );

    // Verify that the person creation fails with an exception
    expect(() => personsApi.personsCreateNewPerson(seededPerson: seededPerson), throwsA(isA<ApiException>()));
  });

}
