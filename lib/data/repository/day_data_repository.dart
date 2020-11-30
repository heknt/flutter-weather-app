import 'package:weather_app/data/api/api_util.dart';
import 'package:weather_app/domain/model/day.dart';
import 'package:weather_app/domain/repository/day_repository.dart';


class DayDataRepository extends DayRepository {
  final ApiUtil _apiUtil;

  DayDataRepository(this._apiUtil);

  @override
  Future<Day> getDay({
    double latitude,
    double longitude,
    String language
  }) {
    return _apiUtil.getDay(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
  }
}
