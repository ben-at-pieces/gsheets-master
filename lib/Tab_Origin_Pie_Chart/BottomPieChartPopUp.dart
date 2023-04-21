

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
import '../create/reclassify/GSheetConnection.dart';
import '../Tab_Activity_Bar_Chart/colors.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../statistics_singleton.dart';


class BottomPieChart extends StatelessWidget {
   BottomPieChart({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black87,
      // appBar: CustomAppBar(title: 'Snippet Classifications',),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [

            SizedBox(height: 10),
            Container(
              height: 24,
              color: Colors.white,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon:  Icon(Icons.close, color: Colors.black, size: 15),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Languages', style: TitleBlackText(),),
                Text('Origins', style: TitleBlackText(),),
              ],
            ),


             SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 220,
                  width: 250,
                  child: PieChart(
                    centerText: 'TOTAL: ${StatisticsSingleton().statistics?.snippetsSaved}',
                    ringStrokeWidth: 60,
                    chartValuesOptions:  ChartValuesOptions(
                      showChartValuesOutside: true,
                      showChartValueBackground: true,
                      decimalPlaces: 0,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                    ),
                    emptyColor: Colors.grey,
                    baseChartColor: Colors.black12,
                    centerTextStyle:  TitleText(),
                    key: ValueKey(key),
                    dataMap: StatisticsSingleton().statistics!.classifications,
                    animationDuration:  Duration(milliseconds: 800),
                    chartLegendSpacing: 15,
                    chartRadius: math.min(MediaQuery.of(context).size.width / 3, 150),
                    colorList: colorList,
                    chartType: ChartType.ring,
                    legendOptions:  LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.left,
                      showLegends: true,
                      legendShape: true ? BoxShape.circle : BoxShape.rectangle,
                      legendTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 220,
                  width: 400,
                  child: PieChart(
                    ringStrokeWidth: 60,
                    centerText: 'ORIGINS',
                    chartValuesOptions:  ChartValuesOptions(
                      showChartValuesOutside: false,
                      showChartValueBackground: true,
                      decimalPlaces: 0,
                      showChartValues: true,
                      showChartValuesInPercentage: false,
                    ),
                    emptyColor: Colors.white,
                    baseChartColor: Colors.black87,
                    centerTextStyle:  TitleText(),
                    key: ValueKey(key),
                    dataMap: StatisticsSingleton().statistics!.origins,
                    animationDuration:  Duration(milliseconds: 800),
                    chartLegendSpacing: 25,
                    chartRadius: math.min(MediaQuery.of(context).size.width / 3, 150),
                    colorList: originColorList,
                    chartType: ChartType.ring,
                    legendOptions:  LegendOptions(
                      showLegendsInRow: false,
                      legendPosition: LegendPosition.left,
                      showLegends: true,
                      legendShape: true ? BoxShape.circle : BoxShape.rectangle,
                      legendTextStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
             SizedBox(height: 10),


          ],
        ),

      ),
    );
  }
}