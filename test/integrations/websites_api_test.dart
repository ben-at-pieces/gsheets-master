import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// websites
/// /websites [GET]
/// /websites/create [POST]
/// /websites/{website}/delete [POST]
/// This is a specific model for related websites to an asset.

void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  WebsitesApi websitesApi = WebsitesApi(ApiClient(basePath: host));
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

  group('WebsitesApi Group', () {
    /// TODO test against an empty website snapshot
    /// TODO when calling websites snapshot we will return the count of all urls in our db (for reference later)
    test('/websites [GET]', () async {
      /// (1) call /websites
      Websites websites = await websitesApi.websitesSnapshot();

      /// (2) optional print
      // print(websites.runtimeType);

      /// (3) expect RuntimeType: Asset
      expect(websites.runtimeType, Websites);
    });

    /// TODO we will then expect the url count to be +1 from the original count since we will be deleting 1 url as a part of our testing of websites/{website}/delete [POST]
    /// TODO expect the website url to be present after its creation
    test('/websites/create[GET]', () async {
      /// (1) call assets Snapshot
      Assets assets = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset first = assets.iterable.first;

      /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
      Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
          seededWebsite: SeededWebsite(
        asset: first.id,
        url: 'www.pieces.app',
        name: first.name.toString(),
      ));

      /// (4) expect /websites/create [GET] to be of type Website
      expect(websitesCreate.runtimeType, Website);

      /// (5) expect website url to not be empty
      expect(websitesCreate.url.isNotEmpty, true);
    });

    test('/websites/{website}/delete [POST]', () async {
      /// (1) call /websites
      Websites websites = await websitesApi.websitesSnapshot();

      /// (2) if our website snapshot is empty we will throw an error
      if (websites.iterable.isEmpty) {
        throw Exception('/websites/{website}/delete [POST] failed because your website snapshot is empty');
      }

      /// (2)
      Website first = websites.iterable.first;

      /// (3)
      String delete = first.id;

      /// (4) optional print
      await websitesApi.websitesDeleteSpecificWebsite(delete);

      /// TODO get a snapshot of the websites and ensuring that the ID we deleted is no longer within the asset!
      /// TODO we will then expect the url count to return to the original url count because we deleted the created tag
      /// (4) expect /websites/delete [POST] to be of type WebsitesApi
      expect(websitesApi.runtimeType, WebsitesApi);
    });
  });
}
