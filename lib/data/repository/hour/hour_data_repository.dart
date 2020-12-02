import 'package:weather_app/data/api/api_util.dart';
import 'package:weather_app/domain/model/hour/hour.dart';
import 'package:weather_app/domain/repository/hour/hour_repository.dart';


class HourDataRepository extends HourRepository {
  final ApiUtil _apiUtil;

  HourDataRepository(this._apiUtil);

  @override
  Future<Hour> getHour({
    double latitude,
    double longitude,
    String language
  }) {
    return _apiUtil.getHour(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
  }
}
