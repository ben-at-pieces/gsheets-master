// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:gsheets/create/reclassify/GSheetConnection.dart';
import '../../init/markDownfulllists.dart';
import '../../init/src/gsheets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// This code returns a Material App with a title "Add Product Notes"
    /// and a home page that displays the AddProductNotePage.
    return MaterialApp(
      title: 'Add Product Notes',
      home: AddProductNotePage(),
    );
  }
}

class AddProductNotePage extends StatefulWidget {
  const AddProductNotePage({Key? key}) : super(key: key);

  @override
  _AddProductNotePageState createState() => _AddProductNotePageState();
}

class _AddProductNotePageState extends State<AddProductNotePage> {
  static const credentials = r'''

{
  "type": "service_account",
  "project_id": "flutter-gsheets-355919",
  "private_key_id": "336d7cfee18940b61b06e04a92bd48fbc496cb1f",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQDGV8tCv18Ga7Ia\nQxiAI4qtN51UY+AuccMebOFRzOhMT//wTMgDFmuxS90joiRRQjcmTIzuMtBB+/Yy\nUqhklUACg5hxqgMzwMBuzilmGiApQgWuAYWNTw/SbR1ZsUs3UeyzJ88nz6jpyVdH\nQ2FjWyp8gb/HyYirH+09u7LekkWeFETvdQHwlV+PPRrFM9Nt/TH8aoy0PJMcJu4Y\n0KxHW++azYMu6g6JtGMeB7g2Q+k29LlFWkdEqo8eBlWcKruub7or52NVeHu1OIsx\nkTQwuga3TiuSzil/Aqr0bFFqC2aFI2fCv6coC7boszr0y5lT6MPy4ZVE8qG430rN\noBu5p4FJAgMBAAECggEACx2VdxlUK9RyR/WAVIIUE1loDaLb8qO5LHsr9NJ30aW0\nHBVO1O7Mke7vUZVp1Uym3D8dsNBpNSF37oxiV+IOEyCpNPQzDL3zKuKOlbnGGU8p\naVM4LFoEyCVe/Tf/P/ZCk9cZzXXeVgfMxozN/Zb43mnDw+BqsohuBRp/+j2WqDa0\n98rrteWPYMNOoQ6fF8qd9UBOSwr5by7otMzjvzW/L4jRM+ZG6gQeuUCGRU6EDu+H\nrNaFFU9+fMGuK2DGWjtXH6OkOZ/txVIWUhoXTUmA/ATZXi1iN6QE/tjo86AcpVez\nNHOvGGwRns5wRHbqjuFtie3AciyuHy11SaOQPPEPzwKBgQDs5GNEducEVGLO+9FI\nlQ9CeQHznQbmmOowKvLg2Svkdnoe3Q58jPuAqzsNQLjt+BATcrXw9H7j/hh/BPH+\n53QXLbBVtyMTndOFN5VXrY3MgWw1FWRObedfqu2FAjiHq2yDOt8AydyLr8AX58o5\n0kH3Sx5OsHlxdLlL0mgRJOCuUwKBgQDWV2ZMfb1ekIx7gaUqgOTkVeMYJ4kwV00+\n2Ye+2qSOUp5cqSjYxXVlt0Nszyz/xJu4oMfSCFaeSzyMImgeNQb/FL6tb5OoJwR9\nQapyHFqqBVX/5c7ZIAeDRCh84suFeUhDKZds/ClhdWBaaWeHpSdPdYvWWt5N0VVx\nCkjh9+fGcwKBgHYWHzm4v84TtrGRK7EvxMyQ/50NsKvwnATo0+urtkqLmLKb5SXH\nLXPlZ2li0wyk9HaNXw6/AiXquxFOSMeVXvRS7Sy9Pvn/Wbp1i7eKJz5DYcpQYJEM\nDiNNVFtSURWoKU59YT7GYW8sa+g+vjr2ibWZN4FoTRF2awvV1dR9+pZLAoGAVwGV\nYhlshHVywTPIQu+del6u14A8/SWDEq8knkGMqMU6yWxVS2EkHYz9zq5umshJWfHS\nCx0dZBYwVsYks5Zc57CZEjgHnStxdBLyyG1gFEIkPcMgaxzIT+2b7c32RZEM106L\nzE6z0X7fBPRidTqCMYwKnpG2Sape34sIOMn0CKcCgYApU9qSoeZZQYP9xAre4pst\nPoceesDw7IDg9so/i8+GlD1j0GRKexptrY2CVwgGu+6jufJoo9t7qjypV3bMZB5K\nLlWRyBzcIoDt1mPALml67hxG4qnSF3qJDdU187lQzks+CCFJHIbISxxbzqG3M8n/\n1E9ho/2obvQmcz35A9Wm7g==\n-----END PRIVATE KEY-----\n",
  "client_email": "flutter-gsheets@flutter-gsheets-355919.iam.gserviceaccount.com",
  "client_id": "101366955861814063269",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/flutter-gsheets%40flutter-gsheets-355919.iam.gserviceaccount.com"
}

''';
  final TextEditingController _noteController = TextEditingController();
  final spreadsheetID = 'your-spreadsheet-id-here'; // replace with your spreadsheet ID
  final gsheets = GSheets(credentials); // replace with your own credentials

