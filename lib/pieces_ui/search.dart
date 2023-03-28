import 'package:flutter/material.dart';
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 320,
      height: 55,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: Colors.grey,
              ),
              SizedBox(width: 8.0),
              Expanded(
                child: TextField(
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search...',
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
              Icon(
                Icons.account_circle_rounded,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
