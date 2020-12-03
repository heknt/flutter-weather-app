import 'package:weather_app/data/repository/hour/hourly_data_repository.dart';
import 'package:weather_app/domain/repository/hour/hourly_repository.dart';

import 'api_module.dart';


class HourlyRepositoryModule {
  static HourlyRepository _hourlyRepository;

  static HourlyRepository hourlyRepository() {
    if (_hourlyRepository == null) {
      _hourlyRepository = HourlyDataRepository(
        ApiModule.apiUtil()
      );
    }
    return _hourlyRepository;
  }
}
