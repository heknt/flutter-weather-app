import 'package:weather_app/domain/model/day/day.dart';
import 'package:weather_app/data/api/model/day/api_day.dart';


class ApiDaily {
  static List<ApiDay> fromApi(Map<String, dynamic> dailyMap) {
    final dayNum = dailyMap["daily"].length;
    List<ApiDay> apiDayList = [];

    for (int i = 0; i < dayNum; i++) {
      apiDayList.add(ApiDay.fromApi(dailyMap, i));
    }
    return apiDayList;
  }
}
