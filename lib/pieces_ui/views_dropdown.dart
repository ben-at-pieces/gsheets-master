// import 'package:flutter/material.dart';
//
// class ViewsDropdown extends StatefulWidget {
//   final List<String> options;
//   final String selectedOption;
//
//   ViewsDropdown({required this.options, required this.selectedOption});
//
//   @override
//   _CustomDropdownButtonState createState() => _CustomDropdownButtonState();
// }
//
// class _CustomDropdownButtonState extends State<ViewsDropdown> {
//   late String _selectedOption;
//
//   @override
//   void initState() {
//     _selectedOption = widget.selectedOption;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton<String>(
//       items: [
//         DropdownMenuItem<String>(
//           value: 'blended',
//           child: Row(
//             children: [
//               Icon(Icons.view_carousel_rounded, size: 24),
//               SizedBox(width: 8.0),
//               Text('Blended'),
//               SizedBox(width: 8.0),
//               Icon(Icons.arrow_drop_down),
//             ],
//           ),
//         ),
//         DropdownMenuItem<String>(
//           value: 'fts',
//           child: Row(
//             children: [
//               Icon(Icons.star, size: 24),
//               SizedBox(width: 8.0),
//               Text('FTS'),
//             ],
//           ),
//         ),
//         DropdownMenuItem<String>(
//           value: 'ncs',
//           child: Row(
//             children: [
//               Icon(Icons.access_time, size: 24),
//               SizedBox(width: 8.0),
//               Text('NCS'),
//             ],
//           ),
//         ),
//       ],
//       value: _selectedOption,
//       onChanged: (String? value) {
//         setState(() {
//           _selectedOption = value!;
//         });
//         print('Selected option: $_selectedOption');
//       },
//       hint: Text('Select an option'),
//     );
//   }
// }
//
