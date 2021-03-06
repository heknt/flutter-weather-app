import 'package:meta/meta.dart';
import 'package:weather_app/data/api/services/settings/config.dart';


class GetRequestBody {
  final double latitude;
  final double longitude;
  final String language;

  GetRequestBody({
    @required this.latitude,
    @required this.longitude,
    @required this.language,
  });

  Map<String, dynamic> toDailyApi() {
    return {
      'appid': openWeatherMapAppId,
      'units': 'metric',
      'exclude': 'minutely,hourly',
      'lat': latitude,
      'lon': longitude,
      'lang': language,
    };
  }

  Map<String, dynamic> toHourlyApi() {
    return {
      'appid': openWeatherMapAppId,
      'units': 'metric',
      'exclude': 'minutely,daily',
      'lat': latitude,
      'lon': longitude,
      'lang': language,
    };
  }
}
