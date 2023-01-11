import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:test/test.dart';

/// TODO check performance && more robust edge case testing.
/// This will check the person api.
/// routes:
/// '/person/update [POST]'
/// '/person/{person} [GET]'
void main() {
  String port = '1000';
  String host = 'http://localhost:$port';
  final PersonsApi personsApi = PersonsApi(ApiClient(basePath: host));
  final PersonApi personApi = PersonApi(ApiClient(basePath: host));

  /// TODO check all the properties we updated are properly updated.
  test('/person/update [POST]', () async {
    /// (1) call our snapshot to get the first asset, so we can update.
    Persons persons = await personsApi.personsSnapshot();
    if (persons.iterable.isEmpty) {
      throw Exception('/person/update [POST] FAILED, b/c our iterable is empty and cannot truely test our test.');
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

  /// TODO edge case testing if it is empty, if it doesnt exist...
  test('/persons/{person} [GET]', () async {
    /// (1) call our snapshot
    Persons persons = await personsApi.personsSnapshot();

    if (persons.iterable.isEmpty) {
      throw Exception(
        '/person/{person} [GET] FAILED, b/c our iterable is empty and cannot truely test our test.',
      );
    }

    /// (2) get the first person we have, and all the specific person snapshot api.
    await personApi.personSnapshot(persons.iterable.first.id);
  });
}
