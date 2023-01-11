import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the sensitive api.
/// routes:
/// '/sensitive/update [POST]'
/// '/sensitive/{sensitive} [GET]'
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final SensitivesApi sensitivesApi = SensitivesApi(ApiClient(basePath: host));
  final SensitiveApi sensitiveApi = SensitiveApi(ApiClient(basePath: host));

  /// TODO check all the properties we updated are properly updated.
  test('/sensitive/update [POST]', () async {
    /// (1) call our snapshot to get the first asset, so we can update.
    Sensitives sensitives = await sensitivesApi.sensitivesSnapshot();
    if (sensitives.iterable.isEmpty) {
      throw Exception('/sensitive/update [POST] FAILED, b/c our iterable is empty and cannot truely test our test.');
    }

    /// (2) update our first sensitive locally
    Sensitive updated = sensitives.iterable.first;

    /// (3) get our old sensitive and toJson it so we can compare at the end.
    Map<String, dynamic> old = updated.toJson();
    updated.text = 'hello we updated the sensitive';

    /// (4) send over our updated sensitive
    updated = await sensitiveApi.updateSensitive(sensitive: updated);

    /// expect that our old and updated values are different.
    /// TODO add individual checks.
    expect(old != updated.toJson(), true);
  });

  /// TODO edge case testing if it is empty, if it doesnt exist...
  test('/sensitives/{sensitive} [GET]', () async {
    /// (1) call our snapshot
    Sensitives sensitives = await sensitivesApi.sensitivesSnapshot();

    if (sensitives.iterable.isEmpty) {
      throw Exception(
        '/sensitive/{sensitive} [GET] FAILED, b/c our iterable is empty and cannot truely test our test.',
      );
    }

    /// (2) get the first sensitive we have, and all the specific sensitive snapshot api.
    await sensitiveApi.sensitiveSnapshot(sensitives.iterable.first.id);
  });
}
