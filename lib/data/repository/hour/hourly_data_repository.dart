import 'package:weather_app/data/api/api_util.dart';
import 'package:weather_app/domain/model/hour/hour.dart';
import 'package:weather_app/domain/repository/hour/hourly_repository.dart';


class HourlyDataRepository extends HourlyRepository {
  final ApiUtil _apiUtil;

  HourlyDataRepository(this._apiUtil);

  @override
  Future<List<Hour>> getHourly({
    double latitude,
    double longitude,
    String language
  }) async {
    return _apiUtil.getHourly(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
  }
}
