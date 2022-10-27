// ignore_for_file: omit_local_variable_types

import 'package:gsheets/pie/pieChart.dart';

import 'languages/batch_file.dart';
import 'languages/c.dart';
import 'languages/cSharp.dart';
import 'languages/coffeescript.dart';
import 'languages/cpp.dart';
import 'languages/css.dart';
import 'languages/dart.dart';
import 'languages/erlang.dart';
import 'languages/go.dart';
import 'languages/haskell.dart';
import 'languages/html.dart';
import 'languages/image.dart';
import 'languages/java.dart';
import 'languages/json.dart';
import 'languages_list.dart';

/// ================ batchFile

List<double> batchFile = [];
Future<List<double>> batch_file_() async {
  BatchFileSnips launch = BatchFileSnips(api: api);
  double batch_file = await launch.run();
  double batchCount = batch_file;
  batchFile.add(batchCount);
  return batchFile;
}

/// ================ c

List<double> c = [];
Future<List<double>> c_() async {
  C__Snips launch = C__Snips(api: api);
  double cDpuble = await launch.run();
  double c_Count = cDpuble.toDouble();
  c.add(c_Count);
  return c;
}
// /// ================ c#
//

List<double> cSharp = [];
Future<List<double>> cSharp_() async {
  CSharp__Snips launch = CSharp__Snips(api: api);
  double cPPdub = await launch.run();
  double cPPCount = cPPdub.toDouble();
  cSharp.add(cPPCount);
  return cSharp;
}

/// ================ coffescript

List<double> coffee = [];
Future<List<double>> coffee_() async {
  Coffee__Snips launch = Coffee__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  coffee.add(batchCount);
  return coffee;
}

//
// /// ================ c++
//
List<double> cPP = [];
Future<List<double>> cPP_() async {
  CPlusPlus__Snips launch = CPlusPlus__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  cPP.add(batchCount);
  return cPP;
}
//

//
// /// ================ css

List<double> cSS = [];
Future<List<double>> cSS_() async {
  CSS__Snips launch = CSS__Snips(api: api);

  /// batchfile count
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  cSS.add(batchCount);
  return cSS;
}

// /// ================ dart

