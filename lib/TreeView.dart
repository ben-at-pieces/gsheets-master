// ignore_for_file: omit_local_variable_types

import 'package:core_openapi/api.dart' hide Theme;
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';

String port = '1000';
String host = 'http://localhost:$port';

List assetsSnapshot = [];

AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
AssetApi assetApi = AssetApi(ApiClient(basePath: host));
UserApi userApi = UserApi(ApiClient(basePath: host));

void main() async {
  final assetsSnapshot = await assetsApi.assetsSnapshot();

  List<Asset> assetCount = assetsSnapshot.iterable;

  List<Asset> filterBatchFile = assetCount
      .where((element) =>
          element.original.reference?.classification.specific == ClassificationSpecificEnum.bat)
      .toList();

  int batch = filterBatchFile.length;

  print(batch);
}

class TreeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Text field and clear button logic
      ///
      body: Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            /// Widget controlling number of notes
            // ListViewSnapSheetExample(),
            Center(
              child: Column(
                children: <Widget>[
                  /// table start  ========================================================

                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        /// languages
                        Container(
                          height: 530,
                          width: 300,
                          child: Table(
                            border: TableBorder.all(color: Colors.black),
                            children: [
                              /// ==== batch  ========================================================
                              TableRow(children: [
                                /// language ========================================================

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.dynamic_feed_outlined,
                                              size: 15,
                                            ),
                                            Text(
                                              'Total:',
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(left: 20.0),
                                              child: Text(
                                                '12',
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 8.0),
                                          child: Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    'BatchFile',
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Text(
                                                      '1',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          'C',
                                        ),
                                        Text(
                                          'C#',
                                        ),
                                        Text(
                                          'CoffeeScript',
                                        ),
                                        Text(
                                          'C++',
                                        ),
                                        Text(
                                          'CSS',
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'Dart',
                                            ),
                                          ],
                                        ),
                                        Text(
                                          'Erlang',
                                        ),
                                        Text(
                                          'Go',
                                        ),
                                        Text(
                                          'Haskell',
                                        ),
                                        Text(
                                          'HTML',
                                        ),
                                        Text(
                                          'Java',
                                        ),
                                        Text(
                                          'JavaScript',
                                        ),
                                        Text(
                                          'JSON',
                                        ),
                                        Text(
                                          'LUA',
                                        ),
                                        Text(
                                          'Markdown',
                                        ),
                                        Text(
                                          'MatLab',
                                        ),
                                        Text(
                                          'Objective-C',
                                        ),
                                        Text(
                                          'Php',
                                        ),
                                        Text(
                                          'Perl',
                                        ),
                                        Text(
                                          'Powershell',
                                        ),
                                        Text(
                                          'Python',
                                        ),
                                        Text(
                                          'R',
                                        ),
                                        Text(
                                          'Ruby',
                                        ),
                                        Text(
                                          'Rust',
                                        ),
                                        Text(
                                          'Scala',
                                        ),
                                        Text(
                                          'Shell',
                                        ),
                                        Text(
                                          'SQL',
                                        ),
                                        Text(
                                          'Swift',
                                        ),
                                        Text(
                                          'TypeScript',
                                        ),
                                        Text(
                                          'Tex',
                                        ),
                                        Text(
                                          'Text',
                                        ),
                                        Text(
                                          'TOML',
                                        ),
                                        Text(
                                          'YAML',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                //
                                // /// count   =========================================================

                                // /// name
                              ]),

                              ///
                            ],
                          ),
                        ),

                        ///#s
                      ],
                    ),
                  ),
                ],
              ),
            ),

            Divider(),

            /// Widget controlling our text box decoration
            // ListViewSnapSheetExample(),
          ],
        ),
      ),
      //
      //   bottomSheet: ,
    );
  }
}
