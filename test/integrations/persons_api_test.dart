import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the sensitives api.
/// routes:
/// '/persons/create [POST]'
/// '/persons [GET]'
/// '/persons/{person}/delete [POST]'
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final PersonsApi personsApi = PersonsApi(ApiClient(basePath: host));
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

  /// TODO check our edge cases what if an asset isn't present??
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

  /// TODO check our edge cases (empty)
  test('/persons [GET]', () async {
    /// (1) call /sensitives endpoint
    Persons persons = await personsApi.personsSnapshot();

    /// expect RuntimeType: Person
    /// TODO check transferables false && true...
    expect(persons.runtimeType, Persons);
  });

  /// TODO check edge cases if the person doesnt exist.
  test('/persons/{person}/delete [POST]', () async {
    /// (1) call /persons endpoint
    Persons persons = await personsApi.personsSnapshot();

    if (persons.iterable.isEmpty) {
      throw Exception(
        '/persons/{person}/delete [POST] FAILED, b/c our iterable is empty and cannot truely test our test.',
      );
    }

    /// (2) delete the first sensitive we have.
    await personsApi.personsDeletePerson(persons.iterable.first.id);

    /// tODO check the person got removed off of the Asset && if it is a creator then the creator was reset on the asset.
  });
}
