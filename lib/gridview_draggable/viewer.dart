// import 'package:connector_openapi/api.dart';
// import 'package:flutter/material.dart';
//
// class Add_Piece extends StatelessWidget {
//   final TextEditingController _textFieldController = TextEditingController();
//
//   /// add a piece
//   popup(BuildContext context) async {
//     return showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Padding(
//             padding: const EdgeInsets.only(
//               top: 15.0,
//             ),
//             child: Text(
//               'Create a Custom Snippet:',
//               style: ParticleFont.subtitle1(context),
//             ),
//           ),
//           content: Column(
//             children: [
//               SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   /// close
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Container(
//                         height: 20,
//                         width: 110,
//                         child: TextButton(
//                           child: Text(
//                             'close',
//                             style: ParticleFont.micro(context),
//                           ),
//                           onPressed: () async {
//                             Navigator.of(context).pop();
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(5.0),
//                     child: ClipRRect(
//                       borderRadius: BorderRadius.circular(8),
//                       child: Container(
//                         height: 30,
//                         width: 110,
//                         color: Colors.black,
//                         child: TextButton(
//                           child: Text(
//                             "save to pieces",
//                             textAlign: TextAlign.center,
//                             style: ParticleFont.button(context),
//                           ),
//                           onPressed: () async {
//                             Context connection = await connect();
//
//                             String create = await connectorApi.create(
//                               connection.application.id,
//                               seededConnectorCreation: SeededConnectorCreation(
//                                 asset: SeededConnectorAsset(
//                                   metadata: SeededAssetMetadata(
//                                     description: 'SNIPPET FROM EXPEDITION',
//                                     name: 'PIECES EXPEDITION',
//                                     mechanism: MechanismEnum.MANUAL,
//                                   ),
//                                   format: SeededFormat(
//                                     websites: [
//                                       SeededWebsite(
//                                         asset: '',
//                                         url: 'www.pieces.app',
//                                         name: '',
//                                       ),
//                                     ],
//                                     fragment: SeededFragment(
//                                       metadata:
//                                           FragmentMetadata(ext: ClassificationSpecificEnum.text),
//                                       string: TransferableString(
//                                         raw: _textFieldController.text,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             );
//
//                             Navigator.of(context).pop();
//
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 backgroundColor: Colors.white,
//                                 content: Text(
//                                   'Saved',
//                                   style: ParticleFont.micro(context,
//                                       customization: TextStyle(
//                                         color: Colors.green,
//                                       )),
//                                 ),
//                                 duration: Duration(
//                                     days: 0,
//                                     hours: 0,
//                                     minutes: 0,
//                                     seconds: 1,
//                                     milliseconds: 30,
//                                     microseconds: 10),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: Container(
//         color: Colors.black54,
//         child: FloatingActionButton(
//           child: Icon(
//             Icons.add,
//             size: 16,
//             color: Colors.white,
//           ),
//           onPressed: () {
//             showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialog(
//                   title: Text(
//                     'Create a Custom Snippet:',
//                     style: ParticleFont.subtitle1(context, customization: TextStyle(fontSize: 14)),
//                   ),
//                   content: Column(
//                     children: [
//                       Text(
//                         'words',
//                         style: ParticleFont.micro(context,
//                             customization: TextStyle(color: Colors.grey)),
//                       ),
//                       Divider(),
//                       Container(
//                         color: Colors.black54,
//                         height: 150,
//                         width: 250,
//                         child: TextField(
//                           autofocus: true,
//                           style:
//                               ParticleFont.micro(context, customization: TextStyle(fontSize: 14)),
//                           toolbarOptions: ToolbarOptions(
//                             copy: true,
//                             paste: true,
//                             selectAll: true,
//                           ),
//                           cursorHeight: 20,
//                           cursorColor: Colors.white,
//                           minLines: 20,
//                           maxLines: 20,
//                           autocorrect: true,
//                           controller: _textFieldController,
//                           decoration: InputDecoration(
//                             labelStyle: ParticleFont.micro(context),
//                             floatingLabelBehavior: FloatingLabelBehavior.auto,
//                             labelText: 'paste code [ctrl + v]',
//                             border: OutlineInputBorder(),
//                             hintStyle: ParticleFont.micro(context),
//                             suffixIcon: Column(
//                               children: [
//                                 IconButton(
//                                   iconSize: 15,
//                                   icon: Icon(
//                                     Icons.undo,
//                                     color: Colors.grey,
//                                   ),
//                                   onPressed: () {
//                                     _textFieldController.clear();
//                                   },
//                                 ),
//                                 IconButton(
//                                   iconSize: 15,
//                                   icon: Icon(
//                                     Icons.clear,
//                                     color: Colors.grey,
//                                   ),
//                                   onPressed: () {
//                                     _textFieldController.clear();
//                                   },
//                                 ),
//                               ],
//                             ),
//                             enabledBorder: OutlineInputBorder(
//                               borderSide: BorderSide(
//                                 style: BorderStyle.solid,
//                                 color: Colors.white30,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   actions: [
//                     Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(8),
//                         child: Container(
//                           color: Colors.black,
//                           child: TextButton(
//                             child: Text(
//                               "save to pieces",
//                               style: ParticleFont.button(context),
//                             ),
//                             onPressed: () async {
//                               Context connection = await connect();
//
//                               String create = await connectorApi.create(
//                                 connection.application.id,
//                                 seededConnectorCreation: SeededConnectorCreation(
//                                   asset: SeededConnectorAsset(
//                                     metadata: SeededAssetMetadata(
//                                       description: 'SNIPPET FROM EXPEDITION',
//                                       name: 'PIECES EXPEDITION',
//                                       mechanism: MechanismEnum.MANUAL,
//                                     ),
//                                     format: SeededFormat(
//                                       websites: [
//                                         SeededWebsite(
//                                           asset: '',
//                                           url: 'www.pieces.app',
//                                           name: '',
//                                         ),
//                                       ],
//                                       fragment: SeededFragment(
//                                         metadata:
//                                             FragmentMetadata(ext: ClassificationSpecificEnum.dart),
//                                         string: TransferableString(
//                                           raw: _textFieldController.text,
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               );
//
//                               Navigator.of(context).pop();
//
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   backgroundColor: Colors.white,
//                                   content: Text(
//                                     'Saved',
//                                     style: ParticleFont.micro(context,
//                                         customization: TextStyle(
//                                           color: Colors.green,
//                                         )),
//                                   ),
//                                   duration: Duration(
//                                       days: 0,
//                                       hours: 0,
//                                       minutes: 0,
//                                       seconds: 1,
//                                       milliseconds: 30,
//                                       microseconds: 10),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                     ClipRRect(
//                       borderRadius: BorderRadius.circular(7),
//                       child: Padding(
//                         padding: const EdgeInsets.all(2.0),
//                         child: Container(
//                           color: Colors.black,
//                           child: TextButton(
//                             child: Text(
//                               "close",
//                               style: ParticleFont.micro(context),
//                             ),
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             );
//           },
//         ),
//       ),
//     );
//   }
//
//   Future<Context> connect() async {
//     try {
//       return connectorApi.connect(
//         seededConnectorConnection: SeededConnectorConnection(
//           application: SeededTrackedApplication(
//             name: ApplicationNameEnum.ULTRA_EDIT,
//             platform: PlatformEnum.MACOS,
//             version: '1.5.8',
//           ),
//         ),
//       );
//       // print('======== $connect');
//     } catch (err) {
//       throw Exception('Error occurred when establishing connection. error:$err');
//     }
//   }
// }
