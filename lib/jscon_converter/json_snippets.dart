// import 'package:flutter/material.dart';
// import 'package:runtime_client/particle.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../statistics_singleton.dart';
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   MyApp({Key? key}) : super(key: key);
//
// // This widget is the root
// // of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: "ListView.builder",
//         theme: ThemeData(primarySwatch: Colors.green),
//         debugShowCheckedModeBanner: false,
//         // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
//         home: JSONListWidget());
//   }
// }
//
// class JSONListWidget extends StatelessWidget {
//   JSONListWidget({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         color: Colors.black12,
//         child:  ListView.builder(
//             itemCount: StatisticsSingleton().statistics?.json.length,
//             itemBuilder: (BuildContext context, int index) {
//               return ListTile(
//                   leading:  IconButton(
//                     tooltip: 'copy',
//                     splashRadius: 2,
//                     icon: Icon(
//                       Icons.copy,
//                       color: Colors.black,
//                       size: 18,
//                     ),
//                     onPressed: () async {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                         SnackBar(
//                           content: Text(
//                             'Copied to Clipboard',
//                           ),
//                           duration: Duration(
//                               days: 0,
//                               hours: 0,
//                               minutes: 0,
//                               seconds: 1,
//                               milliseconds: 30,
//                               microseconds: 10),
//                         ),
//                       );
//                       ClipboardData data = ClipboardData(text: '${StatisticsSingleton().statistics?.json.elementAt(index).original.reference?.fragment?.string?.raw}');
//                       await Clipboard.setData(data);
//                     },
//                   ),
//                   trailing:  Icon(
//                     Icons.transform,
//                     color: Colors.black,
//                     size: 18,
//                   ),
//                   title: Text("${StatisticsSingleton().statistics?.json.elementAt(index).name}"));
//
//
//               // title: Text('Person: $index'));
//             }),
//       ),
//       // bottomNavigationBar: CutomBottomAppBar(),
//     );
//   }
// }
