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
import '../Tab_Origin_Pie_Chart/BottomPieChartPopUp.dart';
import '../Tab_Plugins_and_More/pluginButton.dart';
import '../Tab_Plugins_and_More/plugins_and_more.dart';
import '../create/create_function.dart';
import '../google_sheets/Pieces_for_X.dart';
import '../google_sheets/Teams.dart';
import '../google_sheets/chrome.dart';
import '../google_sheets/jetbrains.dart';
import '../google_sheets/vs_code.dart';
import '../init/src/gsheets.dart';
import '../lists/relatedLists.dart';

class CustomBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 50,
      child: // A bottom app bar with a notch margin of 5, white background color, and an elevation of 5
      BottomAppBar(
        notchMargin: 5,
        color: Colors.white,
        elevation: 5,
        child: SingleChildScrollView(
          // A scrollable view with horizontal scrolling
          scrollDirection: Axis.horizontal,
          child: Row(
            // Center the row horizontally and vertically
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 15,),
              // A card with an elevation of 4, black shadow color, and white background color
              Container(
                color: Colors.white,
                width: 500,
                child: SingleChildScrollView(
                  // A scrollable view with horizontal scrolling
                  scrollDirection: Axis.horizontal,
                  child: TextButton(
                    // A particle button with a false rounded value, a text value of the number of classifications, a white background color, black text color, and a function to show a bottom sheet when pressed
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            height: 500,
                            width: 320,
                            child: Center(
                              child: BottomPieChart(),
                            ),
                          );
                        },
                      );
                    },
                    child: Text('${StatisticsSingleton().statistics?.classifications}',
                        style: TitleText(),
                    ),
                  ),
                ),
              ),
              // Other widgets such as Pieces_Gsheets(), VSCodeAlertDialog(), JetBrainsAlertDialog(), and ChromeAlertDialog()
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Pieces_Gsheets(),
                  VSCodeAlertDialog(),
                  JetBrainsAlertDialog(),
                  ChromeAlertDialog(),
                  Teams_Gsheets(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 35,
                      width: 35,
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
                          // Code to insert data into a Google Sheets spreadsheet
                        },
                        child: Image.asset('gsheets.png'),
                      ),
                    ),
                  ),  ],
              ),

              // A button with an image of Google Sheets that inserts data into a Google Sheets spreadsheet when pressed

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

// List<String> languageCounts = [
//   '${StatisticsSingleton().statistics?.batch.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.c.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.cSharp.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.coffee.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.cPlus.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.css.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.dart.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.erlang.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.go.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.haskell.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.html.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.java.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.javascript.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.json.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.lua.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.markdown.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.matLab.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.objectiveC.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.php.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.perl.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.powershell.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.python.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.r.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.ruby.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.rust.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.scala.toList().length ?? 0}',
//   // '${StatisticsSingleton().statistics?.shell.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.sql.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.swift.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.typescript.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.tex.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.text.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.toml.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.yaml.toList().length ?? 0}',
//   '${StatisticsSingleton().statistics?.image.toList().length ?? 0}'
// ];

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
