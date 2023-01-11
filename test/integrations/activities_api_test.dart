import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// activities
/// /activities [GET]
/// /activities/create [POST]
/// /activities/{activity}/delete [POST]
/// This is a specific model for related activities to an asset & format & user and just a simple global event..
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  ActivitiesApi activitiesApi = ActivitiesApi(ApiClient(basePath: host));
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  AssetApi assetApi = AssetApi(ApiClient(basePath: host));
  FormatsApi formatsApi = FormatsApi(ApiClient(basePath: host));
  FormatApi formatApi = FormatApi(ApiClient(basePath: host));
  UsersApi usersApi = UsersApi(ApiClient(basePath: host));
  UserApi userApi = UserApi(ApiClient(basePath: host));
  ApplicationsApi applicationsApi = ApplicationsApi(ApiClient(basePath: host));

  group('ActivitiesApi Group', () {
    /// TODO test against an empty activity snapshot
    /// TODO when calling activities snapshot we will return the count of all urls in our db (for reference later)
    test('/activities [GET]', () async {
      /// (1) call /activities
      Activities activities = await activitiesApi.activitiesSnapshot();

      /// (2) optional print
      // print(activities.runtimeType);

      /// (3) expect RuntimeType: Asset
      expect(activities.runtimeType, Activities);
    });

    /// TODO we will then expect the url count to be +1 from the original count since we will be deleting 1 url as a part of our testing of activities/{activity}/delete [POST]
    /// TODO expect the activity url to be present after its creation
    test('/activities/create[POST] - global event', () async {
      /// (1) call application Snapshot
      Application application = (await applicationsApi.applicationsSnapshot()).iterable.first;

      /// (2) call the endpoint activitiesCreateNewActivity  --> creates a new activity url that is visible in pfd info view
      Activity created = await activitiesApi.activitiesCreateNewActivity(
        seededActivity: SeededActivity(
          application: application,
          event: SeededConnectorTracking(),
        ),
      );

      /// (3) expect /activities/create [POST] to be of type Activity
      expect(created.runtimeType, Activity);
    });

    test('/activities/create[POST] && link with asset.', () async {
      /// (1) call application Snapshot
      Application application = (await applicationsApi.applicationsSnapshot()).iterable.first;

      /// (2) get the first asset so we can link it.
      Asset asset;
      try {
        asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first;
      } catch (error) {
        throw Exception('Cannot confirm test /activities/create[POST] && link with asset. because we have no assets.');
      }

      /// (3) call the endpoint activitiesCreateNewActivity  --> creates a new activity url that is visible in pfd info view
      Activity created = await activitiesApi.activitiesCreateNewActivity(
        seededActivity: SeededActivity(
          application: application,
          event: SeededConnectorTracking(),
          asset: ReferencedAsset(id: asset.id),
        ),
      );

      /// (4) expect /assets/{asset} [GET] to ensure that the activity was linked properly
      asset = await assetApi.assetSnapshot(asset.id, transferables: false);

      /// (5) expect that the activity that we just link is present on our asset :)
      expect(
        asset.activities?.iterable.where((Activity activity) => activity.id == created.id).isNotEmpty,
        true,
      );
    });

    test('/activities/create[POST] && link with format.', () async {
      /// (1) call application Snapshot
      Application application = (await applicationsApi.applicationsSnapshot()).iterable.first;

      /// (2) get the first format so we can link it.
      Format format;
      try {
        format = (await formatsApi.formatsSnapshot(transferables: false)).iterable.first;
      } catch (error) {
        throw Exception(
            'Cannot confirm test /activities/create[POST] && link with format. because we have no formats.');
      }

      /// (3) call the endpoint activitiesCreateNewActivity  --> creates a new activity url that is visible in pfd info view
      Activity created = await activitiesApi.activitiesCreateNewActivity(
        seededActivity: SeededActivity(
          application: application,
          event: SeededConnectorTracking(),
          format: ReferencedFormat(id: format.id),
        ),
      );

      /// (4) expect /formats/{format} [GET] to ensure that the activity was linked properly
      format = await formatApi.formatSnapshot(format.id, transferable: false);

      /// (5) expect that the activity that we just link is present on our asset :)
      expect(
        format.activities?.iterable.where((Activity activity) => activity.id == created.id).isNotEmpty,
        true,
      );
    });

    test('/activities/create[POST] && link with user.', () async {
      /// (1) call application Snapshot
      Application application = (await applicationsApi.applicationsSnapshot()).iterable.first;

      /// (2) get the first user so we can link it.
      UserProfile user;
      try {
        user = (await usersApi.usersSnapshot()).iterable.first;
      } catch (error) {
        throw Exception('Cannot confirm test /activities/create[POST] && link with user. because we have no users.');
      }

      /// (3) call the endpoint activitiesCreateNewActivity  --> creates a new activity url that is visible in pfd info view
      Activity created = await activitiesApi.activitiesCreateNewActivity(
        seededActivity: SeededActivity(
          application: application,
          event: SeededConnectorTracking(),
          user: ReferencedUser(id: user.id),
        ),
      );

      /// (4) we arnt currently linking all the activities onto the user. so we just need to ensure that the user is attached to the
      expect(
        created.user != null,
        true,
      );
    });

    test('/activities/{activity}/delete [POST]', () async {
      /// (1) call /activities
      Activities activities = await activitiesApi.activitiesSnapshot();

      /// (2) if our activity snapshot is empty we will throw an error
      if (activities.iterable.isEmpty) {
        throw Exception('/activities/{activity}/delete [POST] failed because your activity snapshot is empty');
      }

      /// (2)
      Activity first = activities.iterable.first;

      /// (3)
      String delete = first.id;

      /// (4) optional print
      await activitiesApi.activitiesDeleteSpecificActivity(delete);

      /// TODO get a snapshot of the activities and ensuring that the ID we deleted is no longer within the asset!
      /// TODO we will then expect the url count to return to the original url count because we deleted the created tag
      /// (4) expect /activities/delete [POST] to be of type ActivitiesApi
      expect(activitiesApi.runtimeType, ActivitiesApi);
    });
  });
}
