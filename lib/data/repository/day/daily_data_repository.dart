import 'dart:async';

import 'package:weather_app/data/api/api_util.dart';
import 'package:weather_app/domain/model/day/day.dart';
import 'package:weather_app/domain/repository/day/daily_repository.dart';


class DailyDataRepository extends DailyRepository {
  final ApiUtil _apiUtil;

  DailyDataRepository(this._apiUtil);

  @override
  Future<List<Day>> getDaily({
    double latitude,
    double longitude,
    String language
  }) async {
    return _apiUtil.getDaily(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
  }
}
