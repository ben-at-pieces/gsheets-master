// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:core_openapi/api.dart';

import '../../Dashboard/custom_classes.dart';
import '../../boot.dart';

class DiscoveredAssetsButton extends StatelessWidget {

  Future<List<Asset>> getDiscoveredAssetsList() async {
    Assets assets = await assetsApi.assetsSnapshot(suggested: true, transferables: false);
    return assets.iterable.where((asset) => asset.discovered == true).toList() ?? [];
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Asset>>(
      future: getDiscoveredAssetsList(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final assets = snapshot.data ?? [];
          return TextButton(
            onPressed: () {
              _showDiscoveredAssets(context, assets);
            },
            child: Text('Discovered: (${assets.length})', style: TitleText()),
          );
        } else {
          return const Text('No data found.');
        }
      },
    );
  }
}
/// This code displays a modal bottom sheet in a Flutter app that shows a list of discovered assets.
/// Each asset in the list is displayed as a card with its
/// name, description, and other details.
/// The user can interact with each asset by tapping on
void _showDiscoveredAssets(BuildContext context, List<Asset> discoveredAssetsList) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              // color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            height: 56,
            child: Container(
              color: Colors.grey,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 16),
                  Text(
                    'Discovered (${discoveredAssetsList.length})',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    color: Colors.white,
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),

        ],
      );
    },
  );
}