import 'package:weather_app/domain/model/hour/hour.dart';
import 'package:weather_app/data/api/model/hour/api_hour.dart';


class ApiHourly {
  static List<ApiHour> fromApi(Map<String, dynamic> hourlyMap) {
    final hourNum = hourlyMap["hourly"].length;
    List<ApiHour> apiHourList = [];

    for (int i = 0; i < hourNum; i++) {
      apiHourList.add(ApiHour.fromApi(hourlyMap, i));
    }
    return apiHourList;
  }
}
