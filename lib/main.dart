// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:gsheets/statistics.dart';
import 'package:gsheets/statistics_singleton.dart';

import 'TabAppBar.dart';
import 'create/create_function.dart';
import 'init/src/gsheets.dart';

void main() async {
  StatisticsSingleton().statistics = await getStats();

  final gsheets = GSheets(credentials);
  final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';
  final ssheet = await gsheets.spreadsheet(spreadsheetID);
  runApp(
    MyApp(),
  );
}

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

