import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the relationships api.
/// routes:
/// '/relationships [GET]'
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final RelationshipsApi relationshipsApi = RelationshipsApi(ApiClient(basePath: host));

  /// TODO check our edge cases (empty)
  test('/relationships [GET]', () async {
    /// (1) call /relationships endpoint
    Relationships relationships = await relationshipsApi.relationshipsSnapshot();

    /// TODO beef up our expect statement. to ensure valid data.
    /// expect RuntimeType: Relationships
    expect(relationships.runtimeType, Relationships);
  });
}
