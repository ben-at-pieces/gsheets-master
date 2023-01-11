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
  final TagsApi tagsApi = TagsApi(ApiClient(basePath: host));
  final TagApi tagApi = TagApi(ApiClient(basePath: host));
  final AssetApi assetApi = AssetApi(ApiClient(basePath: host));

  final WebsiteApi websiteApi = WebsiteApi(ApiClient(basePath: host));
  final WebsitesApi websitesApi = WebsitesApi(ApiClient(basePath: host));
  final SensitivesApi sensitivesApi = SensitivesApi(ApiClient(basePath: host));

  final PersonApi personApi = PersonApi(ApiClient(basePath: host));
  final PersonsApi personsApi = PersonsApi(ApiClient(basePath: host));





    ///
    /// add jpeg
    /// reclassify
    /// add tags
    /// add persons
    /// add related links
    /// add sensitives
    ///
    /// add png
    /// reclassify
    /// add tags
    /// add persons
    /// add related links
    /// add sensitives
    ///
    /// add snippet raw
    /// reclassify
    /// add tags
    /// add persons
    /// add related links
    /// add sensitives
    ///
    /// add snippet raw
    /// reclassify
    /// add tags
    /// add persons
    /// add related links
    /// add sensitives
    ///
    ///
    /// Asset Creation #1 JPEG
    ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
    /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
    /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

    /// Asset Creation #3 Raw String
    ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
    /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
    /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
    group(' Add 3 an update', () {
    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^    /assets/create1[POST]     v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
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
              metadata: SeededAssetMetadata(
                name: 'JetBrains Test Snippet',
                description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
                tags: [
                  SeededAssetTag(
                      text: 'JETBRAINS',
                      mechanism: MechanismEnum.MANUAL,
                      category: TagCategoryEnum.HANDLE)
                ],
                persons: [
                  SeededPerson(
                      access: PersonAccess(
                          schema: EmbeddedModelSchema(
                              migration: 1,
                              semantic: EmbeddedModelSchemaSemanticVersionEnum.mAJOR0MINOR0PATCH1)),
                      type: PersonType(
                          basic: PersonBasicType(
                              picture:
                                  'https://lh3.googleusercontent.com/a/AEdFTp44ple5FjUEoDP4w4InROkHFtE5i4hY3nEnGNd1gw=s288-p-rw-no',
                              username: 'benj',
                              name: 'benjaminbuttons',
                              email: 'benjaminbuttons@pieces.app')))
                ],
                sensitives: [
                  SeededAssetSensitive(
                    text: '333 333333 333333333',
                    category: SensitiveCategoryEnum.CLIENT_ID,
                    severity: SensitiveSeverityEnum.HIGH,
                    name: 'Secret Test ==========================',
                    description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
                  )
                ],
                // persons: [],
                mechanism: MechanismEnum.AUTOMATIC,
              ),
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

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Reclassify [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    test('/asset/reclassify1 POST', () async {
      /// (1) lets get our assets
      Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset asset = assetsSnapshot.iterable.first;

      /// (3) call the endpoint (AssetReclassification)
      Asset assetReclassification = await assetApi.assetReclassify(
          assetReclassification:
              AssetReclassification(ext: ClassificationSpecificEnum.c, asset: asset));

      /// expect RuntimeType: Asset
      expect(assetReclassification.runtimeType, Asset);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Tags [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Tags1 add', () {
      test('/tags/create2 [POST]', () async {
        /// (1) define your new tags name
        String textTag = 'list';

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
        String textTag = 'pieces';

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
        String textTag = 'data';

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
      test('/tags/create5 [POST]', ()  async {
        /// (1) define your new tags name
        String textTag = 'v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^ ';

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

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /person/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Persons1 add', () {
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

        Persons personsSnapshot = await personsApi.personsSnapshot(transferables: false);

        var people = personsSnapshot.iterable;

        print(people.first.type.platform?.name);
var name = people.first.type.platform?.name;
var username = people.first.type.platform?.username;
var email = people.first.type.platform?.email;
var picture = people.first.type.platform?.picture;
        // Person person = await personApi.personSnapshot(person);
        /// (2) create our person.
        Person created = await personsApi.personsCreateNewPerson(
          seededPerson: SeededPerson(
            /// you must pass in access, but providing a scope is only required for platform users.
            access: PersonAccess(),
            type: PersonType(
              basic: PersonBasicType(
                username: '$username',
                name: '$name',
                email: '$email',
                picture: '$picture',
                sourced: ExternallySourcedEnum.TWITTER,
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

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /Related link/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Related link1 add', () {
    test('/websites/create1 [GET]', () async {
      /// (1) call assets Snapshot
      Assets assets = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset first = assets.iterable.first;

      /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
      Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
          seededWebsite: SeededWebsite(
            asset: first.id,
            url: 'https://code.pieces.app/',
            name: '',
          ));

      /// (4) expect /websites/create [GET] to be of type Website
      expect(websitesCreate.runtimeType, Website);

      /// (5) expect website url to not be empty
      expect(websitesCreate.url.isNotEmpty, true);
    });
    test('/websites/create2 [GET]', () async {
      /// (1) call assets Snapshot
      Assets assets = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset first = assets.iterable.first;

      /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
      Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
          seededWebsite: SeededWebsite(
            asset: first.id,
            name: '',
            url: 'https://google.com/',
          ));

      /// (4) expect /websites/create [GET] to be of type Website
      expect(websitesCreate.runtimeType, Website);

      /// (5) expect website url to not be empty
      expect(websitesCreate.url.isNotEmpty, true);
    });
    test('/websites/create3 [GET]', () async {
      /// (1) call assets Snapshot
      Assets assets = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset first = assets.iterable.first;

      /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
      Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
          seededWebsite: SeededWebsite(
            asset: first.id,
            name: '',
            url: 'https://google.com/'
          ));

      /// (4) expect /websites/create [GET] to be of type Website
      expect(websitesCreate.runtimeType, Website);

      /// (5) expect website url to not be empty
      expect(websitesCreate.url.isNotEmpty, true);
    });
    test('/websites/create4 [GET]', () async {
      /// (1) call assets Snapshot
      Assets assets = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset first = assets.iterable.first;

      /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
      Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
          seededWebsite: SeededWebsite(
            asset: first.id,
            url: 'https://dart.dev/',
            name: '',
          ));

      /// (4) expect /websites/create [GET] to be of type Website
      expect(websitesCreate.runtimeType, Website);

      /// (5) expect website url to not be empty
      expect(websitesCreate.url.isNotEmpty, true);
    });
    test('/websites/create5 [GET]', () async {
      /// (1) call assets Snapshot
      Assets assets = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset first = assets.iterable.first;

      /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
      Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
          seededWebsite: SeededWebsite(
            asset: first.id,
            url: 'https://stackoverflow.com/',
            name: '',
          ));

      /// (4) expect /websites/create [GET] to be of type Website
      expect(websitesCreate.runtimeType, Website);

      /// (5) expect website url to not be empty
      expect(websitesCreate.url.isNotEmpty, true);
    });
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /sensitives/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^

    group('Sensitive1 add', () {
    test('/sensitives/create1 [POST]', () async {
      /// (1) get the asset we are going to create a sensitive on.
      String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

      /// (2) create our sensitive.
      Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
        seededSensitive: SeededSensitive(
          asset: asset,
          text: 'hello here is some sensitive information',
          category: SensitiveCategoryEnum.API_KEY,
          severity: SensitiveSeverityEnum.HIGH,
          name: 'stripe key',
          description: 'this is the key used for stripe.',
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
          name: 'stripe key',
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
          text: 'hello here is some sensitive information',
          category: SensitiveCategoryEnum.API_KEY,
          severity: SensitiveSeverityEnum.LOW,
          name: 'stripe key',
          description: 'this is the key used for stripe.',
        ),
      );

      /// expect
      /// TODO check all our properties are present.
      expect(created.runtimeType, Sensitive);
    });
    });


    /// Asset Creation #3

    ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
    /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
    /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^    /assets/create1[POST]     v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    test('/assets/create2 [POST]', () async {
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
              metadata: SeededAssetMetadata(
                name: 'JetBrains Test Snippet',
                description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
                tags: [
                  SeededAssetTag(
                      text: 'JETBRAINS',
                      mechanism: MechanismEnum.MANUAL,
                      category: TagCategoryEnum.HANDLE)
                ],
                persons: [
                  SeededPerson(
                      access: PersonAccess(
                          schema: EmbeddedModelSchema(
                              migration: 1,
                              semantic: EmbeddedModelSchemaSemanticVersionEnum.mAJOR0MINOR0PATCH1)),
                      type: PersonType(
                          basic: PersonBasicType(
                              picture:
                              'https://lh3.googleusercontent.com/a/AEdFTp44ple5FjUEoDP4w4InROkHFtE5i4hY3nEnGNd1gw=s288-p-rw-no',
                              username: 'benj',
                              name: 'benjaminbuttons',
                              email: 'benjaminbuttons@pieces.app')))
                ],
                sensitives: [
                  SeededAssetSensitive(
                    text: '333 333333 333333333',
                    category: SensitiveCategoryEnum.CLIENT_ID,
                    severity: SensitiveSeverityEnum.HIGH,
                    name: 'Secret Test ==========================',
                    description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
                  )
                ],
                // persons: [],
                mechanism: MechanismEnum.AUTOMATIC,
              ),
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

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Reclassify [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    test('/asset/reclassify2 POST', () async {
      /// (1) lets get our assets
      Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

      /// (2) get the first asset
      Asset asset = assetsSnapshot.iterable.first;

      /// (3) call the endpoint (AssetReclassification)
      Asset assetReclassification = await assetApi.assetReclassify(
          assetReclassification:
          AssetReclassification(ext: ClassificationSpecificEnum.c, asset: asset));

      /// expect RuntimeType: Asset
      expect(assetReclassification.runtimeType, Asset);
    });

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Tags [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Tags2 add', () {
      test('/tags/create2 [POST]', () async {
        /// (1) define your new tags name
        String textTag = 'list';

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
        String textTag = 'list';

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
        String textTag = 'data';

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
        String textTag = 'v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^ ';

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

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /person/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Persons2 add', () {
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

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /Related link /create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Related link2 add', () {
      test('/websites/create1 [GET]', () async {
        /// (1) call assets Snapshot
        Assets assets = await assetsApi.assetsSnapshot(transferables: false);

        /// (2) get the first asset
        Asset first = assets.iterable.first;

        /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
        Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
            seededWebsite: SeededWebsite(
              asset: first.id,
              url: 'https://google.com/',
              name: '',
            ));

        /// (4) expect /websites/create [GET] to be of type Website
        expect(websitesCreate.runtimeType, Website);

        /// (5) expect website url to not be empty
        expect(websitesCreate.url.isNotEmpty, true);
      });
      test('/websites/create2 [GET]', () async {
        /// (1) call assets Snapshot
        Assets assets = await assetsApi.assetsSnapshot(transferables: false);

        /// (2) get the first asset
        Asset first = assets.iterable.first;

        /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
        Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
            seededWebsite: SeededWebsite(
              asset: first.id,
              url: 'https://twitter.com/',
              name: '',
            ));

        /// (4) expect /websites/create [GET] to be of type Website
        expect(websitesCreate.runtimeType, Website);

        /// (5) expect website url to not be empty
        expect(websitesCreate.url.isNotEmpty, true);
      });
      test('/websites/create3 [GET]', () async {
        /// (1) call assets Snapshot
        Assets assets = await assetsApi.assetsSnapshot(transferables: false);

        /// (2) get the first asset
        Asset first = assets.iterable.first;

        /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
        Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
            seededWebsite: SeededWebsite(
              asset: first.id,
              url: 'https://stackoverflow.com/',
              name: '',
            ));

        /// (4) expect /websites/create [GET] to be of type Website
        expect(websitesCreate.runtimeType, Website);

        /// (5) expect website url to not be empty
        expect(websitesCreate.url.isNotEmpty, true);
      });
      test('/websites/create4 [GET]', () async {
        /// (1) call assets Snapshot
        Assets assets = await assetsApi.assetsSnapshot(transferables: false);

        /// (2) get the first asset
        Asset first = assets.iterable.first;

        /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
        Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
            seededWebsite: SeededWebsite(
              asset: first.id,
              url: 'https://dart.dev/',
              name: '',
            ));

        /// (4) expect /websites/create [GET] to be of type Website
        expect(websitesCreate.runtimeType, Website);

        /// (5) expect website url to not be empty
        expect(websitesCreate.url.isNotEmpty, true);
      });
      test('/websites/create5 [GET]', () async {
        /// (1) call assets Snapshot
        Assets assets = await assetsApi.assetsSnapshot(transferables: false);

        /// (2) get the first asset
        Asset first = assets.iterable.first;

        /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
        Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
            seededWebsite: SeededWebsite(
              asset: first.id,
              url: 'https://facebook.com/',
              name: '',
            ));

        /// (4) expect /websites/create [GET] to be of type Website
        expect(websitesCreate.runtimeType, Website);

        /// (5) expect website url to not be empty
        expect(websitesCreate.url.isNotEmpty, true);
      });
    });

    group('create JPG', () {
      test('jpeg works', () async {
        File imageFile = File('test/data/puppy.jpg');
        List<int> bytes = imageFile.readAsBytesSync().cast();

        final Asset response = await assetsApi.assetsCreateNewAsset(
          seed: Seed(
            asset: SeededAsset(
              application: Application(
                privacy: PrivacyEnum.OPEN,
                name: ApplicationNameEnum.VS_CODE,
                onboarded: true,
                platform: PlatformEnum.MACOS,
                version: '1.5.7',
                id: '6a9e37e1-e49c-4985-ab56-480f67f05a64',
              ),
              format: SeededFormat(
                ///=======
                file: SeededFile(
                  bytes: TransferableBytes(raw: bytes),
                ),
              ),
            ),
            type: SeedTypeEnum.ASSET,
          ),
        );
        expect(response.name?.contains('JPEG Image'), true);
        expect(response.description?.contains('A jpeg image'), true);
      });

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Reclassify [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      test('/asset/reclassify0 POST', () async {
        /// (1) lets get our assets
        Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

        /// (2) get the first asset
        Asset asset = assetsSnapshot.iterable.first;

        /// (3) call the endpoint (AssetReclassification)
        Asset assetReclassification = await assetApi.assetReclassify(
            assetReclassification:
            AssetReclassification(ext: ClassificationSpecificEnum.c, asset: asset));

        /// expect RuntimeType: Asset
        expect(assetReclassification.runtimeType, Asset);
      });

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Tags [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      group('Tags0 add', () {
        test('/tags/create2 [POST]', () async {
          /// (1) define your new tags name
          String textTag = 'list';

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
          String textTag = 'pieces';

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
          String textTag = 'data';

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
          String textTag = 'v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^ ';

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

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /Related link/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      group('Related link0 add', () {
        test('/websites/create1 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                url: 'https://code.pieces.app/',
                name: '',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create2 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                name: '',
                url: 'https://google.com/',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create3 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                name: '',
                url: 'https://google.com/',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create4 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                url: 'https://dart.dev/',
                name: '',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create5 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                url: 'https://stackoverflow.com/',
                name: '',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
      });

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /sensitives/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      group('Sensitive0 add', () {
        test('/sensitives/create1 [POST]', () async {
          /// (1) get the asset we are going to create a sensitive on.
          String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

          /// (2) create our sensitive.
          Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
            seededSensitive: SeededSensitive(
              asset: asset,
              text: 'hello here is some sensitive information',
              category: SensitiveCategoryEnum.API_KEY,
              severity: SensitiveSeverityEnum.HIGH,
              name: 'stripe key',
              description: 'this is the key used for stripe.',
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
              name: 'stripe key',
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
              text: 'hello here is some sensitive information',
              category: SensitiveCategoryEnum.API_KEY,
              severity: SensitiveSeverityEnum.LOW,
              name: 'stripe key',
              description: 'this is the key used for stripe.',
            ),
          );

          /// expect
          /// TODO check all our properties are present.
          expect(created.runtimeType, Sensitive);
        });
      });

    });

    /// Asset Creation #2 PNG
    ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
    /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
    /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
    group('Asset Creation #2 PNG', () {
      test('create: PNG', () async {
        File imageFile = File('test/data/png/white.png');
        List<int> bytes = imageFile.readAsBytesSync().cast();

        ///call the endpoint -->assetsCreate
        Asset response = await assetsApi.assetsCreateNewAsset(
          seed: Seed(
            asset: SeededAsset(
              application: Application(
                privacy: PrivacyEnum.OPEN,
                name: ApplicationNameEnum.VS_CODE,
                onboarded: true,
                platform: PlatformEnum.MACOS,
                version: '1.5.7',
                id: '6a9e37e1-e49c-4985-ab56-480f67f05a64',
              ),
              format: SeededFormat(
                ///=======
                file: SeededFile(
                  bytes: TransferableBytes(raw: bytes),
                ),
              ),
            ),
            type: SeedTypeEnum.ASSET,
          ),
        );
        // expect(response.name?.contains('jpeg'), true);
        // expect(response.description?.contains('jpeg'), true);
        expect(response.runtimeType, Asset);
        // print(response);
      });

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Reclassify [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      test('/asset/reclassify0 POST', () async {
        /// (1) lets get our assets
        Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);

        /// (2) get the first asset
        Asset asset = assetsSnapshot.iterable.first;

        /// (3) call the endpoint (AssetReclassification)
        Asset assetReclassification = await assetApi.assetReclassify(
            assetReclassification:
            AssetReclassification(ext: ClassificationSpecificEnum.c, asset: asset));

        /// expect RuntimeType: Asset
        expect(assetReclassification.runtimeType, Asset);
      });

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Tags [POST]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      group('Tags0 add', () {
        test('/tags/create2 [POST]', () async {
          /// (1) define your new tags name
          String textTag = 'list';

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
          String textTag = 'pieces';

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
          String textTag = 'data';

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
          String textTag = 'v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^ ';

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
          String textTag = 'v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^ ';

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

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /Related link/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      group('Related link0 add', () {
        test('/websites/create1 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                url: 'https://code.pieces.app/',
                name: '',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create2 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                name: '',
                url: 'https://google.com/',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create3 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                name: '',
                url: 'https://google.com/',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create4 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                url: 'https://dart.dev/',
                name: '',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
        test('/websites/create5 [GET]', () async {
          /// (1) call assets Snapshot
          Assets assets = await assetsApi.assetsSnapshot(transferables: false);

          /// (2) get the first asset
          Asset first = assets.iterable.first;

          /// (3) call the endpoint websitesCreateNewWebsite  --> creates a new website url that is visible in pfd info view
          Website websitesCreate = await websitesApi.websitesCreateNewWebsite(
              seededWebsite: SeededWebsite(
                asset: first.id,
                url: 'https://stackoverflow.com/',
                name: '',
              ));

          /// (4) expect /websites/create [GET] to be of type Website
          expect(websitesCreate.runtimeType, Website);

          /// (5) expect website url to not be empty
          expect(websitesCreate.url.isNotEmpty, true);
        });
      });

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /sensitives/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      group('Sensitive0 add', () {
        test('/sensitives/create1 [POST]', () async {
          /// (1) get the asset we are going to create a sensitive on.
          String asset = (await assetsApi.assetsSnapshot(transferables: false)).iterable.first.id;

          /// (2) create our sensitive.
          Sensitive created = await sensitivesApi.sensitivesCreateNewSensitive(
            seededSensitive: SeededSensitive(
              asset: asset,
              text: 'hello here is some sensitive information',
              category: SensitiveCategoryEnum.API_KEY,
              severity: SensitiveSeverityEnum.HIGH,
              name: 'stripe key',
              description: 'this is the key used for stripe.',
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
              name: 'stripe key',
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
              text: 'hello here is some sensitive information',
              category: SensitiveCategoryEnum.API_KEY,
              severity: SensitiveSeverityEnum.LOW,
              name: 'stripe key',
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
              category: SensitiveCategoryEnum.API_ID,
              severity: SensitiveSeverityEnum.LOW,
              name: 'stripe key',
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
              category: SensitiveCategoryEnum.API_ID,
              severity: SensitiveSeverityEnum.HIGH,
              name: 'stripe key',
              description: 'this is the key used for stripe.',
            ),
          );

          /// expect
          /// TODO check all our properties are present.
          expect(created.runtimeType, Sensitive);
        });
      });

    });


  });
}
void executeClosed() {
  print('closed');
}
// /^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /name update [GET]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
// test('/asset/update name1 [POST]', () async {
//   /// (1) call assetsSnapshot
//   Assets assetsSnapshot = await assetsApi.assetsSnapshot(transferables: false);
//
//   /// (2) get the first asset
//   Asset firstAsset = assetsSnapshot.iterable.first;
//
//   /// (3) give your first asset a relevant name, so that it is reflected within our db
//   firstAsset.name = 'testing name update';
//
//   /// (4) call the endpoint /asset/update POST
//   Asset assetUpdate = await assetApi.assetUpdate(asset: firstAsset);
//
//   // print('/asset/update POST: ${assetUpdate}');
//   /// expect RuntimeType: AssetUpdate
//   expect(assetUpdate.runtimeType, Asset);
// });