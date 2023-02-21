// ignore_for_file: omit_local_variable_types, prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, use_key_in_widget_constructors

import 'dart:core';

import 'package:connector_openapi/api/connector_api.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart' hide Tags;
import 'package:core_openapi/api/user_api.dart';
import 'package:core_openapi/api/users_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';

import 'DashBoard.dart';
import 'Dashboard/vertical_language_tabs.dart';
import 'Language_Pie_List/pieChartWidget.dart';
import 'Tab_Activity_Bar_Chart/bar_chart.dart';
import 'Tab_Origin_Pie_Chart/originPieChart.dart';
import 'Tab_Plugins_and_More/plugins_and_more.dart';
import 'Tab_Related_Links_List/related_links_List.dart';
import 'boot.dart';
import 'jscon_converter/tree_from_json.dart';


enum LegendShape { circle, rectangle }

String host = 'http://localhost:800';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));
ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: 'http://localhost:800'));
UsersApi usersApi = UsersApi(ApiClient(basePath: host));
UserApi userApi = UserApi(ApiClient(basePath: host));
// Assets assetsSnapshot = await assetsApi.assetsSnapshot();
// Asset asset = assetsSnapshot.iterable.elementAt(index);
// List assetsSnapshot = [];
late Future<List> assetsSnapshotFuture = Boot().getAssets();
ApiClient api = ApiClient(basePath: 'http://localhost:800');

class TabAppBar extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<TabAppBar> {
  ApiClient api = ApiClient(basePath: 'http://localhost:800');

  int key = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black87,
            title: TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Text(
                  'Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                //   Text(
                //     'List',
                // style:  TextStyle(
                //   color: Colors.white,
                //   fontSize: 8,
                // ),
                //     ),
                Text(
                  'Grid',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                Text(
                  'Chart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),

                Text(
                  'Origins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                Text(
                  'Activity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),

                Text(
                  'Links',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                // Text(
                //   'People',
                //   style:  TextStyle(
                //     color: Colors.white,
                //     fontSize: 8,
                //   ),
                // ),
                Text(
                  'Plugins',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
                Text(
                  'JSON',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  ),
                ),
              ],
            ), // TabBar
          ), // AppBar
          body: TabBarView(
            children: [
              /// Related TAGS ==========================================================
              // TagsListWidget(),


              /// Home Dash
              Dashboard(),


              MyDashBoard(),



              /// Language Pie Chart ==========================================================
              MyPieChart(),

              /// origin classification ==========================================================
              OriginChart(),

              /// Vertical bar graph ==========================================================
              BarGraph(),

              /// Related Links ==========================================================
              RelatedLinksWidget(),

              /// Related Links ==========================================================
              // HomeLanguageBuilder(subtitle: 'Home', leading: Image.asset('APFD.jpg'),),
              /// Plugins & More ==========================================================
              Plugins(),

              /// json ===================================================================
              TreeFromJson(),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    );
  }
}