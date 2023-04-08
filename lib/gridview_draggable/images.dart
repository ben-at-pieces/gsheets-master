import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Images {
  static const String directory= 'assets/';
  static const String asset_1 =  'batchfile-black.jpg';
  static const String asset_2 =  'c.jpg';
  static const String asset_3 =  'c-sharp.jpg';
  static const String asset_4 =  'coffeescript-black.jpg';
  static const String asset_5 =  'cpp.jpg';
  static const String asset_6 =  'css.jpg';
  static const String asset_7 =  'dart.jpg';
  static const String asset_8 =  'erlang.jpg';
  static const String asset_9 =  'go.jpg';
  static const String asset_10 = 'haskell.jpg';
  static const String asset_11 = 'html.jpg';
  static const String asset_12 = 'java.jpg';
  static const String asset_13 = 'javascript.jpg';
  static const String asset_14 = 'json.jpg';
  static const String asset_15 = 'lua.jpg';
  static const String asset_16 = 'markdown-black.jpg';
  static const String asset_17 = 'matlab.jpg';
  static const String asset_18 = 'objective-c.jpg';
  static const String asset_19 = 'perl.jpg';
  static const String asset_20 = 'php.jpg';
  static const String asset_21 = 'powershell.jpg';
  static const String asset_22 = 'python.jpg';
  static const String asset_23 = 'r.jpg';
  static const String asset_24 = 'ruby.jpg';
  static const String asset_25 = 'rust-black.jpg';
  static const String asset_26 = 'scala.jpg';
  static const String asset_27 = 'sql.jpg';
  static const String asset_28 = 'swift.jpg';
  static const String asset_29 = 'typescript.jpg';
  static const String asset_30 = 'tex-black.jpg';
  static const String asset_31 = 'text.jpg';
  static const String asset_32 = 'toml-black.jpg';
  static const String asset_33 = 'yaml-black.jpg';
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Images App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Images'),
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: 33,
          itemBuilder: (context, index) {
            final assetName = 'assets/${index + 1}.jpg';
            return Image.asset(
              assetName,
              fit: BoxFit.cover,
            );
          },
        ),
      ),
    );
  }
}
