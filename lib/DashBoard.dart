// import 'package:connector_openapi/api_client.dart';
// ignore_for_file: omit_local_variable_types, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:gsheets/statistics.dart';
import 'package:gsheets/statistics_singleton.dart';

import 'Bottom_bar/bottom_appbar_class.dart';
import '../Tab_DashBoard/dashBoardBody.dart';
import 'CustomAppBar.dart';

void main() async {
  StatisticsSingleton().statistics = await getStats();
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Dashboard(),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}

 // This is a class that extends StatefulWidget and builds a dashboard with a custom app bar and bottom navigation bar. It also has a string input and a list of related items.
class Dashboard extends StatefulWidget {
  @override
  _RelatedItemsState createState() => _RelatedItemsState();
}

class _RelatedItemsState extends State<Dashboard> {
  String input = '';
  List<String> related = [];

  @override
  Widget build(BuildContext context) {
    // appBar: CustomAppBar(
    //   title: 'User Tags',
    // ),
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Search',
      ),
      body: DashboardBody(),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }


}
