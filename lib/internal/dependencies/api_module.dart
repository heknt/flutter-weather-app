import 'package:weather_app/data/api_util.dart';
import 'package:weather_app/data/service/openweathermap_service.dart';


class ApiModule {
  static ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(OpenWeatherMapService());
    }
    return _apiUtil;
  }
}
