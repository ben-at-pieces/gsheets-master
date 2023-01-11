import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// /activity/update [POST]
/// /activity/{activity} [GET]
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  ActivityApi activityApi = ActivityApi(ApiClient(basePath: host));
  ActivitiesApi activitiesApi = ActivitiesApi(ApiClient(basePath: host));

  group('ActivityApi Group', () {
    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /activity/{activity} [GET] v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/activity/{activity} [GET]', () async {
      /// (1) call /activities snapshot
      Activities activities = await activitiesApi.activitiesSnapshot();

      /// (2) get the first activity from your activitiesSnapshot
      Activity first = activities.iterable.first;

      /// (3) get the first activity ID -->string
      String activity = first.id;

      /// (4) call the endpoint --> SpecificActivitySnapshot
      Activity activitySnapshot = await activityApi.activitiesSpecificActivitySnapshot(activity);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /activity/update [POST] v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/activity/update [POST]', () async {
      /// (1) call /activities
      Activities activities = await activitiesApi.activitiesSnapshot();

      if (activities.iterable.isEmpty) {
        throw Exception('/activity/update [POST] failed because our activities snapshot is empty.');
      }

      /// (2) get the first asset
      Activity first = activities.iterable.first;

      /// (3) map the original activity to json
      Map<String, dynamic> old = first.toJson();

      /// (4) update a property on our activity.
      first.updated = GroupedTimestamp(value: DateTime.now());

      /// (5) call activityUpdate
      Activity updated = await activityApi.activityUpdate(activity: first);

      /// expect that the old and the updated activity are both different.
      expect(updated.toJson() != old, true);
    });
  });
}
