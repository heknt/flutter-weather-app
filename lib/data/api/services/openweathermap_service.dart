import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/data/api/model/api_day.dart';
import 'package:weather_app/data/api/model/api_hour.dart';
import 'package:weather_app/data/api/request/get_request_body.dart';

// import 'settings/config.dart';


class OpenWeatherMapService {
  static const _apiBaseUrl = 
    'http://api.openweathermap.org';

  // static const validApiUrl = _getValidApiUrl;
  // String _getValidApiUrl() =>
  //   '$_apiBaseUrl/data/2.5/onecall?appid=$openWeatherMapAppId';
  
  String _getIconUrl(String iconCode) => 
    '$_apiBaseUrl/img/wn/$iconCode@2x.png';
 
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: _apiBaseUrl,
      // headers: {
      //   'insecure': '',
      //   'compressed': '',
      // }
    ),
  );
  
  Future<ApiDay> getDay(GetRequestBody body) async {
    print('service: BEFORE daily _dio.get; body: $body');
    final response = await _dio.get(
      '/data/2.5/onecall?units=metric&lat=50&lon=30&exclude=minutelly,hourly&appid=3dce7b1b82ac2a9b2ff0f16f28589d65&lang=en',
    );
    print('service: AFTER daily _dio.get; response.data: ${response.data}');
    print('response.data["daily"][0]["dt"]: ${response.data["daily"][0]["dt"]}');
    return ApiDay.fromApi(response.data, 0);
  }

  Future<ApiHour> getHour(GetRequestBody body) async {
    print('service: BEFORE hourly _dio.get; body: $body');
    final response = await _dio.get(
      '/data/2.5/onecall',
      queryParameters: body.toHourApi(),
    );
    print('service: AFTER hourly _dio.get; response: $response');
    return ApiHour.fromApi(response.data, 0);
  }
}
