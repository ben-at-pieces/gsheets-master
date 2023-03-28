import 'package:flutter/material.dart';

import '../statistics_singleton.dart';

class CodeSnippet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final index = StatisticsSingleton().statistics?.snippetsListRaw.length.toInt() ?? 0;

    return Container(
      width: 250,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${StatisticsSingleton().statistics?.snippetsListRaw.elementAt(index)}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
