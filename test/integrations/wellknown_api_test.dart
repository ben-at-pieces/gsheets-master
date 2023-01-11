import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  WellKnownApi wellKnownApi = WellKnownApi(ApiClient(basePath: host));

  group('/.well-known', () {
    ///.well-known/health [GET]
    test('/.well-known/health [GET]', () async {
      /// await the String and will get well known health of PFD (should return 'ok')
      String health = await wellKnownApi.getWellKnownHealth();

      ///optional print statement
      // print(wellKnownApiSnapshot_health);

      /// expect a String "ok" as a runtime type for well knownApiSnapshot_health
      expect(health == 'ok', true);
    });

    ///.well-known/version [GET]
    test('/.well-known/version [GET]', () async {
      /// await the String Application and get well known version of PFD
      String version = await wellKnownApi.getWellKnownVersion();

      /// optional print statement
      // print(wellKnownApiSnapshot_version);

      /// expect a String i.e."#.#.#" as a runtime type for well wellKnownApiSnapshotVersion
      // i.e."1.6.0"
      /// TODO Ensure this is a valid version &&|| debug, if it is anything else then that is an issue.
      expect(version.runtimeType, String);
    });
  });
}
