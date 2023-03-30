// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/statistics_singleton.dart';

import '../Dashboard/custom_classes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: Scaffold(
        appBar: AppBar(title: Text('Discovered Assets')),
        body: DiscoveredAssetView(),
      ),
    );
  }
}

class DiscoveredAssetView extends StatefulWidget {
  @override
  _DiscoveredAssetViewState createState() => _DiscoveredAssetViewState();
}

class _DiscoveredAssetViewState extends State<DiscoveredAssetView> {
  AssetsApi assetsApi = AssetsApi(ApiClient(basePath: 'http://localhost:1000'));

  Future<List<Asset>> getDiscoveredAssetsList() async {
    return StatisticsSingleton().statistics?.discoveredAssetsList.toList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Asset>>(
      future: getDiscoveredAssetsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final discoveredAssetsList = snapshot.data!;
          final discoveredAssetNames = discoveredAssetsList.map((asset) => asset.name ?? '').toList();
          final discoveredAssetDescriptions = discoveredAssetsList.map((asset) => asset.description ?? '').toList();

          return ListView.builder(
            itemCount: discoveredAssetsList.length,
            itemBuilder: (context, index) {
              final name = discoveredAssetNames[index];
              final description = discoveredAssetDescriptions[index];

              return ListTile(
                title: Text(name),
                subtitle: Text(description),
                onTap: () => _showAssetDetails(context, name, description),
              );
            },
          );
        } else {
          return Center(child: Text('No data found.'));
        }
      },
    );
  }

  void _showAssetDetails(BuildContext context, String name, String description) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 200,
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(description, style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      },
    );
  }
}
