// ignore_for_file: omit_local_variable_types

import 'dart:html';

import 'package:connector_openapi/api.dart';

import '../lists/relatedLists.dart';
import '../statistics_singleton.dart';

List<String> getRelatedItems(String input) {
  List<String> related = [];
  List<String> nonEmptyStrings = [];
  List<Asset>? list = StatisticsSingleton().statistics?.asset.toList();
  int indexAssets = StatisticsSingleton().statistics?.asset.toList().length.toInt() ?? 0;

  for (int i = 0; i < indexAssets; i++) {
    String single = list?.elementAt(i).original.reference?.fragment?.string?.raw ?? '';

    if (single.isNotEmpty) {
      nonEmptyStrings.add(single);
    }


  }

  if (input.contains('???')) {
    related = explanations.toList();
  } else if (input.contains('dart')) {
    related = dartSnippets.toList();
  } else if (input.contains('python')) {
    related = pythonRelatedStrings;
  } else if (input.contains('ty')) {
    related = typescriptRelatedStrings;
  } else if (input.contains('ja')) {
    related = javaScript.toList();
  } else if (input.contains('people')) {
    related = peoples.toList();
  } else if (input.contains('tag')) {
    related = tags.toList();
  } else if (input.contains('links')) {
    related = links.toList();
  } else if (input.contains('sql')) {
    related = sqlSnippets.toList();
  } else if (input.contains('pro')) {
    related = userdata.toList();
  } else if (input.contains('snippets')) {
    related = nonEmptyStrings.toList();
  } else if (input.contains('help')) {
    related = learn.toList();
  } else if (input.contains('learn')) {
    related = prompts.toList();
  } else {
    related = [
      'Sorry, '
          '${StatisticsSingleton().statistics?.vanityName}, that didnt match any results',
      '''
Try Searching...

"people"

"sql"

"javascript"

'''
    ];
  }

  return related;
}
