import 'dart:convert';

import 'package:weather_app/domain/model/day.dart';
import 'day_mapper.dart';


class DailyMapper {
  static String encode(List<Day> daily) => json.encode(
        daily
            .map<Map<String, dynamic>>((day) => DayMapper.toMap(day))
            .toList(),
      );

  static List<Day> decode(String daily) =>
      (json.decode(daily) as List<dynamic>)
          .map<Day>((item) => DayMapper.fromJson(item))
          .toList();
}
