// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/pie/c_.dart';
import 'package:gsheets/pie/pieChart.dart';

import 'batch_file.dart';
import 'dataMap.dart';
import 'languages_list.dart';

void main() async {
  print('gathering your snippets');

  ApiClient api = ApiClient(basePath: 'http://localhost:1000');

  BatchFileSnips launch = BatchFileSnips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  List<double> dubList = [batchCount.toDouble()];
  dubList.add(batchCount);
  List<double> doublesList = dubList;
  final dataMap = <String, double>{
    Languages.elementAt(0): doublesList.first,
  };

  await assets();

  runApp(const MyApp());
}

batch() async {
  C__Snips launch = C__Snips(api: api);
  double bats = await launch.run();
}

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