List<double> dart = [];
Future<List<double>> dartCount() async {
  Dart__Snippets launch = Dart__Snippets(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  dart.add(batchCount);
  return dart;
}

// /// ================ ERLANG

List<double> erlang = [];
Future<List<double>> erlang_() async {
  Erlang__Snips launch = Erlang__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  erlang.add(batchCount);
  return erlang;
}

/// ================ GO

List<double> go = [];
Future<List<double>> go_() async {
  Go__Snips launch = Go__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  go.add(batchCount);
  return go;
}

/// ================ HASKELL

List<double> haskell = [];
Future<List<double>> haskell_() async {
  haskell__Snips launch = haskell__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  haskell.add(batchCount);
  return haskell;
}

/// ================ HTML

List<double> html = [];
Future<List<double>> html_() async {
  html__Snips launch = html__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  html.add(batchCount);
  return html;
}

/// ================ IMAGE

List<double> image = [];
Future<List<double>> image_() async {
  image__Snips launch = image__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  image.add(batchCount);
  return image;
}

/// ================ JAVA

List<double> java = [];
Future<List<double>> java_() async {
  java__Snips launch = java__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  java.add(batchCount);
  return java;
}

/// ================ JSON

List<double> j_son = [];
Future<List<double>> json_() async {
  json__Snips launch = json__Snips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  j_son.add(batchCount);
  return j_son;
}

int key = 0;
final dataMap = <String, double>{
  // Languages.elementAt(0): batchFile.reversed.first,
  // Languages.elementAt(1): c.reversed.first,
  // Languages.elementAt(2): cPP.reversed.first,

  Languages.elementAt(0): batchFile.reversed.first,
  Languages.elementAt(1): c.reversed.first,
  Languages.elementAt(2): cPP.reversed.first,
  Languages.elementAt(3): coffee.reversed.first,
  Languages.elementAt(4): cSharp.reversed.first,
  Languages.elementAt(5): cSS.reversed.first,
  Languages.elementAt(6): dart.reversed.first,
  Languages.elementAt(7): erlang.reversed.first,
  Languages.elementAt(8): go.reversed.first,
  Languages.elementAt(9): haskell.reversed.first,
  Languages.elementAt(10): html.reversed.first,
  Languages.elementAt(11): image.reversed.first,
  Languages.elementAt(12): java.reversed.first,
  Languages.elementAt(13): j_son.reversed.first,
  // Languages.elementAt( 14 ): javascript_.reversed.first,
  // Languages.elementAt( 15 ): lua_.reversed.first,
  // Languages.elementAt( 16 ): markdown_.reversed.first,
  // Languages.elementAt( 17 ): matlab_.reversed.first,
  // Languages.elementAt( 18 ): objective_c_.reversed.first,
  // Languages.elementAt( 19 ): perl_.reversed.first,
  // Languages.elementAt( 20 ): php_.reversed.first,
  // Languages.elementAt( 21 ): powerShell_.reversed.first,
  // Languages.elementAt( 22 ): python_.reversed.first,
  // Languages.elementAt( 23 ): r_.reversed.first,
  // Languages.elementAt( 24 ): ruby_.reversed.first,
  // Languages.elementAt( 25 ): rust_.reversed.first,
  // Languages.elementAt( 26 ): scalla_.reversed.first,
  // Languages.elementAt( 27 ): shell_.reversed.first,
  // Languages.elementAt( 28 ): sql_.reversed.first,
  // Languages.elementAt( 29 ): swift_.reversed.first,
  // Languages.elementAt( 30 ): tex_.reversed.first,
  // Languages.elementAt( 31 ): textRead_.reversed.first,
  // Languages.elementAt( 32 ): toml_.reversed.first,
  // Languages.elementAt( 33 ): typeScript_.reversed.first,
  // Languages.elementAt( 34 ): yaml_.reversed.first,

  // Languages.elementAt(3): coffee.reversed.first,
  // Languages.elementAt(4): cSharp.reversed.first,
  // Languages.elementAt(5): cSS.reversed.first,
  // Languages.elementAt(6): dart.reversed.first,
  // Languages.elementAt(7): erlang.reversed.first,
  // Languages.elementAt(8): go_.reversed.first,
  // Languages.elementAt(9): haskell_.reversed.first,
  // Languages.elementAt(10): html_.reversed.first,
  // Languages.elementAt(11): image_.reversed.first,
  // Languages.elementAt(12): java_.reversed.first,
  // Languages.elementAt(13): jason_.reversed.first,
  // Languages.elementAt(14): javascript_.reversed.first,
  // Languages.elementAt(15): lua_.reversed.first,
  // Languages.elementAt(16): markdown_.reversed.first,
  // Languages.elementAt(17): matlab_.reversed.first,
  // Languages.elementAt(18): objective_c_.reversed.first,
  // Languages.elementAt(19): perl_.reversed.first,
  // Languages.elementAt(20): php_.reversed.first,
  // Languages.elementAt(21): powerShell_.reversed.first,
  // Languages.elementAt(22): python_.reversed.first,
  // Languages.elementAt(23): r_.reversed.first,
  // Languages.elementAt(24): ruby_.reversed.first,
  // Languages.elementAt(25): rust_.reversed.first,
  // Languages.elementAt(26): scalla_.reversed.first,
  // Languages.elementAt(27): shell_.reversed.first,
  // Languages.elementAt(28): sql_.reversed.first,
  // Languages.elementAt(29): swift_.reversed.first,
  // Languages.elementAt(30): tex_.reversed.first,
  // Languages.elementAt(31): textRead_.reversed.first,
  // Languages.elementAt(32): toml_.reversed.first,
  // Languages.elementAt(33): typeScript_.reversed.first,
  // Languages.elementAt(34): yaml_.reversed.first,
};
