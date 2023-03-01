// ignore_for_file: omit_local_variable_types

import 'package:connector_openapi/api.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/statistics_singleton.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Dashboard/custom_classes.dart';
import '../Dashboard/faqs.dart';
import '../Language_Pie_List/pieChartWidget.dart';
import '../Tab_Plugins_and_More/plugins_and_more.dart';
import '../create/create_function.dart';
import '../init/src/gsheets.dart';
import '../lists/relatedLists.dart';

class CustomBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 50,
      child: BottomAppBar(
        notchMargin: 5,
        color: Colors.black87,
        elevation: 5,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: Image.asset('wordmark_white_filled.png'),
                    ),
                    Text(
                      '',
                    ),
                  ],
                ),
                onPressed: () async {
                  String linkUrl = 'https://code.pieces.app/install';

                  linkUrl = linkUrl; //Twitter's URL
                  if (await canLaunch(linkUrl)) {
                    await launch(
                      linkUrl,
                    );
                  } else {
                    throw 'Could not launch $linkUrl';
                  }
                },
              ),
              SizedBox(
                width: 250,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ParticleButton(
                    text: '${StatisticsSingleton().statistics?.classifications}',
                    backgroundColor: Colors.white,
                    overlayColor: Colors.grey,
                    textColor: Colors.black,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 500,
                            width: 300,
                            child: Center(
                              child: BottomPieChart(),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ),

              /// docs
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: TextButton(
                    onPressed: () async {
                      /// redirect to docs in browser
                      String linkUrl = 'https://docs.google.com/document/u/0/?tgif=d';

                      linkUrl = linkUrl; //Twitter's URL
                      if (await canLaunch(linkUrl)) {
                        await launch(
                          linkUrl,
                        );
                      } else {
                        throw 'Could not launch $linkUrl';
                      }
                    },
                    child: Image.asset('docs.png'),
                  ),
                ),
              ),

              /// sheets
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: TextButton(
                    onPressed: () async {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'hold tight while we gather your snapshot!',
                          ),
                          duration: Duration(
                              days: 0,
                              hours: 0,
                              minutes: 0,
                              seconds: 4,
                              milliseconds: 30,
                              microseconds: 10),
                        ),
                      );

                      final gsheets = GSheets(credentials);

                      final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';

                      /// get the spreadsheet
                      final ssheet = await gsheets.spreadsheet(spreadsheetID);

                      Worksheet? ws = await ssheet.worksheetByTitle('Indy');

                      // Clear the sheet data

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
                          fromColumn: 1);

                      await ws?.values.insertColumn(1, [0, 0, 0, 0, 0], fromRow: 1);

                      /// Languages Column
                      await ws?.values.insertColumn(1, languages, fromRow: 2);

                      /// count Column
                      await ws?.values.insertColumn(2, languageCounts, fromRow: 2);

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

                      /// tags Column
                      await ws?.values.insertColumn(6, tagsList, fromRow: 2);

                      List <String> assetsList = [];
                      int index1 = assetsList.length;
                      List<Asset> assets = StatisticsSingleton().statistics?.asset ?? [];
                     var name = assets.elementAt(index1).name;
                      for (Asset name in assets) {
                        name.name;
                      }
                      assetsList.add(name.toString());







                      /// names Column
                      await ws?.values.insertColumn(7, assetsList.toList(), fromRow: 2);

                      /// redirect to gsheets in browser
                      String linkUrl =
                          'https://docs.google.com/spreadsheets/d/18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM/edit#gid=1601436512';

                      linkUrl = linkUrl; //Twitter's URL
                      if (await canLaunch(linkUrl)) {
                        await launch(
                          linkUrl,
                        );
                      } else {
                        throw 'Could not launch $linkUrl';
                      }
                    },
                    child: Image.asset('gsheets.png'),
                  ),
                ),
              ),

              /// calendar
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: TextButton(
                    onPressed: () async {
                      /// redirect to gsheets in browser
                      String linkUrl = 'https://calendar.google.com/calendar/u/0/r';

                      linkUrl = linkUrl; //Twitter's URL
                      if (await canLaunch(linkUrl)) {
                        await launch(
                          linkUrl,
                        );
                      } else {
                        throw 'Could not launch $linkUrl';
                      }
                    },
                    child: Image.asset('calendar.png'),
                  ),
                ),
              ),

              /// teams
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: TextButton(
                    onPressed: () async {
                      /// redirect to gsheets in browser
                      String linkUrl = '';

                      linkUrl = linkUrl; //Twitter's URL
                      if (await canLaunch(linkUrl)) {
                        await launch(
                          linkUrl,
                        );
                      } else {
                        throw 'Could not launch $linkUrl';
                      }
                    },
                    child: Image.asset('teams.png'),
                  ),
                ),
              ),

              /// drive
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 35,
                  width: 35,
                  child: TextButton(
                    onPressed: () async {
                      /// redirect to gsheets in browser
                      String linkUrl = 'https://drive.google.com/drive/u/0/my-drive';

                      linkUrl = linkUrl; //Twitter's URL
                      if (await canLaunch(linkUrl)) {
                        await launch(
                          linkUrl,
                        );
                      } else {
                        throw 'Could not launch $linkUrl';
                      }
                    },
                    child: Image.asset('drive.png'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}

final TextEditingController _textFieldController = TextEditingController();

const String port = '1000';
const String host = 'http://localhost:$port';

/// Future instance of Connect to be used in connectorApi Tests ->->->->->->->->->->->->->->->->->->->->->->->->->->->->->->
Future<Context> connect() async {
  final ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: host));

  final ApplicationsApi applicationsApi =
      ApplicationsApi(ApiClient(basePath: 'http://localhost:1000'));
  Applications snapshot = await applicationsApi.applicationsSnapshot();

  List<Application> applicationsList = snapshot.iterable.toList();

  Application first = applicationsList.first;
  try {
    return connectorApi.connect(
      seededConnectorConnection: SeededConnectorConnection(
        application: SeededTrackedApplication(
          capabilities: CapabilitiesEnum.BLENDED,
          schema: first.schema,
          name: first.name,
          platform: first.platform,
          version: first.version,
        ),
      ),
    );
    // print('======== $connect');
  } catch (err) {
    throw Exception('Error occurred when establishing connection. error:$err');
  }
}

