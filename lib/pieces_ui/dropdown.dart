// ignore_for_file: omit_local_variable_types

import 'package:connector_openapi/api.dart';
import 'package:core_openapi/api/asset_api.dart';
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../api.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DropdownWidget extends StatefulWidget {
  final String selectedOption;
  final Function(String?)? onChanged;

  const DropdownWidget({
    Key? key,
    required this.selectedOption,
    this.onChanged,
  }) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  String? _newValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Card(
        elevation: 4,
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            value: _newValue ?? widget.selectedOption,
            items: [
              DropdownMenuItem<String>(
                value: 'Carousel',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [








                    SizedBox(width: 8),
                    Text(
                      'Carousel',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.view_carousel,
                        size: 18,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              DropdownMenuItem<String>(
                value: 'Workflow Activity',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Workflow Activity',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.stacked_line_chart,
                      size: 18,
                      color: Colors.black,
                    ),
                  ],
                ),
              ),
              DropdownMenuItem<String>(
                value: 'Global Search',
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [


                    Text(
                      'Global Search',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(
                      Icons.language,
                      size: 18,
                      color: Colors.black,
                    ),

                  ],
                ),
              ),
            ],
            onChanged: (newValue) async {
              setState(() {
                _newValue = newValue;
              });

              if (widget.onChanged != null) {
                widget.onChanged!(newValue);
              }

              if (_newValue == 'Carousel') {
                await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Carousel'),
                    );
                  },
                );
              }
            },
            isExpanded: false,
            dropdownColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
