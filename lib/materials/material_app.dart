// import 'dart:typed_data';
// import 'package:connector_openapi/api.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_highlight/flutter_highlight.dart';
// import 'package:flutter_highlight/themes/github.dart';
// import 'package:gsheets/materials/textPreview.dart';
//
// import '../Dashboard/Language_Logic/batch_language.dart';
// import '../statistics_singleton.dart';
//
// class YourDialog extends StatelessWidget {
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(16),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.2),
//               blurRadius: 5,
//               spreadRadius: 1,
//               offset: Offset(0, 2),
//             ),
//           ],
//         ),
//
//         /// Displays an image or code snippet with a
//         /// toggleable code editor,
//         /// highlighting syntax and
//         /// increasing font size for readability.
//         child: SizedBox(
//           width: 450,
//           height: 450,
//           child: uint8list != null
//               ? Column(
//             children: [
//               AppBar(
//                 leading: Icon(Icons.image_outlined),
//                 backgroundColor: Colors.black12,
//                 elevation: 0,
//                 centerTitle: true,
//                 title: Text(
//                   'View',
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Container(
//                   height: 250,
//                   child: Image.memory(
//                     uint8list,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//               ),
//             ],
//           )
//
//           /// Displays a widget with the
//           /// name and classification of an asset,
//           /// along with a code snippet that
//           /// can be toggled between a
//           /// read-only view and an editable view.
//               : Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               AppBar(
//                 leading: Icon(Icons.code),
//                 backgroundColor: Colors.black12,
//                 elevation: 0,
//                 centerTitle: true,
//                 title: SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Text(
//                     asset.name ?? '',
//                     style: TextStyle(fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.start,
//                   ),
//                 ),
//               ),
//
//
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SingleChildScrollView(
//                     scrollDirection: Axis.horizontal,
//                     child: Text(
//                       asset.original.reference?.classification.specific
//                           .value ??
//                           '',
//                       style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 12,
//                           color: Colors.grey),
//                       textAlign: TextAlign.start,
//                     ),
//                   ),
//                 ],
//               ),
//               Visibility(
//                 visible: !showCodeEditor,
//                 child: Container(
//                   height: 250,
//                   child: SingleChildScrollView(
//                     child: HighlightView(
//                       rawString ?? '',
//                       language: 'dart',
//                       theme: githubTheme,
//                       textStyle: TextStyle(fontSize: 18),
//                       padding: EdgeInsets.all(16),
//                     ),
//                   ),
//                 ),
//               ),
//               Visibility(
//                 visible: showCodeEditor,
//                 child: TextField(
//                   controller: codeEditorController,
//                   maxLines: null,
//                   keyboardType: TextInputType.multiline,
//                   decoration: InputDecoration(
//                     hintText: 'Enter code snippet...',
//                     contentPadding: EdgeInsets.all(16),
//                     border: OutlineInputBorder(),
//                     enabledBorder: OutlineInputBorder(
//                       borderSide:
//                       BorderSide(color: Colors.grey, width: 1.0),
//                       borderRadius:
//                       BorderRadius.all(Radius.circular(4.0)),
//                     ),
//                     focusedBorder: OutlineInputBorder(
//                       borderSide:
//                       BorderSide(color: Colors.grey, width: 1.0),
//                       borderRadius:
//                       BorderRadius.all(Radius.circular(4.0)),
//                     ),
//                   ),
//                 ),
//               ),
//               // ToggleableWidget(
//               //   value: showCodeEditor,
//               //   onChanged: (value) {
//               //     setState(() {
//               //       showCodeEditor = value;
//               //       if (showCodeEditor) {
//               //         codeEditorController.text = StatisticsSingleton()
//               //             .statistics
//               //             ?.snippetsListRaw
//               //             .toList()
//               //             .elementAt(index) ??
//               //             '';
//               //       } else {
//               //         rawString = StatisticsSingleton()
//               //             .statistics
//               //             ?.snippetsListRaw
//               //             .toList()
//               //             .elementAt(index) ??
//               //             '';
//               //       }
//               //     });
//               //   },
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }