
/// =========================
import 'package:core_openapi/api.dart' hide Theme;
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/statistics_singleton.dart';
import 'package:test/test.dart';
import 'package:test/test.dart';

void main() {
  /// This is the set up for the Asset Api which will enable us to test our AssetInternalServer.
  /// The AssetApi comes from the isomorphic_openapi/api.dart
  /// The ApiClient comes from package:openapi_dart_common/openapi.dart
  /// The Host is used to set up the base route that we will be communicating with you will never need to change this.
  final port = '1000';
  final host = 'http://localhost:$port';
  final AssetApi assetApi = AssetApi(ApiClient(basePath: host));
  final AssetsApi assetsApi = AssetsApi(ApiClient(basePath: host));

  setUp(() async {
    // TODO Create an asset here, then check to see that
  });

  tearDown(() async {
    // TODO Delete the asset from OS Server
  });

  Future<void> testReclassify(ClassificationSpecificEnum ext) async {
    Assets assets = await assetsApi.assetsSnapshot(transferables: false);

    int index = StatisticsSingleton().statistics?.asset.length ?? 0;
    Asset response = await assetApi.assetReclassify(
        assetReclassification: AssetReclassification(
          ext: ext,
          asset: assets.iterable.elementAt(index),
        ));
    // expect(response.formats.iterable[0].classification.specific, ext);
  }

  group('Asset Reclassify', () {
    ///----------------1<-------------Reclassify First Asset to: C
    test('C ', () async {
      await testReclassify(ClassificationSpecificEnum.c);
    });

    ///----------------2<-------------Reclassify First Asset to: C++
    test('C++ ', () async {
      await testReclassify(ClassificationSpecificEnum.cpp);
    });

    ///----------------3<-------------Reclassify First Asset to: Batchfile
    test('BatchFile', () async {
      await testReclassify(ClassificationSpecificEnum.bat);
    });

    ///----------------4<-------------Reclassify First Asset to: CoffeeScript
    test('Coffee Script ', () async {
      await testReclassify(ClassificationSpecificEnum.cs);
    });

    ///----------------5<-------------Reclassify First Asset to:
    test('C # ', () async {
      await testReclassify(ClassificationSpecificEnum.cs);
    });

    ///----------------6<-------------Reclassify First Asset to: CSS
    test('CSS', () async {
      await testReclassify(ClassificationSpecificEnum.css);
    });

    ///----------------7<-------------Reclassify First Asset to: Dart
    test('Dart', () async {
      await testReclassify(ClassificationSpecificEnum.dart);
    });

    ///----------------8<-------------Reclassify First Asset to: Erlang
    test('Erlang', () async {
      await testReclassify(ClassificationSpecificEnum.erl);
    });

    ///----------------9<-------------Reclassify First Asset to: Go
    test('Go', () async {
      await testReclassify(ClassificationSpecificEnum.go);
    });

    ///----------------10<-------------Reclassify First Asset to: Groovy
    test('Groovy', () async {
      await testReclassify(ClassificationSpecificEnum.gz);
    });

    ///----------------11<-------------Reclassify First Asset to: Haskell
    test('Haskell', () async {
      await testReclassify(ClassificationSpecificEnum.hs);
    });

    ///----------------12<-------------Reclassify First Asset to: HTML
    test('HTML', () async {
      await testReclassify(ClassificationSpecificEnum.html);
    });

    ///----------------13<-------------Reclassify First Asset to: Java
    test('Java', () async {
      await testReclassify(ClassificationSpecificEnum.java);
    });

    ///----------------14<-------------Reclassify First Asset to: Javascript
    test('JavaScript', () async {
      await testReclassify(ClassificationSpecificEnum.js);
    });

    ///----------------15<-------------Reclassify First Asset to: Lua
    test('Lua', () async {
      await testReclassify(ClassificationSpecificEnum.lua);
    });

    ///----------------16<-------------Reclassify First Asset to: Markdown
    test('MarkDown', () async {
      await testReclassify(ClassificationSpecificEnum.md);
    });

    ///----------------17<-------------Reclassify First Asset to: Matlab
    test('MatLab', () async {
      await testReclassify(ClassificationSpecificEnum.matlab);
    });

    ///----------------18<-------------Reclassify First Asset to: Objective C
    test('Object C', () async {
      await testReclassify(ClassificationSpecificEnum.m);
    });

    ///----------------19<-------------Reclassify First Asset to: Perl
    test('Perl', () async {
      await testReclassify(ClassificationSpecificEnum.p);
    });

    ///----------------20<-------------Reclassify First Asset to: PHP
    test('PHP', () async {
      await testReclassify(ClassificationSpecificEnum.php);
    });

    ///----------------21<-------------Reclassify First Asset to: PowerShell
    test('PowerShell', () async {
      await testReclassify(ClassificationSpecificEnum.ps);
    });

    ///----------------22<-------------Reclassify First Asset to: Python
    test('Python', () async {
      await testReclassify(ClassificationSpecificEnum.py);
    });

    ///----------------23<-------------Reclassify First Asset to: R
    test('R', () async {
      await testReclassify(ClassificationSpecificEnum.r);
    });

    ///----------------23<-------------Reclassify First Asset to: Ruby
    test('Ruby', () async {
      await testReclassify(ClassificationSpecificEnum.rb);
    });

    ///----------------24<-------------Reclassify First Asset to: Rust
    test('Reclassify First Asset to ', () async {
      await testReclassify(ClassificationSpecificEnum.rs);
    });

    ///----------------25<-------------Reclassify First Asset to: Scala
    test('Rust', () async {
      await testReclassify(ClassificationSpecificEnum.scala);
    });

    ///----------------26<-------------Reclassify First Asset to: Shell
    test('Shell', () async {
      await testReclassify(ClassificationSpecificEnum.sh);
    });

    ///----------------27<-------------Reclassify First Asset to: SQL
    test('SQL', () async {
      await testReclassify(ClassificationSpecificEnum.sql);
    });

    ///----------------28<-------------Reclassify First Asset to: Swift
    test('Swift', () async {
      await testReclassify(ClassificationSpecificEnum.swift);
    });

    ///----------------29<-------------Reclassify First Asset to: Tex
    test('Tex', () async {
      await testReclassify(ClassificationSpecificEnum.tex);
    });

    ///----------------30<-------------Reclassify First Asset to: Text
    test('Text', () async {
      await testReclassify(ClassificationSpecificEnum.text);
    });
  });
}

