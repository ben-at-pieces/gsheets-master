import 'package:flutter/material.dart';
import '../Dashboard/custom_classes.dart';

class EditableTextWidget extends StatefulWidget {
  final String initialText;

  EditableTextWidget({required this.initialText});

  @override
  _EditableTextWidgetState createState() => _EditableTextWidgetState();
}

class _EditableTextWidgetState extends State<EditableTextWidget> {
  late TextEditingController _textController;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Column(
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isEditing = !_isEditing;
                    });
                  },
                  child: Text(
                    _isEditing ? 'CANCEL' : 'EDIT',
                    style: TitleText(),
                  ),
                ),

              ],
            ),
          ],
        ),
        if (_isEditing)
          Column(
            children: [
              Container(
                width: 250,
                height: 300,
                child: TextField(
                  autofocus: false,
                  maxLines: null,
                  controller: _textController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelStyle: EditingTextStyle(),
                  ),
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'save',
                      style: TitleText(),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'close',
                      style: TitleText(),
                    ),
                  ), ],
              ),
            ],
          )
        else if (_textController.text.isNotEmpty)
          Container(
            height: 200,
            width: 250,
            child: Text(''),
          ),
      ],
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
