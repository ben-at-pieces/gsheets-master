import 'dart:typed_data';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Uint8List _bytes = Uint8List.fromList([
    // insert your image data bytes here
  ]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Preview Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Preview'),
        ),
        body: Center(
          child: ImagePreview(bytes: _bytes),
        ),
      ),
    );
  }
}

class ImagePreview extends StatefulWidget {
  final Uint8List bytes;

  const ImagePreview({Key? key, required this.bytes}) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle onTap as needed
      },
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Image.memory(
          widget.bytes,
          fit: BoxFit.contain,
          gaplessPlayback: true,
        ),
      ),
    );
  }
}