import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class ToggleableWidget extends StatefulWidget {
  final Uint8List? uint8list;
  final String? rawString;

  ToggleableWidget({this.uint8list, this.rawString, required bool value, required  Function(dynamic value) onChanged});

  @override
  _ToggleableWidgetState createState() => _ToggleableWidgetState();
}

class _ToggleableWidgetState extends State<ToggleableWidget> {
  bool _isPreview = true;

  TextEditingController _textEditingController = TextEditingController();

  void _toggleView() {
    setState(() {
      _isPreview = !_isPreview;
    });
  }

  @override
  void initState() {
    super.initState();
    _textEditingController.text = widget.rawString ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            TextButton(
              onPressed: () {
                _toggleView();
              },
              child: Text(
                _isPreview ? 'edit' : 'make some changes...',
                style: TextStyle(
                  color: _isPreview ? Colors.grey : Colors.black,
                  fontWeight: _isPreview ? FontWeight.normal : FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        _isPreview
            ? SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SizedBox(
            width: 400,
            height: 50,
            child: widget.uint8list != null
                ? Image.memory(
              widget.uint8list!,
              fit: BoxFit.cover,
            )
                : Center(child: Text('No image')),
          ),
        )
            : TextField(
          controller: _textEditingController,
          readOnly: false,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              onPressed: () {
                _textEditingController.clear();
              },
              icon: Icon(Icons.clear),
            ),
            hintText: 'Raw String',
            border: OutlineInputBorder(),
          ),
          maxLines: null,
          style: TextStyle(
            fontFamily: 'RobotoMono',
            fontSize: 14,
            height: 1.5,
          ),
        ),
      ],
    );

  }
}
