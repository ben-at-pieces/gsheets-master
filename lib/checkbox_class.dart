import 'package:flutter/material.dart';
import 'package:runtime_client/particle.dart';




class MyCheckBoxWidgget extends StatefulWidget {
   MyCheckBoxWidgget({super.key});

  @override
  State<MyCheckBoxWidgget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyCheckBoxWidgget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
       Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.black;
      }
      return Colors.grey;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool? value) {
        setState(() {
          isChecked = value!;


        });
      },
    );
  }
}
