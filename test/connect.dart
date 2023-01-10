import 'package:connector_openapi/api.dart' hide Assets, Asset;
import 'package:core_openapi/api_client.dart';
import 'package:connector_openapi/api_client.dart' as connector;
import 'package:core_openapi/api.dart';


AssetsApi assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));
AssetApi assetApi = AssetApi(ApiClient(basePath: 'http://localhost:1000'));
ConnectorApi connectorApi = ConnectorApi(connector.ApiClient(basePath: 'http://localhost:1000'));
class DartConnector {
  final connector.ApiClient api;
  late final ConnectorApi connectorApi;

  DartConnector(this.api) {
    /// init the assetsApi
    connectorApi = ConnectorApi(api);
  }

  Future<void> run() async {
    /// start to test our endpoints
    await connect();
  }

//Calling Connect --------------------------------------------------------------------------------------
  Future<void> connect() async {
    Context connect;
    try {
      connect = await connectorApi.connect(
        seededConnectorConnection: SeededConnectorConnection(
          application: SeededTrackedApplication(
            name: ApplicationNameEnum.PIECES_FOR_DEVELOPERS,
            platform: PlatformEnum.LINUX,
            version: "1.7.0",
          ),
        ),
      );
      // print('======== $connect');
    } catch (err) {
      throw Exception('Error occurred when establishing connection. error:$err');
    }

//Calling Snapshot --------------------------------------------------------------------------------------
//   }
// }
    try {
      print(
          '=============================================================== Running (dart) /Snapshot');
      ConnectorSnapshot snapshot =
      await connectorApi.snapshot(connect.application.id, transferables: false);

      // print(snapshot);
      print('=============================================================== End of the Snapshot');
    } catch (err) {
      throw Exception('''
      Error occurred while testing connector.snapshot error:$err''');
    }




    List<Assets> assetsList = [];







  }
}