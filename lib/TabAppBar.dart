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
import 'Language_Pie_List/pieChartWidget.dart';
import 'Tab_Activity_Bar_Chart/bar_chart.dart';
import 'Tab_Origin_Pie_Chart/originPieChart.dart';
import 'Tab_Plugins_and_More/plugins_and_more.dart';
import 'Tab_Related_Links_List/related_links_List.dart';
import 'Tab_Tags_List/tags_list.dart';
import 'boot.dart';
import 'materials/materials.dart';


enum LegendShape { circle, rectangle }

String host = 'http://localhost:1000';
AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));
ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: 'http://localhost:1000'));
UsersApi usersApi = UsersApi(ApiClient(basePath: host));
UserApi userApi = UserApi(ApiClient(basePath: host));
// Assets assetsSnapshot = await assetsApi.assetsSnapshot();
// Asset asset = assetsSnapshot.iterable.elementAt(index);
// List assetsSnapshot = [];
 Future<List> assetsSnapshotFuture = Boot().getAssets();
ApiClient api = ApiClient(basePath: 'http://localhost:1000');

class TabAppBar extends StatefulWidget {
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<TabAppBar> {
  ApiClient api = ApiClient(basePath: 'http://localhost:1000');

  int key = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 8,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: TabBar(
              indicatorColor: Colors.black,
              tabs: [
                Text(
                  'Materials',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                //   Text(
                //     'List',
                // style:  TextStyle(
                //   color: Colors.black,
                //   fontSize: 10,
                // ),
                //     ),
                Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                Text(
                  'languages',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),

                Text(
                  'Origins',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                Text(
                  'Activity',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),

                Text(
                  'Links',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),

                Text(
                  'Tags',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
                Text(
                  'Plugins',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                ),
              ],
            ), // TabBar
          ), // AppBar
          body: TabBarView(
            children: [
              /// Related TAGS ==========================================================


              MaterialsPage(),

              /// Home Dash
              Dashboard(),

              /// vertical gridview
              // MyDashBoard(),






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
               TagsListWidget(),


              /// Plugins & More ==========================================================
              Plugins(),


              /// json ===================================================================
              // LanguagesGrid(),
            ],
          ), // TabBarView
        ), // Scaffold
      ), // DefaultTabController
    );
  }
}
