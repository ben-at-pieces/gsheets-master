// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:core_openapi/api.dart';
import 'package:flutter/services.dart';

import '../../Dashboard/custom_classes.dart';
import '../../boot.dart';
import '../../statistics_singleton.dart';

class SuggestedAssetsButton extends StatelessWidget {
  Future<Assets> getAssetsSnapshot() async {
    return await assetsApi.assetsSnapshot(suggested: true, transferables: false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Assets>(
      future: getAssetsSnapshot(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text('Loading...');
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final assets = snapshot.data?.iterable.toList() ?? [];
          return TextButton(
            onPressed: () {
              _showSuggestedSnippets(context);
            },
            child: Chip(
              elevation: 4,
              shadowColor: Colors.black,
              backgroundColor: Colors.black54,
              label: Row(
                children: [
                  Icon(
                    Icons.lightbulb,
                    color: Colors.white,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(
                      'Suggested: (${StatisticsSingleton().statistics?.suggestionsListed.length})',
                      style: TextStyle(
                        color: Colors.white,
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

/// This code displays a modal bottom sheet with a list of suggested snippets,
/// including their names, descriptions, and classifications.
/// The user can copy the snippet to the clipboard or view more details.
void _showSuggestedSnippets(BuildContext context) {
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
                  'Suggested (${StatisticsSingleton().statistics?.suggestedCount ?? 1})',
                  style: SnippetTitleText(),
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
              itemCount: StatisticsSingleton().statistics?.suggestedCount ?? 0,
              itemBuilder: (context, index) {
                String rawSnippet = StatisticsSingleton()
                        .statistics
                        ?.suggestionsListed
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
                        '${StatisticsSingleton().statistics?.suggestionsListed.elementAt(index).original.reference?.classification.specific.value}'),
                    subtitle: Container(
                      height: 60,
                      width: 200,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(
                            StatisticsSingleton().statistics?.suggestedDesc.elementAt(index) ?? ''),
                      ),
                    ),
                    title: Text(
                        StatisticsSingleton().statistics?.suggestedNames.elementAt(index) ?? ''),
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
