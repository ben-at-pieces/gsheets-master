// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:gsheets/statistics.dart';
import 'package:gsheets/statistics_singleton.dart';

import 'TabAppBar.dart';
import 'create/create_function.dart';
import 'init/src/gsheets.dart';
import 'materials/material_list.dart';

 // This code initializes a statistics singleton with data fetched asynchronously, sets up a connection to a Google Sheets spreadsheet using credentials, and runs a Flutter app.
void main() async {
  StatisticsSingleton().statistics = await getStats();



  final gsheets = GSheets(credentials);
  final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';
  final ssheet = await gsheets.spreadsheet(spreadsheetID);

  // print(programmingLanguages.toString());

  runApp(
    MyApp(),
  );
}

 // This is a class that returns a MaterialApp widget with a dark theme and a TabAppBar as the home screen. The debug banner is disabled and the app's title is set to "Pieces Pie Chart".
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pieces Pie Chart',
      // theme: ParticleTheme.lightPalette(context),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: TabAppBar(),
    );
  }
}

