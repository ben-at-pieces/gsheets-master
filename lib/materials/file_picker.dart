import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

import '../Dashboard/custom_classes.dart';

class FilePickerWidget extends StatefulWidget {
  final TextEditingController textEditingController;

  const FilePickerWidget({
    Key? key,
    required this.textEditingController,
  }) : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  Uint8List? _fileBytes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextButton(
          onPressed: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['png', 'svg', 'jpg', 'jpeg', 'txt'],
            );
            if (result != null) {
              setState(() {
                _fileBytes = result.files.single.bytes;
                widget.textEditingController.text = result.files.single.name;
              });
            }
          },
          child: Row(
            children: [
              Icon(Icons.attach_file, color: Colors.black),
              Text(
                'attach',
                style: TitleText(),
              ),
            ],
          ),
        ),
        if (_fileBytes != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (_fileBytes != null && (_fileBytes!.lengthInBytes < 10000000))
                  Image.memory(
                    _fileBytes!,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                SizedBox(height: 10),
                // TextButton(
                //   onPressed: () async {
                //     if (_fileBytes != null) {
                //       await Clipboard.setData(ClipboardData(
                //           text: String.fromCharCodes(_fileBytes!)));
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text('Copied to clipboard')),
                //       );
                //     }
                //   },
                //   child: Text(
                //     'Copy file contents',
                //     style: TextStyle(color: Colors.blue),
                //   ),
                // ),
              ],
            ),
          ),
      ],
    );
  }
}
