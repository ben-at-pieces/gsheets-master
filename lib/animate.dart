// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:core_openapi/api.dart';
import 'package:core_openapi/api_client.dart';

class AddPersonButton extends StatelessWidget {
  final PersonsApi personsApi;
  final String assetId;

  AddPersonButton({required this.personsApi, required this.assetId});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        _showAddPersonDialog(context);
      },
      icon: Icon(Icons.people_outline),
    );
  }

  void _showAddPersonDialog(BuildContext context) {
    String name = '';
    String email = '';

    showDialog(
      context: context,
      builder: (BuildContext context) {

        return AlertDialog(
          title: Text('Add Person'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(labelText: 'Email'),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                final Person created = await personsApi.personsCreateNewPerson(
                  seededPerson: SeededPerson(
                    access: PersonAccess(),
                    type: PersonType(
                      basic: PersonBasicType(
                        username: '@$name',
                        name: name,
                        email: email,
                        picture: '',
                        url: '',
                      ),
                    ),
                    asset: assetId,
                    mechanism: MechanismEnum.MANUAL,
                  ),
                );
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Person $name created!'),
                  ),
                );
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
