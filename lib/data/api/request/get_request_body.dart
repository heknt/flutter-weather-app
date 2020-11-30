import 'package:meta/meta.dart';


class GetRequestBody {
  final double latitude;
  final double longitude;
  final String language;

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
