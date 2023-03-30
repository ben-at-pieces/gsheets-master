import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class CodeSnippet extends StatelessWidget {
  late final String code;
  late final Uint8List? imageBytes;
  late final BuildContext context;



  Future<void> _copyToClipboard() async {
    if (imageBytes != null) {
      final byteData = imageBytes!.buffer.asByteData();
      final base64Image = base64.encode(Uint8List.view(byteData.buffer));
      await Clipboard.setData(ClipboardData(text: base64Image));
    } else {
      await Clipboard.setData(ClipboardData(text: code));
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Copied to Clipboard',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.white,
        duration: Duration(milliseconds: 1030),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        elevation: 4,
        child: Stack(
          fit: StackFit.loose,
          children: [
            SingleChildScrollView(
              child: HighlightView(
                code,
                language: 'dart',
                theme: githubTheme,
                padding: EdgeInsets.all(16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                children: [
                  TextButton(
                    onPressed: _copyToClipboard,
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith(
                            (states) => Colors.white,
                      ),
                      side: MaterialStateProperty.all(
                        BorderSide(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      overlayColor: MaterialStateProperty.all(
                        Colors.black12,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.copy_outlined,
                          color: Colors.black,
                          size: 12,
                        ),
                        SizedBox(width: 4),
                        Text(
                          'copy',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ClipOval(
                      child: Material(
                        color: Colors.white,
                        child: InkWell(
                          splashColor: Colors.grey,
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: Colors.grey),
                              ),
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Icon(
                                  Icons.share,
                                  color: Colors.black,
                                  size: 12,
                                ),
                              ),
                            ),
                          ),
                          onTap: () {
                            // Share the image or code
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
