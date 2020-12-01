import 'package:meta/meta.dart';


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
      'units': 'metric',
      'exclude': 'minutelly,hourly',
      'lat': latitude,
      'lon': longitude,
      'lang': language,
    };
  }

  Map<String, dynamic> toHourApi() {
    return {
      'units': 'metric',
      'exclude': 'minutelly,daily',
      'lat': latitude,
      'lon': longitude,
      'lang': language,
    };
  }
}
