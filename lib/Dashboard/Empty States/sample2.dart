// ignore_for_file: prefer_final_fields, omit_local_variable_types

import 'package:connector_openapi/api.dart';
import 'package:flutter/material.dart';
import 'package:gsheets/Dashboard/Empty%20States/sample.dart';

import '../../Bottom_bar/bottom_appbar_class.dart';
import '../../CustomAppBar.dart';

void main() {
  runApp(LanguagesGrid());
}

class LanguagesGrid extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<LanguagesGrid> {


  @override
  Widget build(BuildContext context) {
    final imageAssetName = pngList[index] ?? '';
    return MaterialApp(
      color: Colors.black87,
      debugShowCheckedModeBanner: false,
      title: 'Programming Languages',
      home: Scaffold(
        backgroundColor: Colors.black87,
        appBar: CustomAppBar(title: 'languages',
        ),
        body: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 6),
          itemCount: languages.length,
          itemBuilder: (BuildContext context, int index) {
            final language = languages[index];
            // final languageName = languages[index] ?? '';


            return Scaffold(
              // appBar: AppBar(
              //   title: Text(languages[index]),
              //   // leading: Image.asset('${pngList.elementAt(index)}'),
              // ),
              body: InkWell(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 35,
                            width: 35,
                            child: Image.asset(
                              '${pngList[index]}',
                              height: 100.0,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('$language'),
                          ),
                        ],
                      ),
                      content: SingleChildScrollView(
                        child: Container(
                          color: Colors.white,
                          child: ListBody(
                            children: <Widget>[

                              SizedBox(height: 10.0),
                              Text(
                                'This language is used for...',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              // Text(_languageDescriptionMap[language]),
                            ],
                          ),
                        ),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        '${pngList[index]}',
                        height: 64,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        language,
                        // style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        bottomNavigationBar: CustomBottomAppBar(),
      ),
    );
  }
}
List<ClassificationSpecificEnum> _languages = [
  ClassificationSpecificEnum.bat,
  ClassificationSpecificEnum.c,
  ClassificationSpecificEnum.cs,
  ClassificationSpecificEnum.cpp,
  ClassificationSpecificEnum.cs,
  ClassificationSpecificEnum.css,
  ClassificationSpecificEnum.dart,
  ClassificationSpecificEnum.erl,
  ClassificationSpecificEnum.go,
  ClassificationSpecificEnum.hs,
  ClassificationSpecificEnum.html,
  ClassificationSpecificEnum.java,
  ClassificationSpecificEnum.js,
  ClassificationSpecificEnum.lua,
  ClassificationSpecificEnum.md,
  ClassificationSpecificEnum.matlab,
  ClassificationSpecificEnum.m,
  ClassificationSpecificEnum.p,
  ClassificationSpecificEnum.php,
  ClassificationSpecificEnum.ps,
  ClassificationSpecificEnum.py,
  ClassificationSpecificEnum.r,
  ClassificationSpecificEnum.rb,
  ClassificationSpecificEnum.rs,
  ClassificationSpecificEnum.scala,
  ClassificationSpecificEnum.sh,
  ClassificationSpecificEnum.sql,
  ClassificationSpecificEnum.swift,
  ClassificationSpecificEnum.tex,
  ClassificationSpecificEnum.text,
  ClassificationSpecificEnum.toml,
  ClassificationSpecificEnum.ts,
  ClassificationSpecificEnum.yaml,
];
final List<String> pngList = [
  'batchfile-black.jpg',
  'c.jpg',
  'coffeescript-black.jpg',
  'cpp.jpg',
  'c-sharp.jpg',
  'css.jpg',
  'dart.jpg',
  'erlang.jpg',
  'go.jpg',
  'haskell.jpg',
  'html.jpg',
  'java.jpg',
  'javascript.jpg',
  'json.jpg',
  'lua.jpg',
  'markdown-black.jpg',
  'matlab.jpg',
  'objective-c.jpg',
  'perl.jpg',
  'php.jpg',
  'powershell.jpg',
  'python.jpg',
  'r.jpg',
  'ruby.jpg',
  'rust-black.jpg',
  'scala.jpg',
  'sql.jpg',
  'swift.jpg',
  'typescript.jpg',
  'tex-black.jpg',
  'text.jpg',
  'toml-black.jpg',
  'yaml-black.jpg'
];
// void _showLanguageDetails(ClassificationSpecificEnum language) {
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return AlertDialog(
//         // title: Text(_languageNameMap[language]),
//         content: SingleChildScrollView(
//           child: ListBody(
//             children: <Widget>[
//               Image.asset(
//                 'img.png',
//                 height: 100.0,
//               ),
//               SizedBox(height: 10.0),
//               Text(
//                 'This language is used for...',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//               // Text(_languageDescriptionMap[language]),
//             ],
//           ),
//         ),
//         actions: <Widget>[
//           TextButton(
//             child: Text('OK'),
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//           ),
//         ],
//       );
//     },
//   );
// }

final int index = 0;
List<String> languages = [
  'Batchfile',
  'C',
  'Coffeescript',
  'C++',
  'C#',
  'CSS',
  'Dart',
  'Erlang',
  'Go',
  'Haskell',
  'HTML',
  'Java',
  'Javascript',
  'JSON',
  'Lua',
  'MarkDown',
  'Matlab',
  'ObjectiveC',
  'Perl',
  'PHP',
  'Powershell',
  'Python',
  'R',
  'Ruby',
  'Rust',
  'Scala',
  'SQL',
  'Swift',
  'Tex',
  'Text',
  'Toml',
  'Typescript',
  'YAML',
];

Widget switchFunction() {
  final List<String> pngList = [
    'batchfile-black.jpg',
    'c.jpg',
    'coffeescript-black.jpg',
    'cpp.jpg',
    'c-sharp.jpg',
    'css.jpg',
    'dart.jpg',
    'erlang.jpg',
    'go.jpg',
    'haskell.jpg',
    'html.jpg',
    'java.jpg',
    'javascript.jpg',
    'json.jpg',
    'lua.jpg',
    'markdown-black.jpg',
    'matlab.jpg',
    'objective-c.jpg',
    'perl.jpg',
    'php.jpg',
    'powershell.jpg',
    'python.jpg',
    'r.jpg',
    'ruby.jpg',
    'rust-black.jpg',
    'scala.jpg',
    'sql.jpg',
    'swift.jpg',
    'typescript.jpg',
    'tex-black.jpg',
    'text.jpg',
    'toml-black.jpg',
    'yaml-black.jpg'
  ];

  switch (languages[index]) {
    case 'Batchfile':
      return Image.asset(pngList[0]);
    case 'C':
      return Image.asset(pngList[1]);
    case 'Coffeescript':
      return Image.asset(pngList[2]);
    case 'C++':
      return Image.asset(pngList[4]);
    case 'C#':
      return Image.asset(pngList[3]);
    case 'CSS':
      return Image.asset(pngList[5]);
    case 'Dart':
      return Image.asset(pngList[6]);
    case 'Erlang':
      return Image.asset(pngList[7]);
    case 'Go':
      return Image.asset(pngList[8]);
    case 'Haskell':
      return Image.asset(pngList[9]);
    case 'HTML':
      return Image.asset(pngList[10]);
    case 'Image':
      return Image.asset(pngList[11]);
    case 'Java':
      return Image.asset(pngList[12]);
    case 'Javascript':
      return Image.asset(pngList[13]);
    case 'JSON':
      return Image.asset(pngList[14]);
    case 'Lua':
      return Image.asset(pngList[15]);
    case 'MarkDown':
      return Image.asset(pngList[16]);
    case 'Matlab':
      return Image.asset(pngList[17]);
    case 'ObjectiveC':
      return Image.asset(pngList[18]);
    case 'Perl':
      return Image.asset(pngList[19]);
    case 'PHP':
      return Image.asset(pngList[20]);
    case 'Powershell':
      return Image.asset(pngList[21]);
    case 'Python':
      return Image.asset(pngList[22]);
    case 'R':
      return Image.asset(pngList[23]);
    case 'Ruby':
      return Image.asset(pngList[24]);
    case 'Rust':
      return Image.asset(pngList[25]);
    case 'Scala':
      return Image.asset(pngList[26]);
    case 'Shell':
      return Image.asset(pngList[27]);
    case 'SQL':
      return Image.asset(pngList[28]);
    case 'Swift':
      return Image.asset(pngList[29]);
    case 'Tex':
      return Image.asset(pngList[30]);
    case 'Text':
      return Image.asset(pngList[31]);
    case 'Toml':
      return Image.asset(pngList[32]);
    case 'Typescript':
      return Image.asset(pngList[33]);
    case 'YAML':
      return Image.asset(pngList[34]);
    default:
      return Text('Invalid input');
  }
}
