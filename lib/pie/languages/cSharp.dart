// ignore_for_file: omit_local_variable_types

import 'package:gsheets/pie/pieChart.dart';

import '../c_.dart';

List<double> dart = [];
Future<List<double>> dartCount() async {
  Dart__Snips launch = Dart__Snips(api: api);

  /// batchfile count
  double bats = await launch.c__();
  double batchCount = bats.toDouble();
  dart.add(batchCount);
  return dart;
}
