import 'package:meta/meta.dart';
import 'package:weather_app/data/api/services/settings/config.dart';


class GetRequestBody {
  double latitude;
  double longitude;
  String language;

  GetRequestBody({
    @required double latitude,
    @required double longitude,
    @required String language,
  });

  Map<String, dynamic> toDayApi() {
    return {
      'appid': openWeatherMapAppId,
      'units': 'metric',
      'exclude': 'minutelly,hourly',
      'lat': latitude,
      'lon': longitude,
      'lang': language,
    };
  }

  Map<String, dynamic> toHourApi() {
    return {
      'appid': openWeatherMapAppId,
      'units': 'metric',
      'exclude': 'minutelly,daily',
      'lat': latitude,
      'lon': longitude,
      'lang': language,
    };
  }
}