List<String> collection = [
  'C',
  'C#',
  'CoffeeScript',
  'C++',
  'CSS',
  'Dart',
  'Erlang',
  'Go',
  'Haskell',
  'HTML',
  'Java',
  'JavaScript',
  'json',
  'Lua',
  'Markdown',
  'MatLab',
  'objective C',
  'PHP',
  'Perl',
  'Powershell',
  'Python',
  'R',
  'Ruby',
  'Rust',
  'Scala',
  'Shell',
  'SQL',
  'Swift',
  'TypeScript',
  'TeX',
  'Text',
  'TOML',
  'Yaml',
  'Image',
];

List<String> languageCounts = [
  '${StatisticsSingleton().statistics?.batch.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.c.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.cSharp.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.coffee.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.cPlus.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.css.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.dart.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.erlang.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.go.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.haskell.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.html.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.java.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.javascript.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.json.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.lua.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.markdown.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.matLab.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.objectiveC.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.php.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.perl.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.powershell.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.python.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.r.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.ruby.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.rust.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.scala.toList().length ?? 0}',
  // '${StatisticsSingleton().statistics?.shell.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.sql.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.swift.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.typescript.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.tex.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.text.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.toml.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.yaml.toList().length ?? 0}',
  '${StatisticsSingleton().statistics?.image.toList().length ?? 0}'
];

List<String> languages = [
  'Batchfile',
  'C',
  'C#',
  'CoffeeScript',
  'C++',
  'CSS',
  'Dart',
  'Erlang',
  'Go',
  'Haskell',
  'HTML',
  'Java',
  'JavaScript',
  'json',
  'Lua',
  'Markdown',
  'MatLab',
  'objective C',
  'PHP',
  'Perl',
  'Powershell',
  'Python',
  'R',
  'Ruby',
  'Rust',
  'Scala',
  // 'Shell',
  'SQL',
  'Swift',
  'TypeScript',
  'TeX',
  'Text',
  'TOML',
  'Yaml',
  'Images',
];
