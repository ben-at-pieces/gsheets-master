// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../Card_Tab/hover_text.dart';
// import '../../connections/statistics_singleton.dart';
// import '../Empty States/batch_empty.dart';
// import '../dNotEmpty/batch_images_row.dart';
// import '../pageview_builder.dart';
//
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
//       theme: ThemeData(primarySwatch: Colors.green),
//       debugShowCheckedModeBanner: false,
//       // home : new ListViewBuilder(), NO Need To Use Unnecessary New Keyword
//       // home:  LanguageBuilder());
//     );
//   }
// }
//
// class BatchLanguageBuilder extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final Image leading;
//
//   BatchLanguageBuilder({
//     required this.title,
//     required this.subtitle,
//     required this.leading,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     int? count = StatisticsSingleton().statistics?.batch.length;
//
//     if (count == 0) {
//       return BatchEmptyBuilder();
//     } else {
//       return PageLanguageBuilder(subtitle: '', );
//     }
//   }
// }
