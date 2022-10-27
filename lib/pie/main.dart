// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/pie/pieChart.dart';

import 'dataMap.dart';

void main() async {
  // await create();
  print('gathering your snippets');

  ApiClient api = ApiClient(basePath: 'http://localhost:1000');

  await batch_file_();
  await c_();
  await cPP_();
  await coffee_();
  await cSharp_();
  await cSS_();
  await dartCount();
  await erlang_();
  await go_();
  await haskell_();
  await html_();
  await image_();
  await java_();
  await json_();
  await javascript_();
  await lua_();
  await markdown_();
  await matlab_();
  await objective_c_();
  await perl_();
  await php_();
  await powerShell_();
  await python_();
  await r_();
  await ruby_();
  await rust_();
  await scala_();
  await shell_();
  await sql_();
  await swift_();
  await tex_();
  await text_();
  await toml_();
  await typeScript_();
  await yaml_();
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
