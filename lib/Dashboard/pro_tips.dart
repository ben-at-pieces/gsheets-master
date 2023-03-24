// import 'package:connector_openapi/api.dart';
// import 'package:flutter/material.dart';
// import 'package:gsheets/Dashboard/settings_bar.dart';
//
//
// import 'package:flutter/services.dart';
// import 'package:runtime_client/particle.dart';
//
// import '../statistics_singleton.dart';
//
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
// // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'FAB',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: FloatingProTipButton(),
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
//
// class FloatingProTipButton extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<FloatingProTipButton> {
//   int? index = StatisticsSingleton().statistics?.python.length;
//
//   @override
//   Widget build(BuildContext context) {
//     return
//               AlertDialog(
//                 titleTextStyle: ParticleFont.micro(context),
//                 backgroundColor: Colors.white,
//                 title: Row(
//                   children: [
//                     // SizedBox(
//                     //   height: 50,
//                     //   width: 50,
//                     //   child: Image.asset('icon_path_black.png'),
//                     // ),
//                     Text('Pro Tips', style: TextStyle(color: Colors.black),)
//                   ],
//                 ),
//                 content: Container(
//                     height: 280,
//                     width: 400,
//
//                     child: SearchableListView()),
//                 // content:
//
//
//
//               );
//   }
// }
// final TextEditingController _textFieldController = TextEditingController();
