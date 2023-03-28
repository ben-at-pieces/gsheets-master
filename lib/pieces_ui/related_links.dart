import 'package:flutter/material.dart';

class RelatedLinkWidget extends StatefulWidget {
  @override
  _RelatedLinkWidgetState createState() => _RelatedLinkWidgetState();
}

class _RelatedLinkWidgetState extends State<RelatedLinkWidget> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _linkLabels = [];

  void _addLink() {
    final String text = _textController.text.trim();
    if (text.isNotEmpty && !_linkLabels.contains(text)) {
      setState(() {
        _linkLabels.add(text);
      });
      _textController.clear();
    }
  }

  void _deleteLink(int index) {
    setState(() {
      _linkLabels.removeAt(index);
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
                  hintText: 'Add link...',
                  border: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: _addLink,
                  ),
                ),
                onSubmitted: (_) => _addLink(),
              ),
            ),
            SizedBox(height: 8.0),
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Wrap(
                spacing: 8.0,
                runSpacing: 8.0,
                children: _linkLabels.map((label) {
                  return Chip(
                    label: Text(label),
                    backgroundColor: Colors.grey[300],
                    deleteIconColor: Colors.grey[600],
                    onDeleted: () => _deleteLink(_linkLabels.indexOf(label)),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
