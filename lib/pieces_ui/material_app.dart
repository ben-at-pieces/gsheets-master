import 'package:flutter/material.dart';
import 'package:gsheets/pieces_ui/search.dart';
import 'package:gsheets/pieces_ui/sidebar.dart';
import 'carousel.dart';
import 'chip.dart';
import 'message_action.dart';

class MyApp extends StatelessWidget {
  final List<String> options = ['Carousel', 'Workflow Activity', 'Global Search'];
  final String selectedOption = 'Carousel';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
appBar:   AppBar(leading:   FloatingActionButtonWithSideBar(),),
        // backgroundColor: Colors.black45,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  DropdownWidget(selectedOption: 'Carousel',),
                  SearchBar(),
                ],
              ),
            ),
            Expanded(
              child: CarouselDemo(),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 16.0),
              child: MyChips(
                chipTitles: ['add', 'discover', 'paste', 'sort', 'sort'],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(MyApp());
