import 'package:flutter/material.dart';
import 'package:gsheets/Tab_Plugins_and_More/plugins_and_more.dart';

import '../Dashboard/custom_classes.dart';

class LabeledChipButton extends StatelessWidget {
  // final String label;
  final String chipLabel;
  final VoidCallback onPressed;

  const LabeledChipButton({
    Key? key,
    // required this.label,
    required this.chipLabel,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        child: Chip(
          // side: BorderSide(color: Colors.white, width: 1, strokeAlign: StrokeAlign.inside),
          shadowColor: Colors.black,
          elevation: 2,
          label: Text(

            chipLabel,
            style: TitleText(),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}


class CustomTextField extends StatefulWidget {
  const CustomTextField({Key? key}) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Enter your name',
        border: OutlineInputBorder(),
      ),
    );
  }
}
