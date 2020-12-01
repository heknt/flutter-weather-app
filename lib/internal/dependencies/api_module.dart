import 'package:weather_app/data/api/api_util.dart';
import 'package:weather_app/data/api/services/openweathermap_service.dart';


class ApiModule {
  static ApiUtil _apiUtil;

  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(OpenWeatherMapService());
    }
    return _apiUtil;
  }
}
