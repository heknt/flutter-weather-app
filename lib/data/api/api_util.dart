import 'package:meta/meta.dart';
import 'package:weather_app/data/api/request/get_request_body.dart';
import 'package:weather_app/data/mapper/day/daily_mapper.dart';
import 'package:weather_app/data/mapper/hour/hour_mapper.dart';
import 'package:weather_app/data/api/services/openweathermap_service.dart';
import 'package:weather_app/domain/model/day/day.dart';
import 'package:weather_app/domain/model/hour/hour.dart';


class ApiUtil {
  final OpenWeatherMapService _openWeatherMapService;

  ApiUtil(this._openWeatherMapService);

  Future<List<Day>> getDaily({
    @required double latitude,
    @required double longitude,
    @required String language,
  }) async {
    print('ApiUtil IN getDay: latitude: $latitude, longitude: $longitude, language: $language');
    final body = GetRequestBody(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
    print('ApiUtil IN getDay: body: $body; body.toDailyApi(): ${body.toDailyApi()}');
    final dayList = await _openWeatherMapService.getDaily(body);
    print('ApiUtil OUT getDay: dayList: $dayList, dayList[0].pressure ${dayList[0].pressure}');
    return DailyMapper.fromApi(dayList);
  }

  Future<Hour> getHour({
    @required double latitude,
    @required double longitude,
    @required String language,
  }) async {
    final body = GetRequestBody(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
    final result = await _openWeatherMapService.getHour(body);
    return HourMapper.fromApi(result);
  }
}
