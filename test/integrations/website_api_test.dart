import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// /website/update [POST]
/// /website/{website} [GET]
/// TODO enhance our expects and update here to check all individual properties.

void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  WebsiteApi websiteApi = WebsiteApi(ApiClient(basePath: host));
  WebsitesApi websitesApi = WebsitesApi(ApiClient(basePath: host));

  group('WebsiteApi Group', () {
    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /website/{website} [GET] v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/website/{website} [GET]', () async {
      /// (1) call /websites snapshot
      Websites websites = await websitesApi.websitesSnapshot();

      /// (2) get the first website from your websitesSnapshot
      Website first = websites.iterable.first;

      /// (3) get the first website ID -->string
      String website = first.id;

      /// (4) call the endpoint --> SpecificWebsiteSnapshot
      Website websiteSnapshot = await websiteApi.websitesSpecificWebsiteSnapshot(website);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /website/update [POST] v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/website/update [POST]', () async {
      /// (1) call /websites
      Websites websites = await websitesApi.websitesSnapshot();

      if (websites.iterable.isEmpty) {
        throw Exception('/website/update [POST] failed because our websites snapshot is empty.');
      }

      /// (2) get the first asset
      Website first = websites.iterable.first;

      /// (3) map the original website to json
      Map<String, dynamic> old = first.toJson();

      /// (4) define the url that your website will be updated to
      first.url = 'www.pieces.app';

      /// (5) call websiteUpdate
      Website updated = await websiteApi.websiteUpdate(website: first);

      /// expect that the old and the updated website are both different.
      expect(updated.toJson() != old, true);
    });
  });
}
