import 'package:weather_app/data/repository/day/daily_data_repository.dart';
import 'package:weather_app/domain/repository/day/daily_repository.dart';

import 'api_module.dart';


class DailyRepositoryModule {
  static DailyRepository _dailyRepository;

  static DailyRepository dailyRepository() {
    if (_dailyRepository == null) {
      _dailyRepository = DailyDataRepository(
        ApiModule.apiUtil()
      );
    }
    return _dailyRepository;
  }
}
