//
// import 'package:flutter/material.dart';
//
// enum ClassificationSpecificEnum {
//   bat,
//   c,
//   cs,
//   cpp,
//   css,
//   dart,
//   erl,
//   go,
//   hs,
//   html,
//   java,
//   js,
//   lua,
//   md,
//   matlab,
//   m,
//   p,
//   php,
//   ps,
//   py,
//   r,
//   rb,
//   rs,
//   scala,
//   sh,
//   sql,
//   swift,
//   tex,
//   text,
//   toml,
//   ts,
//   yaml,
// }
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   List<ClassificationSpecificEnum> _languages = [
//     ClassificationSpecificEnum.bat,
//     ClassificationSpecificEnum.c,
//     ClassificationSpecificEnum.cs,
//     ClassificationSpecificEnum.cpp,
//     ClassificationSpecificEnum.cs,
//     ClassificationSpecificEnum.css,
//     ClassificationSpecificEnum.dart,
//     ClassificationSpecificEnum.erl,
//     ClassificationSpecificEnum.go,
//     ClassificationSpecificEnum.hs,
//     ClassificationSpecificEnum.html,
//     ClassificationSpecificEnum.java,
//     ClassificationSpecificEnum.js,
//     ClassificationSpecificEnum.lua,
//     ClassificationSpecificEnum.md,
//     ClassificationSpecificEnum.matlab,
//     ClassificationSpecificEnum.m,
//     ClassificationSpecificEnum.p,
//     ClassificationSpecificEnum.php,
//     ClassificationSpecificEnum.ps,
//     ClassificationSpecificEnum.py,
//     ClassificationSpecificEnum.r,
//     ClassificationSpecificEnum.rb,
//     ClassificationSpecificEnum.rs,
//     ClassificationSpecificEnum.scala,
//     ClassificationSpecificEnum.sh,
//     ClassificationSpecificEnum.sql,
//     ClassificationSpecificEnum.swift,
//     ClassificationSpecificEnum.tex,
//     ClassificationSpecificEnum.text,
//     ClassificationSpecificEnum.toml,
//     ClassificationSpecificEnum.ts,
//     ClassificationSpecificEnum.yaml,
//   ];
//
//   Future<void> _testReclassify(ClassificationSpecificEnum ext) async {
//     // Replace this with your own implementation
//     print('Reclassifying asset with extension: $ext');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Classification Specific'),
//         ),
//         body: Center(
//           child: DropdownButton<ClassificationSpecificEnum>(
//             value: _languages[0],
//             // onChanged: (ClassificationSpecificEnum newValue) {
//             //   setState(() {
//             //     _testReclassify(newValue);
//             //   });
//             // },
//             onChanged: (ClassificationSpecificEnum? newValue) {
//               setState(() {
//                 _testReclassify(newValue!);
//               });
//             },
//             items: _languages
//                 .map<DropdownMenuItem<ClassificationSpecificEnum>>(
//                     (ClassificationSpecificEnum value) {
//                   return DropdownMenuItem<ClassificationSpecificEnum>(
//                     value: value,
//                     child: Row(
//                       children: [
//                         Icon(Icons.language),
//                         SizedBox(width: 10),
//                         Text(value.toString()),
//                       ],
//                     ),
//                   );
//                 }).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// void main() {
//   runApp(MyApp());
// }




import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Switch Statement Example',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Switch Statement Example'),
        ),
        body: SwitchStatement(),
      ),
    );
  }
}

class SwitchStatement extends StatelessWidget {
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 350,
      width: 200,
      child: ListView.builder(
          itemCount: languages.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              // leading: Text('$index'),
              title: Text(languages[index]),
              // leadingPadding: EdgeInsets.symmetric(vertical: 8.0),
              trailing: Image.asset(
                '${pngList[index]}',
                height: 48.0,
                width: 48.0,
              ),
            );
          }),
    );
  }

  Widget switchFunction() {
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
}
