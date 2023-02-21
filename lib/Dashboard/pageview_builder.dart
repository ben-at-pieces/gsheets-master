// import 'package:connector_openapi/api.dart';
// import 'package:flutter/material.dart';
// import 'package:gsheets/Dashboard/pro_tips.dart';
// import 'package:runtime_client/particle.dart';
//
// import '../connections/statistics.dart';
// import '../connections/statistics_singleton.dart' hide getStats;
//
// import 'package:flutter/services.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import 'cloud.dart';
// import 'faqs.dart';
//
// void main() async {
//   StatisticsSingleton().statistics = await getStats();
//
//   print('${StatisticsSingleton().statistics?.classifications.keys}');
//   runApp(
//     MyApp(),
//   );
// }
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
//       home:  PageLanguageBuilder( subtitle: '',),
//     );
//   }
// }
//
// class PageLanguageBuilder extends StatelessWidget {
//   // final String title;
//   final String subtitle;
//   // final Image leading;
//
//   PageLanguageBuilder({
//     // required this.title,
//     required this.subtitle,
//     // required this.leading,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       color: Colors.grey,
//       child: ListView.builder(
//         itemCount: StatisticsSingleton().statistics?.asset.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Card(
//             elevation: 2,
//             child: Container(
//               height: 350,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   ListTile(
//                     leading: Image.asset('batchfile-black.jpg'),
//                     title: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           StatisticsSingleton().statistics?.filteredLanguages.elementAt(index).toList().elementAt(index).original.reference?.fragment?.string?.raw.toString() ?? '',
//                           style: ParticleFont.bodyText1(
//                             context,
//                             customization: TextStyle(fontSize: 15, color: Colors.black),
//                           ),
//                         ),
//                         Text(
//                           '${StatisticsSingleton().statistics?.platform.toLowerCase()}' ?? '',
//                           style: ParticleFont.bodyText1(
//                             context,
//                             customization: TextStyle(fontSize: 10, color: Colors.black),
//                           ),
//                         ),
//                         Text(
//                           'os: ${StatisticsSingleton().statistics?.version}' ?? '',
//                           style: ParticleFont.bodyText1(
//                             context,
//                             customization: TextStyle(fontSize: 10, color: Colors.black),
//                           ),
//                         ),
//                         CustomIconButton(icon: Icons.cloud,  onPressed: (){},),
//                       ],
//                     ),
//                     // subtitle: Column(
//                     //   crossAxisAlignment: CrossAxisAlignment.end,
//                     //   children: [
//                     //       ],
//                     // ),
//                     trailing: Icon(
//                       Icons.add_box_outlined,
//                       size: 20,
//                       color: Colors.white,
//                     ),
//                   ),
//                   Divider(
//                     color: Colors.grey,
//                   ),
//
//
//
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 12,
//                       top: 5.0,
//                     ),
//                     child: Text(
//                       'Classifications: ${StatisticsSingleton().statistics?.classifications} ',
//                       style: ParticleFont.subtitle1(
//                         context,
//                         customization: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Padding(
//                     padding: const EdgeInsets.only(
//                       left: 12,
//                       top: 5.0,
//                     ),
//                     child: Text(
//                       'Classifications: ${StatisticsSingleton().statistics?.relatedLinks.elementAt(index)} ',
//                       style: ParticleFont.subtitle1(
//                         context,
//                         customization: TextStyle(
//                           fontSize: 14,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                   ),
//
//                   Divider(
//                     color: Colors.grey,
//                   ),
//                   ListTile(
//                     leading: FloatingActionButton(
//                       focusColor: Colors.green,
//                       tooltip: 'power tips',
//                       hoverColor: Colors.grey,
//                       elevation: 0,
//                       backgroundColor: Colors.transparent,
//                       child: Icon(
//                         Icons.tips_and_updates,
//                         size: 25,
//                         color: Colors.black54,
//                       ),
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return
//                               FloatingProTipButton();
//                           },
//                         );
//                       },
//                     ),
//                     trailing: FloatingActionButton(
//                       focusColor: Colors.green,
//                       tooltip: 'power tips',
//                       hoverColor: Colors.grey,
//                       elevation: 0,
//                       backgroundColor: Colors.transparent,
//                       child: Icon(
//                         Icons.settings_outlined,
//                         size: 25,
//                         color: Colors.black,
//                       ),
//                       onPressed: () {
//                         showDialog(
//                           context: context,
//                           builder: (context) {
//                             return
//                               FloatingSettingsButton();
//                           },
//                         );
//                       },
//                     ),
//                     // trailing: FloatingActionButton(
//                     //   focusColor: Colors.green,
//                     //   tooltip: 'power tips',
//                     //   hoverColor: Colors.grey,
//                     //   elevation: 0,
//                     //   backgroundColor: Colors.transparent,
//                     //   child: Icon(
//                     //     Icons.settings,
//                     //     size: 25,
//                     //     color: Colors.black,
//                     //   ),
//                     //   onPressed: () {
//                     //     showDialog(
//                     //       context: context,
//                     //       builder: (context) {
//                     //         return
//                     //           FloatingSettingsButton();
//                     //       },
//                     //     );
//                     //   },
//                     // ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// final TextEditingController _textFieldController = TextEditingController();
