// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/pie/pieChart.dart';

import 'dataMap.dart';

void main() async {
  print('gathering your snippets');

  ApiClient api = ApiClient(basePath: 'http://localhost:1000');

  await batch_file_();
  await c_();
  await cSharp_();
  await coffee_();
  // await cPP_;
  await cSS_();
  // await dartCount();

  runApp(const MyApp());
}

// batch() async {
//   C_Snips launch = C_Snips(api: api);
//   double bats = await launch.c__();
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pie Chart Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.blueGrey,
        brightness: Brightness.dark,
      ),
      home: HomePage(),
    );
  }
}
