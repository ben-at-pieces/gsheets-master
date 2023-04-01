
// ignore_for_file: omit_local_variable_types

import 'package:flutter/material.dart';
import 'package:googleapis/cloudasset/v1.dart';
import 'package:gsheets/statistics.dart';
import 'package:gsheets/statistics_singleton.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Bottom_bar/bottom_appbar_class.dart';
import '../Dashboard/custom_classes.dart';
import '../create/create_function.dart';
import '../init/src/gsheets.dart';



class Pieces_Gsheets extends StatefulWidget {
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<Pieces_Gsheets> {
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Image.asset(
        'img_2.png', // Replace this with your own image asset
        width: 30.0,
        height: 30.0,
      ),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              titlePadding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              contentPadding:
              EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
              title: Row(
                children: [
                  Image.asset(
                    'img_2.png', // Replace this with your own image asset
                    width: 40.0,
                    height: 40.0,
                  ),
                  SizedBox(width: 10.0),
                  Text('Pieces for X'),
                ],
              ),
              content: Container(
                height: 200.0,
                width: 400,
                child: TextField(
                  maxLines: null,
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    hintText: 'Enter your text',
                    border: InputBorder.none,
                  ),
                ),
              ),
              actions: <Widget>[

                TextButton(
                  child: Row(
                    children: [
                      Image.asset(
                        'gsheets.png',
                        height: 30,
                        width: 30,
                      ),
                      Text('Save to Sheets', style: TitleText(),),
                    ],
                  ),
                  onPressed: () async {
                    final gsheets = GSheets(credentials);
                    final spreadsheetID = '18IlCBkFo9Y1Q0BshWiHehI0p3zufEImkWqOr23kBMcM';

                    // Get the spreadsheet
                    final ssheet = await gsheets.spreadsheet(spreadsheetID);
                    final ws = await ssheet.worksheetByTitle('PFX');

                    // Get existing values and calculate the last row index
                    final values = await ws?.values.allRows();
                    final lastRowIndex = values?.length ?? 0;

                    // Insert the new row 1 row below the last row index
                    await ws?.values.insertRow(
                      lastRowIndex + 1,
                      [
                        '${_textFieldController.text}',
                      ],
                      fromColumn: 1,
                    );

                    _textFieldController.clear();

                    Navigator.of(context).pop();


                  },
                ),

                TextButton(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );

          },
        );
      },
    );
  }
}
