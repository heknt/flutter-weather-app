import 'package:meta/meta.dart';
import 'package:weather_app/domain/model/hour/hour.dart';


abstract class HourRepository {
  Future<Hour> getHour({
    @required double latitude,
    @required double longitude,
    @required String language,
  });
}
