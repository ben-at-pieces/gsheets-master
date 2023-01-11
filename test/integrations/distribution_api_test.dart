import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the distributions api.
/// routes:
/// '/distribution [GET]'
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final DistributionsApi distributionsApi = DistributionsApi(ApiClient(basePath: host));
  final DistributionApi distributionApi = DistributionApi(ApiClient(basePath: host));

  test('/distribution/{distribution} [GET]', () async {
    /// (1) call our snapshot to get a single uuid of a distribution to retrieve.
    Distributions snapshot = await distributionsApi.distributionsSnapshot();

    if (snapshot.iterable.isEmpty) {
      throw Exception('We cannot test /distribution/{distribution} [GET] because our distributions snapshot is empty');
    }

    /// (2) call our specific distribution snapshot.
    Distribution distribution =
        await distributionApi.distributionsSpecificDistributionSnapshot(snapshot.iterable.first.id);

    /// TODO beef up our expect statement. to ensure valid data.
    /// expect RuntimeType: Distribution
    expect(distribution.runtimeType, Distribution);
  });

  test('/distribution/update [POST]', () async {
    /// (1) call our snapshot to get a single uuid of a distribution to retrieve.
    Distributions snapshot = await distributionsApi.distributionsSnapshot();

    if (snapshot.iterable.isEmpty) {
      throw Exception('We cannot test /distribution/update [POST] because our distributions snapshot is empty');
    }

    /// (2) get our first distribution and update is updated timestamp.
    Distribution distribution = snapshot.iterable.first;

    /// (3) update our distribution.
    distribution.updated.value = DateTime.now();
    distribution = await distributionApi.distributionUpdate(distribution: distribution);

    /// TODO beef up our expect statement. to ensure valid data. && a true update.
    expect(distribution.runtimeType, Distribution);
  });
}
