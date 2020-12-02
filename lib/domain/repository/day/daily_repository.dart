import 'package:meta/meta.dart';
import 'package:weather_app/domain/model/day/day.dart';


abstract class DailyRepository {
  Future<List<Day>> getDaily({
    @required double latitude,
    @required double longitude,
    @required String language,
  });
}