  Worksheet? worksheet;
  String _note = '';

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product Note'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  'pfd.png',
                  width: 40.0,
                  height: 40,
                ),
                Text(
                  'Pieces for X',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(width: 16.0),

            ///
            Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: false,
                    toolbarOptions: ToolbarOptions(
                      copy: true,
                      paste: true,
                      selectAll: true,
                    ),
                    cursorHeight: 20,
                    cursorColor: Colors.black,
                    // minLines: 10,
                    // maxLines: 20,
                    autocorrect: true,
                    controller: _controller,
                    decoration: InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      labelText: 'add a note...',
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            iconSize: 15,
                            icon: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              _controller.clear();
                            },
                          ),
                        ],
                      ),

                      /// ==============================================================
                      suffixIcon: Column(
                        children: [
                          IconButton(
                            iconSize: 15,
                            icon: Icon(
                              Icons.send_outlined,
                              color: Colors.black,
                            ),
                            onPressed: () async {
                              final gsheets = GSheets(credentials);
                              final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';

// Get the spreadsheet
                              final ssheet = await gsheets.spreadsheet(spreadsheetID);
                              final ws = await ssheet.worksheetByTitle('take_note');

// Get existing values and calculate the last row index
                              final values = await ws?.values.allRows();
                              final lastRowIndex = values?.length ?? 0;

// Insert the new row 1 row below the last row index
                              await ws?.values.insertRow(
                                lastRowIndex + 1,
                                [
                                  '${_controller.text}',
                                ],
                                fromColumn: 1,
                              );

                              _controller.clear();
                              setState(() {});

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Saved to Google Sheets!',
                                      ),
                                    ],
                                  ),
                                  duration: Duration(
                                    days: 0,
                                    hours: 0,
                                    minutes: 0,
                                    seconds: 1,
                                    milliseconds: 30,
                                    microseconds: 10,
                                  ),
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Saved to Google Sheets!',
                                      ),
                                    ],
                                  ),
                                  duration: Duration(
                                    days: 0,
                                    hours: 0,
                                    minutes: 0,
                                    seconds: 1,
                                    milliseconds: 30,
                                    microseconds: 10,
                                  ),
                                ),
                              );

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.black,
                                  content: Row(
                                    children: [
                                      Icon(
                                        Icons.check,
                                        color: Colors.green,
                                      ),
                                      Text(
                                        'Saved to Google Sheets!',
                                      ),
                                    ],
                                  ),
                                  duration: Duration(
                                      days: 0,
                                      hours: 0,
                                      minutes: 0,
                                      seconds: 1,
                                      milliseconds: 30,
                                      microseconds: 10),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.solid,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),

                /// ADD to GSHEETS ====================================================
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// add a piece to gsheets

//
// class AddProductNotePage extends StatefulWidget {
//   const AddProductNotePage({Key? key}) : super(key: key);
//
//   @override
//   _AddProductNotePageState createState() => _AddProductNotePageState();
// }
//
// class _AddProductNotePageState extends State<AddProductNotePage> {
//   String _piecesForXNote = '';
//   String _piecesOsNote = '';
//   String _vsCodeNote = '';
//   String _chromeExtensionNote = '';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Product Notes'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               children: [
//                 Image.asset(
//                   'pfd.png',
//                   width: 48.0,
//                   height: 48.0,
//                 ),
//                 Text(
//                   'Pieces for X',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Note',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.send),
//               ),
//               onChanged: (value) => _piecesForXNote = value,
//             ),
//             Row(
//               children: [
//                 Image.asset(
//                   'an_instance_of_PFD.jpeg',
//                   width: 48.0,
//                   height: 48.0,
//                 ),
//                 Text(
//                   'Pieces OS',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Note',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.send),
//               ),
//               onChanged: (value) => _piecesOsNote = value,
//             ),
//             Row(
//               children: [
//                 Image.asset(
//                   'vs_code.jpeg',
//                   width: 48.0,
//                   height: 48.0,
//                 ),
//                 Text(
//                   'VS Code',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Note',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.send),
//               ),
//               onChanged: (value) => _vsCodeNote = value,
//             ),
//             Row(
//               children: [
//                 Image.asset(
//                   'chrome.jpeg',
//                   width: 48.0,
//                   height: 48.0,
//                 ),
//                 Text(
//                   'Chrome Extension',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             TextField(
//               decoration: InputDecoration(
//                 labelText: 'Note',
//                 border: OutlineInputBorder(),
//                 suffixIcon: Icon(Icons.send),
//               ),
//               onChanged: (value) => _chromeExtensionNote = value,
//             ),
//             Row(
//               children: [
//                 Image.asset(
//                   'jetbrains.png',
//                   width: 48.0,
//                   height: 48.0,
//                 ),
//                 Text(
//                   'JetBrains IntelliJ',
//                   style: TextStyle(
//                     fontSize: 20.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//             // TextField(
//             //   decoration: InputDecoration(
//             //     labelText: 'Note',
//             //     border: OutlineInputBorder(),
//             //     suffixIcon: Icon(Icons.send),
//             //   ),
//             //   onChanged: (value) => _jetBrainsNote = value,
//             // ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }
  final TextEditingController _controller = TextEditingController();
}
