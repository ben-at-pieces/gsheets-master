// import 'package:connector_openapi/api.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:runtime_client/particle.dart';
// import 'package:url_launcher/url_launcher.dart';
//
// import '../../TabAppBar.dart';
// import '../../api.dart';
// import '../../statistics_singleton.dart';
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
// class DartImageBuilder extends StatelessWidget {
//   final String title;
//   final String subtitle;
//   final Image leading;
//
//   DartImageBuilder({
//     required this.title,
//     required this.subtitle,
//     required this.leading,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     int? count = StatisticsSingleton().statistics?.dart.length;
//
//     return Container(
//       color: Colors.grey,
//       child: ListView.builder(
//         itemCount: count,
//         itemBuilder: (BuildContext context, int index) {
//           return SizedBox(
//             // height: 200,
//             child: Card(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     '$title ',
//                     style: ParticleFont.button(context, customization: TextStyle(color: Colors.grey)),
//                     maxLines: 1,
//                   ),
//                   ListTile(
//                     leading: Image.asset('dart.jpg'),
//                     title: Row(
//                       children: [
//
//
//                         SizedBox(
//                           width: 200,
//                           child: Text(
//                             '${StatisticsSingleton().statistics?.dart.elementAt(index).name}' ?? '',
//                             style: ParticleFont.bodyText1(
//                               context,
//                               customization: TextStyle(color: Colors.black, fontSize: 14),
//                             ),
//                           ),
//                         ),
//                         TextButton(
//                           child: SizedBox(
//                             height: 40,
//                             width: 40,
//                             child: Image.asset(
//                               'pieces_small.jpeg',
//                             ),
//                           ),
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                     title: Text(
//                                         '${StatisticsSingleton().statistics?.dart.elementAt(index).name}'),
//                                     content: SizedBox(
//                                       height: 150,
//                                       child: SingleChildScrollView(
//                                         child: Text(
//                                             '${StatisticsSingleton().statistics?.dart.elementAt(index).original.reference?.fragment?.string?.raw}'),
//                                       ),
//                                     ),
//                                     actions: <Widget>[
//                                       TextButton(
//                                         child: Row(
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 'Reference Chat GPT!',
//                                                 style: TextStyle(color: Colors.blueGrey),
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 20,
//                                               child: Image.asset('chatgptSmall.jpeg'),
//                                             ),
//                                           ],
//                                         ),
//                                         onPressed: () async {
//                                           String linkUrl = 'https://chat.openai.com/chat';
//
//                                           linkUrl = linkUrl; //Twitter's URL
//                                           if (await canLaunch(linkUrl)) {
//                                             await launch(
//                                               linkUrl,
//                                             );
//                                           } else {
//                                             throw 'Could not launch $linkUrl';
//                                           }
//                                         },
//                                       ),
//                                       TextButton(
//                                         child: Text('copy'),
//                                         onPressed: () async {
//                                           ScaffoldMessenger.of(context).showSnackBar(
//                                             SnackBar(
//                                               content: Text(
//                                                 'Copied to Clipboard',
//                                               ),
//                                               duration: Duration(
//                                                   days: 0,
//                                                   hours: 0,
//                                                   minutes: 0,
//                                                   seconds: 1,
//                                                   milliseconds: 30,
//                                                   microseconds: 20),
//                                             ),
//                                           );
//                                           ClipboardData data = ClipboardData(
//                                               text:
//                                               '${StatisticsSingleton().statistics?.batch.elementAt(index).original.reference?.fragment?.string?.raw}');
//                                           await Clipboard.setData(data);
//                                         },
//                                       ),
//
//                                       ParticleButton(
//                                         textColor: Colors.white,
//                                         backgroundColor: Colors.black54,
//                                         onPressed: () {
//                                           Navigator.of(context).pop();
//                                         },
//                                         text: ('close'),
//                                       ),
//                                     ]);
//                               },
//                             );
//                           },
//                         ),  ],
//                     ),
//                     trailing: TextButton(
//                       child: SizedBox(
//                         height: 30,
//                         width: 30,
//                         child: Image.asset('black_GPT.png'),
//                       ),
//                       onPressed: () async {
//                         String linkUrl = 'https://chat.openai.com/chat';
//
//                         linkUrl = linkUrl; //Twitter's URL
//                         if (await canLaunch(linkUrl)) {
//                           await launch(
//                             linkUrl,
//                           );
//                         } else {
//                           throw 'Could not launch $linkUrl';
//                         }
//                       },
//                     ),
//                     subtitle: Padding(
//                       padding: const EdgeInsets.only(top: 8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               SizedBox(
//                                 width: 210,
//                                 height: 125,
//                                 child: SingleChildScrollView(
//                                   child: Text(
//                                     '${StatisticsSingleton().statistics?.dart.elementAt(index).description}' ??
//                                         '', style: ParticleFont.micro(context, customization: TextStyle(color: Colors.black)),
//                                   ),
//                                 ),
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(left: 20.0),
//                                 child: Container(
//                                   color: Colors.black87,
//                                   width: 245,
//                                   height: 125,
//                                   child: SingleChildScrollView(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(10.0),
//                                       child: Text(
//                                         '${StatisticsSingleton().statistics?.dart.elementAt(index).original.reference?.fragment?.string?.raw}' ??
//                                             '', style: ParticleFont.micro(context, customization: TextStyle(color: Colors.white)),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                           // SizedBox(
//                           //   width: 350,
//                           //   height: 230,
//                           //   child: Text(
//                           //       '${StatisticsSingleton().statistics?.dart.elementAt(index).original.reference?.fragment?.string?.raw}' ??
//                           //           ''),
//                           // ),
//                           Divider(
//                             color: Colors.grey,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               IconButton(
//                                 tooltip: 'copy',
//                                 splashRadius: 2,
//                                 icon: Icon(
//                                   Icons.copy,
//                                   color: Colors.grey,
//                                   size: 20,
//                                 ),
//                                 onPressed: () async {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                         'Copied to Clipboard',
//                                       ),
//                                       duration: Duration(
//                                           days: 0,
//                                           hours: 0,
//                                           minutes: 0,
//                                           seconds: 1,
//                                           milliseconds: 30,
//                                           microseconds: 20),
//                                     ),
//                                   );
//                                   ClipboardData data = ClipboardData(
//                                       text:
//                                           '${StatisticsSingleton().statistics?.batch.elementAt(index).original.reference?.fragment?.string?.raw}');
//                                   await Clipboard.setData(data);
//                                 },
//                               ),
//                               FloatingActionButton(
//                                 focusColor: Colors.green,
//                                 tooltip: 'View Tags',
//                                 hoverColor: Colors.grey,
//                                 elevation: 0,
//                                 backgroundColor: Colors.transparent,
//                                 child: Icon(
//                                   Icons.local_offer_outlined,
//                                   size: 20,
//                                   color: Colors.black54,
//                                 ),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                           // title: '${StatisticsSingleton().statistics?.dart.elementAt(index).name}',
//                                           title: Text(
//                                               'Snippet: ${StatisticsSingleton().statistics?.dart.elementAt(index).name} Tags'),
//                                           content: Text(
//                                               '${StatisticsSingleton().statistics?.dart.elementAt(index).tags?.iterable.toList().elementAt(index).text}'),
//                                           actions: <Widget>[
//                                             TextButton(
//                                               child: SizedBox(
//                                                 height: 20,
//                                                 child: Image.asset('chatgptSmall.jpeg'),
//                                               ),
//                                               onPressed: () async {
//                                                 String linkUrl = 'https://chat.openai.com/chat';
//
//                                                 linkUrl = linkUrl; //Twitter's URL
//                                                 if (await canLaunch(linkUrl)) {
//                                                   await launch(
//                                                     linkUrl,
//                                                   );
//                                                 } else {
//                                                   throw 'Could not launch $linkUrl';
//                                                 }
//                                               },
//                                             ),
//                                             ParticleButton(
//                                               textColor: Colors.white,
//                                               backgroundColor: Colors.black54,
//                                               onPressed: () {
//                                                 Navigator.of(context).pop();
//                                               },
//                                               text: ('close'),
//                                             ),
//                                           ]);
//                                     },
//                                   );
//                                 },
//                               ),
//                               FloatingActionButton(
//                                 focusColor: Colors.green,
//                                 tooltip: 'Share Snippet Link',
//                                 hoverColor: Colors.grey,
//                                 elevation: 0,
//                                 backgroundColor: Colors.transparent,
//                                 child: Icon(
//                                   Icons.share,
//                                   size: 20,
//                                   color: Colors.black54,
//                                 ),
//                                 onPressed: () {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       backgroundColor: Colors.black87,
//                                       content: Text(
//                                         'Generating sharable link!',
//                                         style: ParticleFont.micro(context,
//                                             customization: TextStyle(
//                                               color: Colors.green,
//                                               fontSize: 18,
//                                             )),
//                                       ),
//                                       duration: Duration(
//                                           days: 0,
//                                           hours: 0,
//                                           minutes: 0,
//                                           seconds: 1,
//                                           milliseconds: 30,
//                                           microseconds: 10),
//                                     ),
//                                   );
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     SnackBar(
//                                       backgroundColor: Colors.white,
//                                       content: Text(
//                                         'Link Copied to Clipboard!',
//                                         style: ParticleFont.micro(context,
//                                             customization: TextStyle(
//                                               color: Colors.green,
//                                               fontSize: 18,
//                                             )),
//                                       ),
//                                       duration: Duration(
//                                           days: 0,
//                                           hours: 0,
//                                           minutes: 0,
//                                           seconds: 1,
//                                           milliseconds: 30,
//                                           microseconds: 10),
//                                     ),
//                                   );
//                                 },
//                               ),
//                               FloatingActionButton(
//                                 focusColor: Colors.green,
//                                 tooltip: 'View Related Links',
//                                 hoverColor: Colors.grey,
//                                 elevation: 0,
//                                 backgroundColor: Colors.transparent,
//                                 child: Icon(
//                                   Icons.link,
//                                   size: 20,
//                                   color: Colors.black54,
//                                 ),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         // title: '${StatisticsSingleton().statistics?.dart.elementAt(index).name}',
//                                         title: Text('Snippet: links'),
//                                         content:
//                                             Text('${StatisticsSingleton().statistics?.relatedLinks}'),
//                                         actions: <Widget>[
//                                           TextButton(
//                                             child: SizedBox(
//                                               height: 20,
//                                               child: Image.asset('chatgptSmall.jpeg'),
//                                             ),
//                                             onPressed: () async {
//                                               String linkUrl = 'https://chat.openai.com/chat';
//
//                                               linkUrl = linkUrl; //Twitter's URL
//                                               if (await canLaunch(linkUrl)) {
//                                                 await launch(
//                                                   linkUrl,
//                                                 );
//                                               } else {
//                                                 throw 'Could not launch $linkUrl';
//                                               }
//                                             },
//                                           ),
//                                           ParticleButton(
//                                             textColor: Colors.white,
//                                             backgroundColor: Colors.black54,
//                                             onPressed: () {
//                                               Navigator.of(context).pop();
//                                             },
//                                             text: ('close'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                               FloatingActionButton(
//                                 focusColor: Colors.green,
//                                 tooltip: 'Delete Snippet',
//                                 hoverColor: Colors.grey,
//                                 elevation: 0,
//                                 backgroundColor: Colors.transparent,
//                                 child: Icon(
//                                   Icons.delete,
//                                   size: 20,
//                                   color: Colors.black54,
//                                 ),
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) {
//                                       return AlertDialog(
//                                         // title: '${StatisticsSingleton().statistics?.dart.elementAt(index).name}',
//                                         title: Text('Are you sure you want to delete this snippet?'),
//                                         content: Text(
//                                             '${StatisticsSingleton().statistics?.dart.elementAt(index).name}'),
//                                         actions: [
//                                           ParticleButton(
//                                             textColor: Colors.white,
//                                             backgroundColor: Colors.red,
//                                             onPressed: () async {
//                                               Navigator.of(context).pop();
//                                               Assets assets = await assetsApi.assetsSnapshot();
//
//                                               Asset deletedAsset = assets.iterable.elementAt(index);
//
//                                               String deleted = await PiecesApi.assetsApi
//                                                   .assetsDeleteAsset(deletedAsset.id);
//                                             },
//                                             text: ('Delete'),
//                                           ),
//                                           ParticleButton(
//                                             textColor: Colors.white,
//                                             backgroundColor: Colors.black54,
//                                             onPressed: () async {
//                                               Navigator.of(context).pop();
//                                             },
//                                             text: ('close'),
//                                           ),
//                                         ],
//                                       );
//                                     },
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
