import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/api/helpers/day/api_daily.dart';
import 'package:weather_app/data/api/helpers/hour/api_hourly.dart';
import 'package:weather_app/data/api/model/day/api_day.dart';
import 'package:weather_app/data/api/model/hour/api_hour.dart';
import 'package:weather_app/data/api/request/get_request_body.dart';

// import 'settings/config.dart';


class OpenWeatherMapService {
  static const _apiBaseUrl = 
    'http://api.openweathermap.org';

  // static const validApiUrl = _getValidApiUrl;
  // String _getValidApiUrl() =>
  //   '$_apiBaseUrl/data/2.5/onecall?appid=$openWeatherMapAppId';
  
  static String getIconUrl(String iconCode) { 
    return 'http://openweathermap.org/img/wn/$iconCode@2x.png';
  }

  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _apiBaseUrl,
    ),
  );
  
  Future<List<ApiDay>> getDaily(GetRequestBody body) async {
    print('service: BEFORE daily _dio.get; body: $body; body.toDailyApi: ${body.toDailyApi()}');
    final response = await _dio.get(
      '/data/2.5/onecall',
      queryParameters: body.toDailyApi(),
    );
    print('service: AFTER daily _dio.get; response.data: ${response.data}');
    print('response.data["daily"][0]["dt"]: ${response.data["daily"][0]["dt"]}');
    
    return ApiDaily.fromApi(response.data);
  }

  Future<List<ApiHour>> getHourly(GetRequestBody body) async {
    print('service: BEFORE hourly _dio.get; body: $body');
    final response = await _dio.get(
      '/data/2.5/onecall',
      queryParameters: body.toHourlyApi(),
    );
    print('service: AFTER hourly _dio.get; response: $response');
    return ApiHourly.fromApi(response.data);
  }
}
