
import 'package:core_openapi/api/assets_api.dart';
import 'package:core_openapi/api_client.dart';
import 'package:gsheets/statistics.dart';

class StatisticsSingleton {
  static final StatisticsSingleton _singleton = StatisticsSingleton._internal();

  factory StatisticsSingleton() {
    return _singleton;
  }

  StatisticsSingleton._internal();

  Statistics? statistics;






}
