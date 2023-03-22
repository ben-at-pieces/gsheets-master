// ignore_for_file: omit_local_variable_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'dart:core';
import 'dart:math' as math;
import 'package:connector_openapi/api.dart';
import 'package:gsheets/Tab_Plugins_and_More/plugins_and_more.dart';
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

class OriginChart extends StatelessWidget {
  const OriginChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Pieces Suite',
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 4,
              child: Container(
                color: Colors.white38,
                height: 300,
                width: 800,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: PieChart(
                    ringStrokeWidth: 80,
                    centerText: 'ORIGINS',
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValuesOutside: true,
                      showChartValueBackground: true,
                      decimalPlaces: 0,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                    ),
                    emptyColor: Colors.white,
                    baseChartColor: Colors.black87,
                    centerTextStyle: TitleText(),
                    key: ValueKey(key),
                    dataMap: StatisticsSingleton().statistics!.origins,
                    animationDuration: const Duration(milliseconds: 800),
                    chartLegendSpacing: 100,
                    chartRadius: math.min(MediaQuery.of(context).size.width / 1.5, 150),
                    colorList: originColorList,
                    chartType: ChartType.ring,
                    legendOptions: const LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.left,
                      showLegends: true,
                      legendShape: true ? BoxShape.circle : BoxShape.rectangle,
                      legendTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 9,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

final TextEditingController _textFieldController = TextEditingController();

// Padding(
//   padding: const EdgeInsets.all(15.0),
//   child: Row(
//       children: [
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               height: 18,
//               width: 18,
//               child: Image.asset('Chrome.png'),
//             ),
//             TextButton(
//               child: Text(
//                 'Chrome',
//                 style: ParticleFont.micro(
//                   context,
//                   customization: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 String linkUrl =
//                     'https://chrome.google.com/webstore/detail/pieces-save-code-snippets/igbgibhbfonhmjlechmeefimncpekepm';
//
//                 linkUrl = linkUrl; //Twitter's URL
//                 if (await canLaunch(linkUrl)) {
//                   await launch(
//                     linkUrl,
//                   );
//                 } else {
//                   throw 'Could not launch $linkUrl';
//                 }
//               },
//             ),
//                   ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               height: 18,
//               width: 18,
//               child: Image.asset('Safari.png'),
//             ),
//
//             TextButton(
//               child: Text(
//                 'Safari',
//                 style: ParticleFont.micro(
//                   context,
//                   customization: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 String linkUrl = '';
//
//                 linkUrl = linkUrl; //Twitter's URL
//                 if (await canLaunch(linkUrl)) {
//                   await launch(
//                     linkUrl,
//                   );
//                 } else {
//                   throw 'Could not launch $linkUrl';
//                 }
//               },
//             ),
//                 ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               height: 18,
//               width: 18,
//               child: Image.asset('Firefox.png'),
//             ),
//
//             TextButton(
//               child: Text(
//                 'FireFox',
//                 style: ParticleFont.micro(
//                   context,
//                   customization: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 String linkUrl = '';
//
//                 linkUrl = linkUrl; //Twitter's URL
//                 if (await canLaunch(linkUrl)) {
//                   await launch(
//                     linkUrl,
//                   );
//                 } else {
//                   throw 'Could not launch $linkUrl';
//                 }
//               },
//             ),
//              ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//
//             SizedBox(
//               height: 18,
//               width: 18,
//               child: Image.asset('jetbrains.png'),
//             ),
//             TextButton(
//               child: Text(
//                 'JetBrains',
//                 style: ParticleFont.micro(
//                   context,
//                   customization: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 String linkUrl = '';
//
//                 linkUrl = linkUrl; //Twitter's URL
//                 if (await canLaunch(linkUrl)) {
//                   await launch(
//                     linkUrl,
//                   );
//                 } else {
//                   throw 'Could not launch $linkUrl';
//                 }
//               },
//             ),
//                ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//               height: 18,
//               width: 18,
//               child: Image.asset('vscode.png'),
//             ),
//
//             TextButton(
//               child: Text(
//                 'VS Code',
//                 style: ParticleFont.micro(
//                   context,
//                   customization: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 String linkUrl = '';
//
//                 linkUrl = linkUrl; //Twitter's URL
//                 if (await canLaunch(linkUrl)) {
//                   await launch(
//                     linkUrl,
//                   );
//                 } else {
//                   throw 'Could not launch $linkUrl';
//                 }
//               },
//             ),
//              ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//                 height: 25,
//                 width: 25,
//                 child: Image.asset('roundedpfd.png')),  TextButton(
//               child: Text(
//                 'Pieces',
//                 style: ParticleFont.micro(
//                   context,
//                   customization: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 String linkUrl = '';
//
//                 linkUrl = linkUrl; //Twitter's URL
//                 if (await canLaunch(linkUrl)) {
//                   await launch(
//                     linkUrl,
//                   );
//                 } else {
//                   throw 'Could not launch $linkUrl';
//                 }
//               },
//             ),
//
//           ],
//         ),
//         Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             SizedBox(
//                 height: 25,
//                 width: 25,
//                 child: Image.asset('terminal.png')),    TextButton(
//               child: Text(
//                 'CLI',
//                 style: ParticleFont.micro(
//                   context,
//                   customization: TextStyle(
//                     color: Colors.white,
//                     fontSize: 10,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               onPressed: () async {
//                 String linkUrl = '';
//
//                 linkUrl = linkUrl; //Twitter's URL
//                 if (await canLaunch(linkUrl)) {
//                   await launch(
//                     linkUrl,
//                   );
//                 } else {
//                   throw 'Could not launch $linkUrl';
//                 }
//               },
//             ),
//
//           ],
//         ),
//       ]),
// ),
