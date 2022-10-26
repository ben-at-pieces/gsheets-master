// ignore_for_file: omit_local_variable_types

import 'package:gsheets/pie/pieChart.dart';

import 'c_.dart';
import 'languages_list.dart';

List<double> c_ = [];

final dataMap = <String, double>{
  Languages.elementAt(0): c_.first,
};

Future<List<double>> c() async {
  C__Snips launch = C__Snips(api: api);

  /// batchfile count
  double bats = await launch.c__();
  double batchCount = bats.toDouble();
  c_.add(batchCount);
  return c_;
}
