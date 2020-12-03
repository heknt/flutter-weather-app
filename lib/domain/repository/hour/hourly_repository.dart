import 'package:meta/meta.dart';
import 'package:weather_app/domain/model/hour/hour.dart';


abstract class HourlyRepository {
  Future<List<Hour>> getHourly({
    @required double latitude,
    @required double longitude,
    @required String language,
  });
}
