import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter_test/flutter_test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the distributions api.
/// routes:
/// '/distributions [GET]'
///
/// DO NOT implement the create && the delete.
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final DistributionsApi distributionsApi = DistributionsApi(ApiClient(basePath: host));

  /// TODO check our edge cases (empty)
  test('/distributions [GET]', () async {
    /// (1) call /distributions endpoint
    Distributions snapshot = await distributionsApi.distributionsSnapshot();

    /// TODO beef up our expect statement. to ensure valid data.
    /// expect RuntimeType: Distributions
    expect(snapshot.runtimeType, Distributions);
  });
}
