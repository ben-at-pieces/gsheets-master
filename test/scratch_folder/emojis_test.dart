import 'dart:io';

import 'package:connector_openapi/api.dart' hide Tags;
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api.dart';

import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart' hide Tags;

/// /assets [GET]
/// /assets/{asset} [GET]
/// /assets/create] [POST]
/// /assets/{asset}/delete [POST]
/// /assets/related [GET]
/// /assets/search?query=string [GET]
/// TODO standardize db between all tests

Future<void> main() async {
  String port = '1000';
  String host = 'http://localhost:$port';
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  final PersonsApi personsApi = PersonsApi(ApiClient(basePath: host));
  final TagsApi tagsApi = TagsApi(ApiClient(basePath: host));
  final TagApi tagApi = TagApi(ApiClient(basePath: host));
  final AssetApi assetApi = AssetApi(ApiClient(basePath: host));
  final PersonApi personApi = PersonApi(ApiClient(basePath: host));
  final WebsiteApi websiteApi = WebsiteApi(ApiClient(basePath: host));
  final WebsitesApi websitesApi = WebsitesApi(ApiClient(basePath: host));
  final SensitivesApi sensitivesApi = SensitivesApi(ApiClient(basePath: host));

  group('META DATA WITH EMOJIS', () {
    test('/assets/create1 [POST]', () async {
      /// (1) register or get an application first
      final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

      /// (2) get your application
      Application application = (await connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.JETBRAINS,
            platform: PlatformEnum.MACOS,
            version: '3.1.0',
          ),
        ),
      ))
          .application;
      // print('application?? ${application}');

      /// (3) call the endpoint --> assetsCreateNewAsset
      Asset created = await assetsApi.assetsCreateNewAsset(
        seed: Seed(
          asset: SeededAsset(
              available: AvailableFormats(iterable: [
                Classification(
                    generic: ClassificationGenericEnum.CODE,
                    specific: ClassificationSpecificEnum.coffee)
              ]),
              discovered: false,
              application: application,
              format: SeededFormat(
                fragment: SeededFragment(
                  string: TransferableString(
                    raw: '''void main () {
 print('hello world!');
}''',
                  ),
                ),
              )),
          type: SeedTypeEnum.ASSET,
        ),
      );
      // print('created: ${created.original.reference?.application}');

      /// TODO for when this PR merges to main
      // expect(response.name?.contains('jpeg'), true);
      // expect(response.description?.contains('jpeg'), true);
      expect(created.runtimeType, Asset);
      // print(response);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /UPDATE NAME [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    test('/asset/update name [POST]', () async {
      /// (1) call assetsSnapshot
      Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset firstAsset = assetsSnapshot.iterable.first;

      /// (3) give your first asset a relevant name, so that it is reflected within our db
      firstAsset.name = 'testing name update';

      /// (4) call the endpoint /asset/update POST
      Asset assetUpdate = await assetApi.assetUpdate(asset: firstAsset);

      // print('/asset/update POST: ${assetUpdate}');
      /// expect RuntimeType: AssetUpdate
      expect(assetUpdate.runtimeType, Asset);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /UPDATE DESCRIPTION [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    test('/asset/update description [POST]', () async {
      /// (1) call assetsSnapshot
      Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset firstAsset = assetsSnapshot.iterable.first;

      /// (3) give your first asset a relevant name, so that it is reflected within our db
      firstAsset.description = '''
🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥
👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍👍
✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨✨
🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂🥂
''';

      /// (4) call the endpoint /asset/update POST
      Asset assetUpdate = await assetApi.assetUpdate(asset: firstAsset);

      // print('/asset/update POST: ${assetUpdate}');
      /// expect RuntimeType: AssetUpdate
      expect(assetUpdate.runtimeType, Asset);
    });


    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /person/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Persons0 add', () {
      test('/persons/create1 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@mark',
                name: 'mark widman',
                email: 'mark@pieces.app',
                picture: 'https://lh3.google.com/u/0/ogw/ADea4I6m0GU1ooKiWRgvDIuDd1uP8yu0cCJuK1AjzMbu=s64-c-mo',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
      test('/persons/create2 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@tsavo',
                name: 'tsavo knott',
                email: 'tsavo@pieces.app',
                picture: 'https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/606dd1a296e8d60068d11f59/4cc12555-6e4c-4950-8d56-c94bd3c08020/128',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
      test('/persons/create3 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@mack',
                name: 'mack myers',
                email: 'mack@pieces.app',
                picture: 'https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/606dd5f32b469c007046df54/13a7e176-51d9-47b6-8e58-1cc48b338396/128',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
      test('/persons/create4 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@jordan',
                name: 'jordan freeman',
                email: 'jordan@pieces.app',
                picture: 'https://ca.slack-edge.com/T016ZUW6H97-U017FNHSQ8G-edbb6e2c5925-512',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
      test('/persons/create5 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@laurin',
                name: 'laurin mcnulty',
                email: 'laurin@pieces.app',
                picture: 'https://ca.slack-edge.com/T016ZUW6H97-U03GMQ257FU-036f29721739-512',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
      test('/persons/create6 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@nicole',
                name: 'nicole wallace',
                email: 'nicole@pieces.app',
                picture: 'https://ca.slack-edge.com/T016ZUW6H97-U02BDJZDWPN-f051c12c0fad-512',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });


      test('/persons/create7 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@mack',
                name: 'Snowman ⛄ ',
                email: 'frost❄️@pieces.app',
                picture: 'https://avatar-management--avatars.us-west-2.prod.public.atl-paas.net/606dd5f32b469c007046df54/13a7e176-51d9-47b6-8e58-1cc48b338396/128',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
      test('/persons/create8 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@me',
                name: 'Disco man 🕺 ',
                email: 'disco@pieces.app',
                picture: '🪩 🪩 🪩 ',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });




      test('/persons/create9 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@laurin',
                name: 'T Rex 🦖',
                email: 'laurin@pieces.app',
                picture: '🦖',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
      test('/persons/create10 [POST]', () async {
        /// (1) get the asset we are going to create a person on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '@Liz',
                name: 'Lizard Man 🦎',
                email: 'nicole@pieces.app',
                picture: '🐲',
                sourced: ExternallySourcedEnum.TWITTER,
                url: 'https://www.google.com/',
              ),
            ),
            asset: asset,
            mechanism: MechanismEnum.MANUAL,
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        /// TODO check our edge cases with error status codes.
        /// TODO get a snapshot of the asset and ensure that our created person is on there!
        /// TODO try and create a UserProfile && a Basic User.
        expect(created.runtimeType, Person);
      });
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /ADD A TAG ]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Tags1 add', () {
      test('/tags/create1 [POST]', () async {
        /// (1) define your new tags name
        String textTag =
            '🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create2 [POST]', () async {
        /// (1) define your new tags name
        String textTag = '🐍';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create3 [POST]', () async {
        /// (1) define your new tags name
        String textTag = '💡';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create4 [POST]', () async {
        /// (1) define your new tags name
        String textTag = '🧬 ';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create5 [POST]', () async {
        /// (1) define your new tags name
        String textTag =
            'v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^ ';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create6 [POST]', () async {
        /// (1) define your new tags name
        String textTag =
            'v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^ ';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create7 [POST]', () async {
        /// (1) define your new tags name
        String textTag = '🐍';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create8 [POST]', () async {
        /// (1) define your new tags name
        String textTag = '📔 ';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create9 [POST]', () async {
        /// (1) define your new tags name
        String textTag = '🧬 ';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create10 [POST]', () async {
        /// (1) define your new tags name
        String textTag =
            '🔱';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
      test('/tags/create11 [POST]', () async {
        /// (1) define your new tags name
        String textTag =
            '♨️';

        /// (2) call assets Snapshot
        Assets assetsSnapshot = await assetsApi.assetsSnapshot();

        /// (3) get the first asset from assetsSnapshot
        Asset firstAsset = assetsSnapshot.iterable.first;

        /// (4) call the endpoint --> tagsCreateNewTag --> creates a new string tag
        Tag create = await tagsApi.tagsCreateNewTag(
            seededTag: SeededTag(text: textTag, asset: firstAsset.id));

        create;

        /// (5) expect tagsCreate to be of type Tag
        expect(create.runtimeType, Tag);

        /// TODO create a tag and check to see that the tag is present
      });
    });

    group('Sensitive1 add', () {
      test('/sensitives/create1 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: '♨️📔🧁💫✨💰💵🎄🌟🎁🔥',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.HIGH,
            name: 'API Key 🔑',
            description: '♨️📔🧁💫✨💰💵🎄🌟🎁🔥',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create2 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.MODERATE,
            name: 'Private Key 🔏 ',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create3 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: '4236545768685764_753423',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.LOW,
            name: 'Access token 🪙 ',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create4 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.HIGH,
            name: 'Secret Key 🤫',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create5 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.HIGH,
            name: '🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫🤫',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create6 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.CLIENT_ID,
            severity: SensitiveSeverityEnum.MODERATE,
            name: '',
            description: '💫💫💫💫💫💫💫💫💫💫💫💫💫💫💫',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create7 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.LOW,
            name: '⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ⛰ ',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create8 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.HIGH,
            name: '💵💵💵💵💵💵💵💵💵💵💵💵💵💵💵💵💵',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create9 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.HIGH,
            name: '🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁🧁',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
      test('/sensitives/create10 [POST]', () async {
        /// (1) get the asset we are going to create a sensitive on.
        String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

        /// (2) create our sensitive.
        Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
          seededSensitive: SeededSensitive(
            asset: asset,
            text: 'hello here is some sensitive information',
            category: SensitiveCategoryEnum.API_KEY,
            severity: SensitiveSeverityEnum.HIGH,
            name: '🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥',
            description: 'this is the key used for stripe.',
          ),
        );

        /// expect
        /// TODO check all our properties are present.
        expect(created.runtimeType, Sensitive);
      });
    });
  });
}
// ♨️📔🧁💫✨💰💵🎄🌟🎁🔥⛄