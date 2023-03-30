import 'package:flutter/material.dart';

class ChipInputWidget extends StatefulWidget {
  @override
  _ChipInputWidgetState createState() => _ChipInputWidgetState();
}

class _ChipInputWidgetState extends State<ChipInputWidget> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _chipLabels = [];

  void _addChip() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty && !_chipLabels.contains(text)) {
      setState(() {
        _chipLabels.add(text);
      });
      _textController.clear();
    }
  }

  void _deleteChip(int index) {
    setState(() {
      _chipLabels.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 2.0,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              width: 180,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  hintText: 'Add tag...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addChip,
                  ),
                ),
                onSubmitted: (_) => _addChip(),
              ),
            ),
            SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              runSpacing: 8.0,
              children: _chipLabels.map((label) {
                return Chip(
                  label: Text(label),
                  backgroundColor: Colors.grey[300],
                  deleteIconColor: Colors.grey[600],
                  onDeleted: () => _deleteChip(_chipLabels.indexOf(label)),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
