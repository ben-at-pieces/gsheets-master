import 'package:connector_openapi/api.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

void main() {
  /// This is the set up for the Asset Api which will enable us to test our AssetInternalServer.
  /// The AssetApi comes from the isomorphic_openapi/api.dart
  /// The ApiClient comes from package:openapi_dart_common/openapi.dart
  /// The Host is used to set up the base route that we will be communicating with you will never need to change this.
  final port = '1000';
  final host = 'http://localhost:$port';
  final AssetApi assetApi = AssetApi(ApiClient(basePath: host));
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  final PersonsApi personsApi = PersonsApi(ApiClient(basePath: host));
  final PersonApi personApi = PersonApi(ApiClient(basePath: host));
  final TagsApi tagsApi = TagsApi(ApiClient(basePath: host));

  setUp(() async {
    // TODO Create an asset here, then check to see that
    Future<void> testCreation(TransferableString String) async {
      Assets assets = await assetsApi.assetsSnapshot(transferables: false);

      Asset creationResponse = await assetsApi.assetsCreateNewAsset(
          seed: Seed(
            schema: EmbeddedModelSchema(migration: 1, semantic: EmbeddedModelSchemaSemanticVersionEnum.mAJOR0MINOR0PATCH1),
            type: SeedTypeEnum.ASSET,
          ));
    }
  });

  tearDown(() async {
    // TODO Delete the asset from OS Server
  });

  ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
  /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
  /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `


  Future<void> testReclassify(ClassificationSpecificEnum ext) async {
    Assets assets = await assetsApi.assetsSnapshot(transferables: false);

    Asset response = await assetApi.assetReclassify(
        assetReclassification: AssetReclassification(
          ext: ext,
          asset: assets.iterable.first,
        ));
    // expect(response.formats.iterable[0].classification, ClassificationSpecificEnum);
  }

  ///  .--.      .--.      .--.      .--.      .--.      .--.      .--.      .--.
  /// :::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\::::::::.\
  /// '      `--'      `--'      `--'      `--'      `--'      `--'      `--'      `
  ///
  group('Asset Create & Modify', () {
    test('Asset Create Jetbrains', () async {
      final Asset response = await assetsApi.assetsCreateNewAsset(
        seed: Seed(
          asset: SeededAsset(
            application: Application(
              privacy: PrivacyEnum.OPEN,
              name: ApplicationNameEnum.JETBRAINS,
              onboarded: true,
              platform: PlatformEnum.MACOS,
              version: '1.5.7',
              id: '6a9e37e1-e49c-4985-ab56-480f67f05a64',
            ),
            format: SeededFormat(
              ///=======
              fragment: SeededFragment(
                string: TransferableString(
                  raw: 'jetbrains',
                ),
              ),
            ),
          ),
          type: SeedTypeEnum.ASSET,
        ),
      );
    });

    test('/assets/create VSCode[POST]', () async {
      ApplicationsApi applicationsApi = ApplicationsApi(ApiClient(basePath: host));
      Applications applications = await applicationsApi.applicationsSnapshot();
      final Asset response = await assetsApi.assetsCreateNewAsset(
        seed: Seed(
          asset: SeededAsset(
            application: Application(
              privacy: PrivacyEnum.OPEN,
              name: ApplicationNameEnum.VS_CODE,
              onboarded: true,
              platform: PlatformEnum.MACOS,
              version: applications.iterable.first.version,
              id: applications.iterable.first.id,
            ),
            format: SeededFormat(
              ///=======
              fragment: SeededFragment(
                string: TransferableString(
                  raw: 'jetbrains',
                ),
              ),
            ),
          ),
          type: SeedTypeEnum.ASSET,
        ),
      );
      // print(response);
    });
    test('/assets/create VSCode[POST]', () async {
      /// (1) register or get an application first
      final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

      /// (2) get your application
      Application application = (await connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.OS_SERVER,
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
            application: application,
            format: SeededFormat(
              fragment: SeededFragment(
                string: TransferableString(
                  raw: '''void main () {
 print('hello world');
}''',
                ),
              ),
            ),
            discovered: true,
            metadata: SeededAssetMetadata(
              mechanism: MechanismEnum.AUTOMATIC,
              // name: 'sample snippet',
              // description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
              tags: [
                SeededAssetTag(
                    text: 'TEST 1, 2, 3',
                    mechanism: MechanismEnum.AUTOMATIC,
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
                        username: '??',
                        name: 'benjamin_buttons',
                        url: 'www.google.com',
                        email: 'benjaminbuttons@pieces.app'),
                  ),
                )
              ],
              websites: [
                SeededAssetWebsite(
                  mechanism: MechanismEnum.RECOMMENDED,
                  url: 'www.pieces.app',
                  name: 'Pieces for Developers',
                )
              ],
              sensitives: [
                SeededAssetSensitive(
                  text: '333 333333 333333333',
                  category: SensitiveCategoryEnum.ACCESS_KEY,
                  severity: SensitiveSeverityEnum.HIGH,
                  name: 'Secret Test',
                  description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
                )
              ],
              // persons: [],
            ),
          ),
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
    test('/assets/create pieces CLI [POST]', () async {
      /// (1) register or get an application first
      final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

      /// (2) get your application
      Application application = (await connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.PIECES_FOR_DEVELOPERS_CLI,
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
            application: application,
            format: SeededFormat(
              fragment: SeededFragment(
                string: TransferableString(
                  raw: '''void main () {
 print('hello world');
}''',
                ),
              ),
            ),
            discovered: true,
            metadata: SeededAssetMetadata(
              mechanism: MechanismEnum.AUTOMATIC,
              // name: 'sample snippet',
              // description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
              tags: [
                SeededAssetTag(
                    text: 'TEST 1, 2, 3',
                    mechanism: MechanismEnum.AUTOMATIC,
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
                        username: '??',
                        name: 'benjamin_buttons',
                        url: 'www.google.com',
                        email: 'benjaminbuttons@pieces.app'),
                  ),
                )
              ],
              websites: [
                SeededAssetWebsite(
                  mechanism: MechanismEnum.RECOMMENDED,
                  url: 'www.pieces.app',
                  name: 'Pieces for Developers',
                )
              ],
              sensitives: [
                SeededAssetSensitive(
                  text: '333 333333 333333333',
                  category: SensitiveCategoryEnum.ACCESS_KEY,
                  severity: SensitiveSeverityEnum.HIGH,
                  name: 'Secret Test',
                  description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
                )
              ],
              // persons: [],
            ),
          ),
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
    test('/assets/create generic [POST]', () async {
      /// (1) register or get an application first
      final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

      /// (2) get your application
      Application application = (await connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.fIREFOXADDONMV3,
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
            application: application,
            format: SeededFormat(
              fragment: SeededFragment(
                string: TransferableString(
                  raw: '''void main () {
 print('hello world');
}''',
                ),
              ),
            ),
            discovered: true,
            metadata: SeededAssetMetadata(
              mechanism: MechanismEnum.AUTOMATIC,
              // name: 'sample snippet',
              // description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
              tags: [
                SeededAssetTag(
                    text: 'TEST 1, 2, 3',
                    mechanism: MechanismEnum.AUTOMATIC,
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
                        username: '??',
                        name: 'benjamin_buttons',
                        url: 'www.google.com',
                        email: 'benjaminbuttons@pieces.app'),
                  ),
                )
              ],
              websites: [
                SeededAssetWebsite(
                  mechanism: MechanismEnum.RECOMMENDED,
                  url: 'www.pieces.app',
                  name: 'Pieces for Developers',
                )
              ],
              sensitives: [
                SeededAssetSensitive(
                  text: '333 333333 333333333',
                  category: SensitiveCategoryEnum.ACCESS_KEY,
                  severity: SensitiveSeverityEnum.HIGH,
                  name: 'Secret Test',
                  description: 'testing 1, 2, 3, 4, 5, 6, 7, 8, 9',
                )
              ],
              // persons: [],
            ),
          ),
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
    group('JetBrains Update Group', () {


      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /name update [GET]    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      // test('/asset/update name [POST]', () async {
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

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   Asset/Reclassify POST    v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      test('/asset/reclassify POST', () async {
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

      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /person/update [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      test('/person/update [POST]', () async {
        /// (1) call our snapshot to get the first asset, so we can update.
        Persons persons = await personsApi.personsSnapshot();
        if (persons.iterable.isEmpty) {
          throw Exception(
              '/person/update [POST] FAILED, b/c our iterable is empty and cannot truely test our test.');
        }

        /// (2) update our first person locally
        Person updated = persons.iterable.first;

        /// (3) get our old person and toJson it so we can compare at the end.
        Map<String, dynamic> old = updated.toJson();
        if (updated.type.basic != null) {
          updated.type.basic!.email = 'update@pieces.app';
        }

        /// TODO check platform user updates. and so on. ie more update testing

        /// (4) send over our updated person
        updated = await personApi.updatePerson(person: updated);

        /// expect that our old and updated values are different.
        /// TODO add individual checks.
        expect(old != updated.toJson(), true);
      });


      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /tags/create [POST]  v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      test('/tags/create [POST]', () async {
        /// (1) define your new tags name
        String textTag = 'flutter';

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


      ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /person/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
      test('/persons/create [POST]', () async {
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
                url: 'www.twitter.com',
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

    ///----------------1<-------------Reclassify First Asset to: C
    test('C ', () async {
      await testReclassify(ClassificationSpecificEnum.c);
    });

    ///----------------2<-------------Reclassify First Asset to: C++
    test('C++ ', () async {
      await testReclassify(ClassificationSpecificEnum.cpp);
    });

    ///----------------3<-------------Reclassify First Asset to: Batchfile
    test('BatchFile', () async {
      await testReclassify(ClassificationSpecificEnum.bat);
    });

    ///----------------4<-------------Reclassify First Asset to: CoffeeScript
    test('Coffee Script ', () async {
      await testReclassify(ClassificationSpecificEnum.cs);
    });

    ///----------------5<-------------Reclassify First Asset to:
    test('C # ', () async {
      await testReclassify(ClassificationSpecificEnum.cs);
    });

    ///----------------6<-------------Reclassify First Asset to: CSS
    test('CSS', () async {
      await testReclassify(ClassificationSpecificEnum.css);
    });

    ///----------------7<-------------Reclassify First Asset to: Dart
    test('Dart', () async {
      await testReclassify(ClassificationSpecificEnum.dart);
    });

    ///----------------8<-------------Reclassify First Asset to: Erlang
    test('Erlang', () async {
      await testReclassify(ClassificationSpecificEnum.erl);
    });

    ///----------------9<-------------Reclassify First Asset to: Go
    test('Go', () async {
      await testReclassify(ClassificationSpecificEnum.go);
    });

    ///----------------10<-------------Reclassify First Asset to: Groovy
    test('Groovy', () async {
      await testReclassify(ClassificationSpecificEnum.gz);
    });

    ///----------------11<-------------Reclassify First Asset to: Haskell
    test('Haskell', () async {
      await testReclassify(ClassificationSpecificEnum.hs);
    });

    ///----------------12<-------------Reclassify First Asset to: HTML
    test('HTML', () async {
      await testReclassify(ClassificationSpecificEnum.html);
    });

    ///----------------13<-------------Reclassify First Asset to: Java
    test('Java', () async {
      await testReclassify(ClassificationSpecificEnum.java);
    });

    ///----------------14<-------------Reclassify First Asset to: Javascript
    test('JavaScript', () async {
      await testReclassify(ClassificationSpecificEnum.js);
    });

    ///----------------15<-------------Reclassify First Asset to: Lua
    test('Lua', () async {
      await testReclassify(ClassificationSpecificEnum.lua);
    });

    ///----------------16<-------------Reclassify First Asset to: Markdown
    test('MarkDown', () async {
      await testReclassify(ClassificationSpecificEnum.md);
    });

    ///----------------17<-------------Reclassify First Asset to: Matlab
    test('MatLab', () async {
      await testReclassify(ClassificationSpecificEnum.matlab);
    });

    ///----------------18<-------------Reclassify First Asset to: Objective C
    test('Object C', () async {
      await testReclassify(ClassificationSpecificEnum.m);
    });

    ///----------------19<-------------Reclassify First Asset to: Perl
    test('Perl', () async {
      await testReclassify(ClassificationSpecificEnum.p);
    });

    ///----------------20<-------------Reclassify First Asset to: PHP
    test('PHP', () async {
      await testReclassify(ClassificationSpecificEnum.php);
    });

    ///----------------21<-------------Reclassify First Asset to: PowerShell
    test('PowerShell', () async {
      await testReclassify(ClassificationSpecificEnum.ps);
    });

    ///----------------22<-------------Reclassify First Asset to: Python
    test('Python', () async {
      await testReclassify(ClassificationSpecificEnum.py);
    });

    ///----------------23<-------------Reclassify First Asset to: R
    test('R', () async {
      await testReclassify(ClassificationSpecificEnum.r);
    });

    ///----------------23<-------------Reclassify First Asset to: Ruby
    test('Ruby', () async {
      await testReclassify(ClassificationSpecificEnum.rb);
    });

    ///----------------24<-------------Reclassify First Asset to: Rust
    test('Reclassify First Asset to ', () async {
      await testReclassify(ClassificationSpecificEnum.rs);
    });

    ///----------------25<-------------Reclassify First Asset to: Scala
    test('Rust', () async {
      await testReclassify(ClassificationSpecificEnum.scala);
    });

    ///----------------26<-------------Reclassify First Asset to: Shell
    test('Shell', () async {
      await testReclassify(ClassificationSpecificEnum.sh);
    });

    ///----------------27<-------------Reclassify First Asset to: SQL
    test('SQL', () async {
      await testReclassify(ClassificationSpecificEnum.sql);
    });

    ///----------------28<-------------Reclassify First Asset to: Swift
    test('Swift', () async {
      await testReclassify(ClassificationSpecificEnum.swift);
    });

    ///----------------29<-------------Reclassify First Asset to: Tex
    test('Tex', () async {
      await testReclassify(ClassificationSpecificEnum.tex);
    });

    ///----------------30<-------------Reclassify First Asset to: Text
    test('Text', () async {
      await testReclassify(ClassificationSpecificEnum.text);
    });

    test('Asset Create Text', () async {
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
              fragment: SeededFragment(
                string: TransferableString(
                  raw: 'text',
                ),
              ),
            ),
          ),
          type: SeedTypeEnum.ASSET,
        ),
      );
    });
  });
}
