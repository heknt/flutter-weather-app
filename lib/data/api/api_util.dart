import 'package:meta/meta.dart';
import 'package:weather_app/data/api/request/get_request_body.dart';
import 'package:weather_app/data/mapper/day_mapper.dart';
import 'package:weather_app/data/mapper/hour_mapper.dart';
import 'package:weather_app/data/api/services/openweathermap_service.dart';
import 'package:weather_app/domain/model/day.dart';
import 'package:weather_app/domain/model/hour.dart';


class ApiUtil {
  final OpenWeatherMapService _openWeatherMapService;

  ApiUtil(this._openWeatherMapService);

  Future<Day> getDay({
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
    print('ApiUtil IN getDay: body: $body; body.toDayApi(): ${body.toDayApi()}');
    final result = await _openWeatherMapService.getDay(body);
    print('ApiUtil OUT getDay: result: $result, result.pressure ${result.pressure}');
    return DayMapper.fromApi(result);
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
