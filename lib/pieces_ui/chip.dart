import 'package:flutter/material.dart';

class MyChips extends StatelessWidget {
  final List<String> chipTitles;

  MyChips({required this.chipTitles});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: chipTitles.map((title) {
        return Chip(
          elevation: 3,
          label: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black54,
          padding: EdgeInsets.symmetric(horizontal: 8.0),
        );
      }).toList(),
    );
  }
}
