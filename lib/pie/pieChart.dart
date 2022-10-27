// ignore_for_file: omit_local_variable_types

import 'dart:core';
import 'dart:math' as math;

import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'colors.dart';
import 'dataMap.dart';
import 'languages/batch_file.dart';

enum LegendShape { circle, rectangle }

String host = 'http://localhost:1000';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));

ApiClient api = ApiClient(basePath: 'http://localhost:1000');
BatchFileSnips launch = BatchFileSnips(api: api);
// Coffee__Snips launch3 = Coffee__Snips(api: api);
void main() async {
  // double bats = await launch.run();
  // double coffee = await launch.run();
}

class HomePage extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  ApiClient api = ApiClient(basePath: 'http://localhost:1000');

  int key = 0;

  @override
  Widget build(BuildContext context) {
    final settings = SingleChildScrollView();
    return Scaffold(
      appBar: AppBar(
        title: const Text('pieces.app'),
        actions: [
          ElevatedButton(
            onPressed: () {
              setState(() {
                key = key + 1;
              });
            },
            child: Text('Reload'.toUpperCase()),
          ),
        ],
      ),
      body: PieChart(
        key: ValueKey(key),
        dataMap: dataMap,
        animationDuration: const Duration(milliseconds: 800),
        chartLegendSpacing: 50,
        chartRadius: math.min(MediaQuery.of(context).size.width / 1.2, 190),
        colorList: colorList,
        chartType: ChartType.ring,
        centerText: true ? 'Snippets' : null,
        legendOptions: const LegendOptions(
          showLegendsInRow: false,
          legendPosition: LegendPosition.right,
          showLegends: true,
          legendShape: true ? BoxShape.rectangle : BoxShape.rectangle,
          legendTextStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
        chartValuesOptions: const ChartValuesOptions(
          showChartValuesOutside: true,
          showChartValueBackground: true,
          decimalPlaces: 0,
          showChartValues: true,
          showChartValuesInPercentage: false,
        ),
        ringStrokeWidth: 50,
        emptyColor: Colors.grey,
        emptyColorGradient: const [
          Color(0xff6c5ce7),
        ],
        baseChartColor: Colors.transparent,
      ),
    );
  }

  Future<double> run() async {
    //====================================================================
    ///Step (2) snapshot
    Assets assets = await assetsApi.assetsSnapshot();

    List<Asset> assetCount = assets.iterable;

    List<Asset> filterBatchFile = assetCount
        .where((element) =>
            element.original.reference?.classification.specific == ClassificationSpecificEnum.bat)
        .toList();

    double filter = filterBatchFile.length.toDouble();

    print(filter);

    return filter;
  }
}
