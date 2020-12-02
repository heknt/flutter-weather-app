import 'dart:convert';

import 'package:weather_app/domain/model/hour.dart';
import 'hour_mapper.dart';


class HourlyMapper {
  static String encode(List<Hour> hourly) => json.encode(
        hourly
            .map<Map<String, dynamic>>((hour) => HourMapper.toMap(hour))
            .toList(),
      );

  static List<Hour> decode(String hourly) =>
      (json.decode(hourly) as List<dynamic>)
          .map<Hour>((item) => HourMapper.fromJson(item))
          .toList();
}
