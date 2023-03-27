import 'package:flutter/material.dart';
import 'package:gsheets/pieces_ui/views_dropdown.dart';


class SearchBar extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Expanded(
          child: TextField(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              hintText: 'Search...',
              suffixIcon: Icon(Icons.image),
            ),
          ),
        ),
      ],
    );
  }
}
