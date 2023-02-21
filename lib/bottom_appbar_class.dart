import 'package:connector_openapi/api.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api/applications_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/statistics_singleton.dart';
import 'package:runtime_client/particle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Dashboard/custom_classes.dart';
import 'Dashboard/faqs.dart';
import 'Language_Pie_List/pieChartWidget.dart';
import 'Tab_Plugins_and_More/plugins_and_more.dart';

class CustomBottomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 15,
      height: 50,
      child: BottomAppBar(
        notchMargin: 5,
        color: Colors.black,
        elevation: 5,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              TextButton(
                child: Text(
                  '${StatisticsSingleton().statistics?.classifications}',
                  style: ClassificationsTitleText(),
                ),
                onPressed: () {
                  /// Language Pie Chart ==========================================================
                  MyPieChart();
                },
              ),
              FloatingActionButton(
                // focusColor: Colors.green,
                tooltip: 'frequently asked questions',
                hoverColor: Colors.white,
                elevation: 0,
                backgroundColor: Colors.transparent,
                child: Text(
                  'FAQ',
                  style: ParticleFont.micro(
                    context,
                    customization: TextStyle(color: Colors.grey),
                  ),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return FloatingSettingsButton();
                    },
                  );
                },
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
