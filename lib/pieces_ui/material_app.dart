import 'package:flutter/material.dart';
import 'package:gsheets/pieces_ui/search.dart';
import 'carousel.dart';
import 'chip.dart';

class MyApp extends StatelessWidget {
  final List<String> options = ['blended', 'fts', 'ncs'];
  final String selectedOption = 'blended';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        items: options.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.view_carousel_rounded,
                                  size: 24,
                                  color: Colors.black.withOpacity(0.54),
                                ),
                                SizedBox(width: 8.0),
                                Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.87),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16.0,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                        value: selectedOption,
                        onChanged: (String? value) {
                          print('Selected option: $value');
                        },
                        hint: Text('Select an option'),
                        isExpanded: true,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 600,
                  child: SearchBar(),
                ),
              ],
            ),
            Expanded(
              child: CarouselWithIndicatorDemo(),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: MyChips(chipTitles: ['add', 'discover', 'paste', 'sort','sort'],),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());
