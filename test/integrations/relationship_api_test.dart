import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the relationship api.
/// routes:
/// '/relationships [GET]'
/// '/relationship/{relationshipId} [GET]'
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final RelationshipsApi relationshipsApi = RelationshipsApi(ApiClient(basePath: host));
  final RelationshipApi relationshipApi = RelationshipApi(ApiClient(basePath: host));

  /// TODO check our edge cases (empty)
  /// TODO check all the various status codes ie 500 && 200
  test('/relationship/{relationship} [GET]', () async {
    /// (1) call /relationships endpoint
    Relationships relationships = await relationshipsApi.relationshipsSnapshot();
    if (relationships.iterable.isNotEmpty) {
      await relationshipApi.relationshipsSpecificRelationshipSnapshot(relationships.iterable.first.id);
    }

    /// TODO beef up our expect statement. to ensure valid data.
    /// expect RuntimeType: Relationships
    expect(relationships.runtimeType, Relationships);
  });
}
