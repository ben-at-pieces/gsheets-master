import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// /application/update [GET]
/// TODO version bump test

void main() async {
  String port = '1000';
  String host = 'http://localhost:$port';
  ApplicationApi applicationApi = ApplicationApi(ApiClient(basePath: host));
  ApplicationsApi applicationsApi = ApplicationsApi(ApiClient(basePath: host));

  group('ApplicationApi Group', () {
    test('/application/update [GET]', () async {
      Applications applications = await applicationsApi.applicationsSnapshot();

      Application application = applications.iterable.first;

      /// (3) convert the application to json
      Map<String, dynamic> old = application.toJson();

      /// (4) choose the version you'd like to update
      application.version = '3.3.3';

      /// (5) call application update to simulate a simple version bump
      Application updated = await applicationApi.applicationUpdate(application: application);

      /// TODO simulate our next production version bump 4.0.0 --> 4.0.1

      /// (6) expect updated to json is not to equal to the original application
      expect(updated.toJson() != old, true);
    });
  });
}
