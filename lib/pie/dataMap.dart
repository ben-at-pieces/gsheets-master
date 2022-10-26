// ignore_for_file: omit_local_variable_types

import 'package:gsheets/pie/pieChart.dart';

import 'batch_file.dart';
import 'c_.dart';
import 'languages/c.dart';
import 'languages_list.dart';

List<double> batch = [];

Future<List<double>> batch_file() async {
  BatchFileSnips launch = BatchFileSnips(api: api);
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  batch.add(batchCount);
  // if (void ghj = diablo.add(batchCount));
  return batch;
}

List<double> c = [];
Future<List<double>> c_() async {
  C__Snips launch = C__Snips(api: api);

  /// batchfile count
  double bats = await launch.run();
  double batchCount = bats.toDouble();
  c.add(batchCount);
  return c;
}

List<double> dart = [];
Future<List<double>> dartCount() async {
  Dart__Snips launch = Dart__Snips(api: api);

  /// batchfile count
  double bats = await launch.c__();
  double batchCount = bats.toDouble();
  dart.add(batchCount);
  return dart;
}

int key = 0;
final dataMap = <String, double>{
  Languages.elementAt(0): batch.reversed.first,
  Languages.elementAt(1): c.reversed.first,
  Languages.elementAt(6): dart.reversed.first,
};
