// ignore_for_file: omit_local_variable_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:core';
import 'dart:math' as math;
import 'package:connector_openapi/api.dart';
import 'package:gsheets/Tab_Plugins_and_More/plugins_and_more.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:runtime_client/particle.dart';
import 'package:flutter/services.dart';

import '../CustomAppBar.dart';
import '../Dashboard/custom_classes.dart';
import '../Tab_Activity_Bar_Chart/colors.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../statistics_singleton.dart';

// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const MyDataTable(),
//       ),
//     );
//   }
// }

class MyPieChart extends StatelessWidget {
  const MyPieChart({super.key});

  get index => imgList1.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomAppBar(),
      // backgroundColor: Colors.black87,
      appBar: CustomAppBar(
        title: 'Snippet Classifications',
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: Colors.white,
          elevation: 4,
          child: Container(
            height: 450,

            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10),
                  child: Container(
                    height: 300,
                    width: 800,
                    child: PieChart(
                      centerText: 'TOTAL: ${StatisticsSingleton().statistics?.snippetsSaved}',
                      ringStrokeWidth: 80,
                      chartValuesOptions: const ChartValuesOptions(
                        showChartValuesOutside: true,
                        showChartValueBackground: true,
                        decimalPlaces: 0,
                        showChartValues: true,
                        showChartValuesInPercentage: false,
                      ),
                      emptyColor: Colors.grey,
                      baseChartColor: Colors.black45,
                      centerTextStyle: TitleText(),
                      key: ValueKey(key),
                      dataMap: StatisticsSingleton().statistics!.classifications,
                      animationDuration: const Duration(milliseconds: 800),
                      chartLegendSpacing: 100,
                      chartRadius: math.min(MediaQuery.of(context).size.width / 1.5, 150),
                      colorList: colorList,
                      chartType: ChartType.ring,
                      legendOptions: const LegendOptions(
                        showLegendsInRow: false,
                        legendPosition: LegendPosition.left,
                        showLegends: true,
                        legendShape: true ? BoxShape.circle : BoxShape.rectangle,
                        legendTextStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   color: Colors.white,
                //   child: MyAppSnippets(),
                // ),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class Language {
  List languages = [
    'batchfile',
    'c',
    'sharp',
    'coffees',
    'cpp',
    'css',
    'dart',
    'erlang',
    'go',
    'haskell',
    'html',
    'java',
    'javascript',
    'json',
    'lua',
    'markdown',
    'matlab',
    'objective-c',
    'perl',
    'php',
    'powershell',
    'python',
    'r',
    'ruby',
    'rust',
    'scala',
    'sql',
    'swift',
    'typescript',
    'tex',
    'text',
    'toml',
    'yaml',
  ];
}

List imgList1 = [
  Image.asset('batchfile-black.jpg'),
  Image.asset('c.jpg'),
  Image.asset('c-sharp.jpg'),
  Image.asset('coffeescript-black.jpg'),
  Image.asset('cpp.jpg'),
  Image.asset('css.jpg'),
  Image.asset('dart.jpg'),
  Image.asset('erlang.jpg'),
  Image.asset('go.jpg'),
];

List imgList2 = [
  Image.asset('haskell.jpg'),
  Image.asset('html.jpg'),
  Image.asset('java.jpg'),
  Image.asset('javascript.jpg'),
  Image.asset('json.jpg'),
  Image.asset('lua.jpg'),
  Image.asset('markdown-black.jpg'),
  Image.asset('matlab.jpg'),
  Image.asset('objective-c.jpg'),
];

List imgList3 = [
  Image.asset('objective-c.jpg'),
  Image.asset('perl.jpg'),
  Image.asset('php.jpg'),
  Image.asset('powershell.jpg'),
  Image.asset('python.jpg'),
  Image.asset('r.jpg'),
  Image.asset('ruby.jpg'),
  Image.asset('rust-black.jpg'),
  Image.asset('scala.jpg'),
];
List imgList4 = [
  Image.asset('sql.jpg'),
  Image.asset('swift.jpg'),
  Image.asset('typescript.jpg'),
  Image.asset('tex-black.jpg'),
  Image.asset('text.jpg'),
  Image.asset('toml-black.jpg'),
  Image.asset('yaml-black.jpg'),
];


