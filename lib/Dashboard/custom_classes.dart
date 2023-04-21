
import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';
import 'package:runtime_client/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class SnippetTitleText extends TextStyle {
  SnippetTitleText()
      : super(
    fontFamily: 'Roboto',
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.w500,
  );
}


class ProductTitleText extends TextStyle {
  ProductTitleText()
      : super(
    fontFamily: 'Roboto',
    fontSize: 10,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );
}
class ClassificationsTitleText extends TextStyle {
  ClassificationsTitleText()
      : super(
    fontFamily: 'Roboto',
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.w300,
  );
}

class EditTextStyle extends TextStyle {
  EditTextStyle()
      : super(
    fontFamily: 'Roboto',
    fontSize: 8,
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );
}


class TitleText extends TextStyle {
  TitleText()
      : super(
    fontFamily: 'Roboto',
    fontSize: 13,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}
class EditingTextStyle extends TextStyle {
  EditingTextStyle()
      : super(
    fontFamily: 'Roboto',
    fontSize: 10,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}

class PluginsAndMore extends TextStyle {
  PluginsAndMore()
      : super(
      fontFamily: 'Roboto',
      fontSize: 10,
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontStyle: FontStyle.normal
  );
}

class TitleGreyText extends TextStyle {
  TitleGreyText()
      : super(
    fontFamily: 'Roboto',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}


class TitleBlackText extends TextStyle {
  TitleBlackText()
      : super(
    fontFamily: 'Roboto',
    fontSize: 20,
    color: Colors.black,
    fontWeight: FontWeight.bold,
  );
}
class SuggestedStyle extends TextStyle {
  SuggestedStyle()
      : super(
    fontFamily: 'Roboto',
    fontSize: 15,
    color: Colors.black,
    // fontWeight: FontWeight.bold,
  );
}

class CustomIcon extends Icon {
  CustomIcon(IconData icon)
      : super(
    icon,
    size: 18,
    color: Colors.grey,
  );
}
class DeleteIcon extends Icon {
  DeleteIcon(IconData icon)
      : super(
    icon,
    size: 14,
    color: Colors.grey,
  );
}


class CustomDescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onChanged;

  const CustomDescriptionTextField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white38,
        height: 100,
        child: TextField(
          autofocus: false,
          style:  TitleText(),
          toolbarOptions: ToolbarOptions(
            copy: true,
            paste: true,
            selectAll: true,
          ),
          cursorHeight: 12,
          cursorColor: Colors.black,
          minLines: 15,
          maxLines: 15,
          autocorrect: true,
          controller: _descriptionController,
          decoration: InputDecoration(
            labelStyle: TitleText(),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelText: 'Give it a description?',
            hintStyle: TitleBlackText(),
            suffixIcon: IconButton(
              iconSize: 15,
              icon: Icon(
                Icons.clear,
                color: Colors.grey,
              ),
              onPressed: () {
                _descriptionController.clear();
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


final TextEditingController _descriptionController = TextEditingController();
