import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart' hide Tags;

/// /tags [GET]
/// /tags/create [POST]
/// [tags/{tag}/delete [POST]

Future<void> main() async {
  String port = '1000';
  String host = 'http://localhost:$port';
  TagsApi tagsApi = TagsApi(ApiClient(basePath: host));
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

  group('TagsApi Group', () {
    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /tags [GET]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    test('/tags [GET]', () async {
      /// (1) call tags Snapshot
      Tags tagsSnapshot = await tagsApi.tagsSnapshot();

      /// (2) expect tagsSnapshot to be of type Tags
      expect(tagsSnapshot.runtimeType, Tags);

      ///  TODO when using a standardized db we will update this expect to reflect the size that we are actually expecting
      ///  TODO modify transferrables to reflect true and false (verify that users are getting what they expect)
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^  /tags/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('/tags/create [POST]', () async {
      /// (1) define your new tags name
      String textTag = 'dart';

      /// (2) call assets Snapshot
      Assets assetsSnapshot = await assetsApi.assetsSnapshot();

      /// (3) get the first asset from assetsSnapshot
      Asset firstAsset = assetsSnapshot.iterable.first;

      /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
      Tag create = await tagsApi.tagsCreateNewTag(seededTag: SeededTag(text: textTag, asset: firstAsset.id));

      /// (5) expect tagsCreate to be of type Tag
      expect(create.runtimeType, Tag);

      /// TODO create a tag and check to see that the tag is present
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^  /tags/{tag}/delete [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    test('[tags/{tag}/delete [POST]', () async {
      /// (1) call tags Snapshot
      Tags snapshot = await tagsApi.tagsSnapshot();

      /// (2) get the first tag from tags Snapshot
      Tag first = snapshot.iterable.first;

      /// (3) first tag text
      String tag = first.id;

      /// (4) call the endpoint --> tagsDeleteSpecificTag
      await tagsApi.tagsDeleteSpecificTag(tag);

      // print(tagDelete.runtimeType);
    });

    /// TODO add these to cookbook recipes as they do not relate to api testing in this context
    /// TODO return a list of tags and return the number of tags

    test('total number of tags', () async {
      /// (1) call tag snapshot
      Tags tagsSnapshot = await tagsApi.tagsSnapshot();

      /// (2) Create a list of iterable tags
      List<Tag> tags = tagsSnapshot.iterable;

      /// (3) print the number of Tags in your repo
      print('you have ${tags.length} tags in your personal Pieces repo');

      /// (4) expect our tags snapshot to not be empty
      expect(tags.isNotEmpty, true);
    });

    /// TODO add a tag and verify that it was added to your snippet

    test('# of Dart Tags', () async {
      /// (1) call tag snapshot
      Tags snapshot = await tagsApi.tagsSnapshot();

      /// (2) Create a list of iterable tags
      List<Tag> tags = snapshot.iterable;

      /// (3) Display tags where the Tag (text) is dart
      List<Tag> tagsList = tags.where((Tag element) => element.text == 'dart').toList();

      /// (4) Print the number of times that tag is present.
      print('within that list you have ${tagsList.length} dart tag(s)');
      // expect(tagsList.contains(element) => true, true);
    });
  });
}
