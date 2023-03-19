import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

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
  File? _pickedFile;

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
                _pickedFile = File(result.files.single.path!);
                widget.textEditingController.text = _pickedFile!.absolute.path;
              });
            }
          },
          child: Row(
            children: [
              Icon(Icons.attach_file,color: Colors.black,),
              Text('attach', style: TitleText(),),

            ],
          ),
        ),
        if (_pickedFile != null)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _pickedFile!.path,
              style: TextStyle(fontSize: 18),
            ),
          ),
      ],
    );
  }
}