//            (ClassificationSpecificEnum.bat);
//            (ClassificationSpecificEnum.c);
//            (ClassificationSpecificEnum.cs);
//            (ClassificationSpecificEnum.cpp);
//            (ClassificationSpecificEnum.cs);
//            (ClassificationSpecificEnum.css);
//            (ClassificationSpecificEnum.dart);
//            (ClassificationSpecificEnum.erl);
//            (ClassificationSpecificEnum.go);
//            (ClassificationSpecificEnum.hs);
//            (ClassificationSpecificEnum.html);
//            (ClassificationSpecificEnum.java);
//            (ClassificationSpecificEnum.js);
//            (ClassificationSpecificEnum.lua);
//            (ClassificationSpecificEnum.md);
//            (ClassificationSpecificEnum.matlab);
//            (ClassificationSpecificEnum.m);
//            (ClassificationSpecificEnum.p);
//            (ClassificationSpecificEnum.php);
//            (ClassificationSpecificEnum.ps);
//            (ClassificationSpecificEnum.py);
//            (ClassificationSpecificEnum.r);
//            (ClassificationSpecificEnum.rb);
//            (ClassificationSpecificEnum.rs);
//            (ClassificationSpecificEnum.scala);
//            (ClassificationSpecificEnum.sh);
//            (ClassificationSpecificEnum.sql);
//            (ClassificationSpecificEnum.swift);
//            (ClassificationSpecificEnum.tex);
//            (ClassificationSpecificEnum.text);
//            (ClassificationSpecificEnum.toml);
//            (ClassificationSpecificEnum.ts);
//            (ClassificationSpecificEnum.yaml);
