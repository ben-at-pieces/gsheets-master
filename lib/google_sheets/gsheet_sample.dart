// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:googleapis/cloudasset/v1.dart';
import 'package:gsheets/statistics.dart';
import 'package:gsheets/statistics_singleton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Bottom_bar/bottom_appbar_class.dart';
import '../create/create_function.dart';
import '../init/src/gsheets.dart';

void main() async{

  StatisticsSingleton().statistics = await getStats();



  final gsheets = GSheets(credentials);
  final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';
  final ssheet = await gsheets.spreadsheet(spreadsheetID);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      title: 'Flutter App with Sheets Button',
      home: ScaffoldMessenger(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Flutter App with Sheets Button'),
          ),
          body: Builder(builder: (BuildContext context) {
            return ListView(
              children: [
                ListTile(
                  title: TextButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Hold tight while we gather your snapshot!',
                          ),
                          duration: Duration(
                            days: 0,
                            hours: 0,
                            minutes: 0,
                            seconds: 4,
                            milliseconds: 30,
                            microseconds: 10,
                          ),
                        ),
                      );

                      final gsheets = GSheets(credentials);

                      final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';

                      /// get the spreadsheet
                      final ssheet = await gsheets.spreadsheet(spreadsheetID);

                      // /// set default sheet name if not assigned
                      // final sheetName = ssheet.properties.title ?? 'Sheet1';

                      Worksheet? ws = await ssheet.worksheetByTitle('sample');

                      await ws?.values.insertRow(
                        1,
                        [
                          'Languages',
                          'Count',
                          '',
                          'People',
                          'Links',
                          'Tags',
                        ],
                        fromColumn: 1,
                      );

                      await ws?.values.insertColumn(
                        1,
                        [0, 0, 0, 0, 0],
                        fromRow: 1,
                      );

                      ///TODO classifications for in loop logic bake
                      // /// Languages Column
                      // await ws?.values.insertColumn(1, languages, fromRow: 2);
                      //
                      // /// count Column
                      // await ws?.values.insertColumn(2, StatisticsSingleton().statistics?.persons.toList() ?? [], fromRow: 2);

                      /// added a blank placeholder
                      List<String> people =
                          StatisticsSingleton().statistics?.persons.toList() ?? [];
                      people.add('');

                      /// people Column
                      await ws?.values.insertColumn(4, people, fromRow: 2);

                      /// added a blank placeholder
                      List<String> links =
                          StatisticsSingleton().statistics?.relatedLinks.toList() ?? [];
                      links.add('');

                      /// Tags Column
                      await ws?.values.insertColumn(5, links, fromRow: 2);

                      /// added a blank placeholder
                      List<String> tagsList = StatisticsSingleton().statistics?.tags.toList() ?? [];
                      tagsList.add('');

                      /// names Column
                      await ws?.values.insertColumn(6, tagsList, fromRow: 2);


                      List<String> snippetNames = StatisticsSingleton().statistics?.assetNames.toList() ?? [];

                      snippetNames.add('');
                      /// description Column
                      await ws?.values.insertColumn(8, snippetNames, fromRow: 2);


  List<String> snippetDescriptions = StatisticsSingleton().statistics?.assetDescriptions.toList() ?? [];

                      snippetNames.add('');
                      /// tags Column
                      await ws?.values.insertColumn(7, snippetDescriptions, fromRow: 2);

                      /// redirect to gsheets in browser
                      String linkUrl =
                          'https://docs.google.com/spreadsheets/d/18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM/edit#gid=1601436512';

                      linkUrl = linkUrl; //
                      if (await canLaunch(linkUrl)) {
                        await launch(
                          linkUrl,
                        );
                      } else {
                        throw 'Could not launch $linkUrl';
                      }
                    },
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('gsheets.png'),
                        ),
                        Text(
                          'Sheets',
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

// const credentials = r'''
//
// {
//   "type": "service_account",
//   "project_id": "flutter-gsheets-355919",
//   "private_key_id": "336d7cfee18940b61b06e04a92bd48fbc496cb1f",
//   "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDGV8tCv18Ga7Ia\nQxiAI4qtN51UY+AuccMebOFRzOhMT//wTMgDFmuxS90joiRRQjcmTIzuMtBB+/Yy\nUqhklUACg5hxqgMzwMBuzilmGiApQgWuAYWNTw/SbR1ZsUs3UeyzJ88nz6jpyVdH\nQ2FjWyp8gb/HyYirH+09u7LekkWeFETvdQHwlV+PPRrFM9Nt/TH8aoy0PJMcJu4Y\n0KxHW++azYMu6g6JtGMeB7g2Q+k29LlFWkdEqo8eBlWcKruub7or52NVeHu1OIsx\nkTQwuga3TiuSzil/Aqr0bFFqC2aFI2fCv6coC7boszr0y5lT6MPy4ZVE8qG430rN\noBu5p4FJAgMBAAECggEACx2VdxlUK9RyR/WAVIIUE1loDaLb8qO5LHsr9NJ30aW0\nHBVO1O7Mke7vUZVp1Uym3D8dsNBpNSF37oxiV+IOEyCpNPQzDL3zKuKOlbnGGU8p\naVM4LFoEyCVe/Tf/P/ZCk9cZzXXeVgfMxozN/Zb43mnDw+BqsohuBRp/+j2WqDa0\n98rrteWPYMNOoQ6fF8qd9UBOSwr5by7otMzjvzW/L4jRM+ZG6gQeuUCGRU6EDu+H\nrNaFFU9+fMGuK2DGWjtXH6OkOZ/txVIWUhoXTUmA/ATZXi1iN6QE/tjo86AcpVez\nNHOvGGwRns5wRHbqjuFtie3AciyuHy11SaOQPPEPzwKBgQDs5GNEducEVGLO+9FI\nlQ9CeQHznQbmmOowKvLg2Svkdnoe3Q58jPuAqzsNQLjt+BATcrXw9H7j/hh/BPH+\n53QXLbBVtyMTndOFN5VXrY3MgWw1FWRObedfqu2FAjiHq2yDOt8AydyLr8AX58o5\n0kH3Sx5OsHlxdLlL0mgRJOCuUwKBgQDWV2ZMfb1ekIx7gaUqgOTkVeMYJ4kwV00+\n2Ye+2qSOUp5cqSjYxXVlt0Nszyz/xJu4oMfSCFaeSzyMImgeNQb/FL6tb5OoJwR9\nQapyHFqqBVX/5c7ZIAeDRCh84suFeUhDKZds/ClhdWBaaWeHpSdPdYvWWt5N0VVx\nCkjh9+fGcwKBgHYWHzm4v84TtrGRK7EvxMyQ/50NsKvwnATo0+urtkqLmLKb5SXH\nLXPlZ2li0wyk9HaNXw6/AiXquxFOSMeVXvRS7Sy9Pvn/Wbp1i7eKJz5DYcpQYJEM\nDiNNVFtSURWoKU59YT7GYW8sa+g+vjr2ibWZN4FoTRF2awvV1dR9+pZLAoGAVwGV\nYhlshHVywTPIQu+del6u14A8/SWDEq8knkGMqMU6yWxVS2EkHYz9zq5umshJWfHS\nCx0dZBYwVsYks5Zc57CZEjgHnStxdBLyyG1gFEIkPcMgaxzIT+2b7c32RZEM106L\nzE6z0X7fBPRidTqCMYwKnpG2Sape34sIOMn0CKcCgYApU9qSoeZZQYP9xAre4pst\nPoceesDw7IDg9so/i8+GlD1j0GRKexptrY2CVwgGu+6jufJoo9t7qjypV3bMZB5K\nLlWRyBzcIoDt1mPALml67hxG4qnSF3qJDdU187lQzks+CCFJHIbISxxbzqG3M8n/\n1E9ho/2obvQmcz35A9Wm7g==\n-----END PRIVATE KEY-----\n",
//   "client_email": "flutter-gsheets@flutter-gsheets-355919.iam.gserviceaccount.com",
//   "client_id": "101366955861814063269",
//   "auth_uri": "https://accounts.google.com/o/oauth2/auth",
//   "token_uri": "https://oauth2.googleapis.com/token",
//   "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
//   "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheets-355919.iam.gserviceaccount.com"
// }
//
// ''';
// final gsheets = GSheets(credentials);
// final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';


