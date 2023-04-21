// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:core_openapi/api.dart';
import 'package:flutter/services.dart';

import '../../Dashboard/custom_classes.dart';
import '../../boot.dart';
import '../../statistics_singleton.dart';

class DiscoveredAssetsButton extends StatelessWidget {
  Future<List<Asset>> getDiscoveredAssetsList() async {
    Assets assets = await assetsApi.assetsSnapshot(suggested: true, transferables: true);
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
            child: Chip(
              elevation: 4,
              shadowColor: Colors.black,
              backgroundColor: Colors.black12,
              label: Row(
                children: [
                  Icon(
                    Icons.troubleshoot_outlined,
                    color: Colors.blue,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Discovered: (${StatisticsSingleton().statistics?.discoveredAssetsList.length})',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
            color: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 16),
                Text(
                  'Discovered: ${StatisticsSingleton().statistics?.discoveredAssetsList.length ?? 0}',
                  style: TitleText(),
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: StatisticsSingleton().statistics?.discoveredAssetsList.length ?? 0,
              itemBuilder: (context, index) {
                String rawSnippet = StatisticsSingleton()
                        .statistics
                        ?.discoveredAssetsList
                        .elementAt(index)
                        .original
                        .reference
                        ?.fragment
                        ?.string
                        ?.raw ??
                    '';

                return Card(
                  shadowColor: Colors.black,
                  elevation: 4,
                  child: ListTile(
                    trailing: Text(
                      '${StatisticsSingleton().statistics?.discoveredAssetsList.elementAt(index).original.reference?.classification.specific.value ?? ''}',
                      style: TitleText(),
                    ),
                    subtitle: Row(
                      children: [
                        Container(
                          child: Text(StatisticsSingleton()
                                  .statistics
                                  ?.discoveredAssetsList
                                  .elementAt(index)
                                  .name ??
                              ''),
                        ),
                        // Text(StatisticsSingleton()
                        //         .statistics
                        //         ?.discoveredAssetsList
                        //         .elementAt(index)
                        //         .tags
                        //         ?.iterable
                        //         .toList()
                        //         .elementAt(index)
                        //         .text ??
                        //     ''),
                      ],
                    ),
                    title: Text(StatisticsSingleton()
                            .statistics
                            ?.discoveredAssetsList
                            .elementAt(index)
                            .description ??
                        ''),
                    leading: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('${index + 1}'),
                        IconButton(
                          icon: Icon(Icons.more_vert),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('snippet place holder'),
                                  content: TextField(
                                    readOnly: false,
                                    controller: _textEditController,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        await Clipboard.setData(ClipboardData(
                                            text:
                                                '${StatisticsSingleton().statistics?.suggestionsListed ?? ''}'));
                                        Navigator.of(context).pop();
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Copied to clipboard')),
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          Text(
                                            'Copy',
                                            style: TitleText(),
                                          ),
                                          Icon(
                                            Icons.copy,
                                            color: Colors.black,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.copy),
                          onPressed: () async {
                            await Clipboard.setData(ClipboardData(text: rawSnippet));
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Copied to clipboard')),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      );
    },
  );
}

final TextEditingController _textEditController = TextEditingController();
