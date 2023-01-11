import 'dart:io';

import 'package:connector_openapi/api.dart' hide Tags;
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api.dart';

import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart' hide Tags;

/// create an asset
/// add 4 people
/// add two people with emojis attached


Future<void> main() async {
  String port = '1000';
  String host = 'http://localhost:$port';
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
  final PersonsApi personsApi = PersonsApi(ApiClient(basePath: host));


  group('Related People Bug - EMOJIS', () {
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

    ///^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^   /person/create [POST]   v^v^^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^v^
    group('Persons0 add', () {

      /// -> these peeps are cool
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

      /// -> these peeps are bugging
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
                url: 'google.com/',
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

    });
  });
}
