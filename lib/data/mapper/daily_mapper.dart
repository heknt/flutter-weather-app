import 'dart:convert';

import 'package:weather_app/domain/model/day.dart';
import 'day_mapper.dart';


class DailyMapper {
  static String encode(List<Day> daily) => jsonEncode(
        daily
            .map<Map<String, dynamic>>((day) => DayMapper.toMap(day))
            .toList(),
      );

  static List<Day> decode(String daily) =>
      (jsonDecode(daily) as List<dynamic>)
          .map<Day>((item) => DayMapper.fromJson(item))
          .toList();
}
