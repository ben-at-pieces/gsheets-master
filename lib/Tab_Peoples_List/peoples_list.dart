import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Bottom_bar/bottom_appbar_class.dart';
import '../Tab_DashBoard/checkbox_class.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../statistics_singleton.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

// This widget is the root
// of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: "ListView.builder",
        theme: ThemeData(primarySwatch: Colors.green),
        debugShowCheckedModeBanner: false,
        // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
        home: PeoplesListWidget());
  }
}

class PeoplesListWidget extends StatelessWidget {
  PeoplesListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: CustomAppBar(title: 'Related People',),
      body: Container(
height: 50,
        width: 450,
        color: Colors.black12,
        child: ListView.builder(
            itemCount: StatisticsSingleton().statistics?.persons.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                tileColor: Colors.white,
                leading: Icon(
                  Icons.account_circle_sharp,
                  color: Colors.black,
                ),
                title: Text(
                  '${StatisticsSingleton().statistics?.persons.elementAt(index)}  ',
                  style:
                  ParticleFont.bodyText1(context, customization: TextStyle(color: Colors.black)),
                ),
                trailing: MyCheckBoxWidgget(),
              );
              // title: Text('Person: $index'));
            }),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
