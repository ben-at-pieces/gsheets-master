import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart' hide Tags;

/// /tag
/// /tag/{tag} [GET]
/// /tag/update [POST]

void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  TagsApi tagsApi = TagsApi(ApiClient(basePath: host));
  TagApi tagApi = TagApi(ApiClient(basePath: host));

  group('TagApi Group', () {
    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^  /tag/{tag} [GET]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    test('/tag/{tag} [GET]', () async {
      /// (1) call tags snapshot
      Tags tags = await tagsApi.tagsSnapshot(transferables: false);

      /// (2) get the first tag
      Tag first = tags.iterable.first;

      /// (3) get the first tags ID
      String tag = first.id;

      /// (4) call the endpoint tagsSpecificTagSnapshot
      Tag snapshot = await tagApi.tagsSpecificTagSnapshot(tag);

      /// (5) expect runtimeType: Tag
      expect(snapshot.runtimeType, Tag);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^  /tag/update [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/tag/update [POST]', () async {
      /// (1) call tags snapshot
      Tags tags = await tagsApi.tagsSnapshot(transferables: false);

      /// (2) get the first tag
      Tag first = tags.iterable.first;

      /// (3) give your first asset a relevant tag name, so that it is reflected within our db
      first.text = 'Hello World!';

      /// (4) call the endpoint tag/update
      Tag tagUpdate = await tagApi.tagUpdate(tag: first);

      /// (5) expect the runtime type to be of type Tag
      expect(tagUpdate.runtimeType, Tag);
      // print('here is the updated Tag: ${tagUpdate.text}');
    });
  });
}
