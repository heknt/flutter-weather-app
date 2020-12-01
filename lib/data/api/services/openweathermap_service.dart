import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/api/model/api_day.dart';
import 'package:weather_app/data/api/model/api_hour.dart';
import 'package:weather_app/data/api/request/get_request_body.dart';

import 'settings/config.dart';


class OpenWeatherMapService {
  static const _apiBaseUrl = 
    'http://api.openweathermap.org';

  // static const validApiUrl = _getValidApiUrl;
  // String _getValidApiUrl() =>
  //   '$_apiBaseUrl/data/2.5/onecall?&appid=$openWeatherMapAppId';
  
  String _getIconUrl(iconCode) => 
    'http://openweathermap.org/img/wn/$iconCode@2x.png';
 
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: '$_apiBaseUrl/data/2.5/onecall?&appid=$openWeatherMapAppId',
    ),
  );

  Future<ApiDay> getDay(GetRequestBody body) async {
    final response = await _dio.get(
      '/json',
      queryParameters: body.toDayApi(),
    );
    return ApiDay.fromApi(response.data, 0);
  }

  Future<ApiHour> getHour(GetRequestBody body) async {
    final response = await _dio.get(
      '/json',
      queryParameters: body.toHourApi(),
    );
    return ApiHour.fromApi(response.data, 0);
  }
}
