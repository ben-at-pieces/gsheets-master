// import 'package:core_openapi/api.dart' hide Theme;
// import 'package:core_openapi/api_client.dart';
// import 'package:flutter/material.dart';
//
// String port = '1000';
// String host = 'http://localhost:$port';
// AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));
// AssetApi assetApi = AssetApi(ApiClient(basePath: host));
// UserApi userApi = UserApi(ApiClient(basePath: host));
//
// void main() async {
//   Assets assets = await assetsApi.assetsSnapshot();
//   List<Asset> assetCount = assets.iterable;
//   var filterText = assetCount
//       .where((element) =>
//           element.original.reference?.classification.specific == ClassificationSpecificEnum.text)
//       .toList();
//   print('hello world ${filterText.length}');
//
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // title: 'Pieces Expedition',
//       // theme: ParticleTheme.darkPalette(context),
//       // darkTheme: ParticleTheme.darkPalette(context),
//       // themeMode: ThemeMode.dark,
//       home: TreeView(),
//     );
//   }
// }
//
// class TreeView extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       /// Text field and clear button logic
//       ///
//       body: Padding(
//         padding: EdgeInsets.all(4.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             /// Widget controlling number of notes
//             // ListViewSnapSheetExample(),
//             Center(
//               child: Column(
//                 children: <Widget>[
//                   /// table start  ========================================================
//
//                   Container(
//                     margin: EdgeInsets.all(10),
//                     child: Row(
//                       children: [
//                         /// languages
//                         Container(
//                           height: 530,
//                           width: 150,
//                           child: Table(
//                             // border: TableBorder.all(color: Colors.white),
//                             children: [
//                               /// ==== batch  ========================================================
//                               TableRow(children: [
//                                 /// language ========================================================
//
//                                 Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: SingleChildScrollView(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             Icon(
//                                               Icons.dynamic_feed_outlined,
//                                               size: 15,
//                                             ),
//                                             Text(
//                                               'LANGUAGE:',
//                                             ),
//                                           ],
//                                         ),
//                                         Padding(
//                                           padding: const EdgeInsets.only(top: 8.0),
//                                           child: Text(
//                                             'BATCHFILE',
//                                           ),
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'C',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'C#',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'CoffeeScript',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'C++',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'CSS',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Dart',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Erlang',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Go',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Haskell',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'HTML',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Java',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'JavaScript',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'JSON',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'LUA',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Markdown',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'MatLab',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Objective-C',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Php',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Perl',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Powershell',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Python',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'R',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Ruby',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Rust',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Scala',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Shell',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'SQL',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Swift',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'TypeScript',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Tex',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'Text',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'TOML',
//                                         ),
//                                         Divider(color: Colors.black, height: .5),
//                                         Text(
//                                           'YAML',
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 //
//                                 // /// count   =========================================================
//
//                                 // /// name
//                               ]),
//
//                               ///
//                             ],
//                           ),
//                         ),
//
//                         ///#s
//                         Container(
//                           height: 530,
//                           width: 100,
//                           child: Table(
//                             // border: TableBorder.all(color: Colors.black),
//                             children: [
//                               /// ==== batch  ========================================================
//                               TableRow(children: [
//                                 /// language ========================================================
//
//                                 SingleChildScrollView(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 8.0),
//                                         child: Row(
//                                           children: [
//                                             Icon(
//                                               Icons.dynamic_feed_outlined,
//                                               size: 15,
//                                             ),
//                                             Text(
//                                               'COUNT:',
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.only(top: 8.0),
//                                         child: Text(
//                                           '',
//                                         ),
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '2',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '2',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '1',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '2',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '2',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '1',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '2',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '7',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '4',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '9',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '6',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '9',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '6',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '8',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '5',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '8',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '2',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '0',
//                                       ),
//                                       Divider(color: Colors.black, height: .5),
//                                       Text(
//                                         '2',
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 //
//                                 // /// count   =========================================================
//
//                                 // /// name
//                               ]),
//
//                               ///
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             Divider(),
//
//             /// Widget controlling our text box decoration
//             // ListViewSnapSheetExample(),
//           ],
//         ),
//       ),
//       //
//       //   bottomSheet: ,
//     );
//   }
// }
