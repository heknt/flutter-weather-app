import 'package:weather_app/data/repository/day_data_repository.dart';
import 'package:weather_app/domain/repository/day_repository.dart';

import 'api_module.dart';


class DayRepositoryModule {
  static DayRepository _dayRepository;

  static DayRepository dayRepository() {
    if (_dayRepository == null) {
      _dayRepository = DayDataRepository(
        ApiModule.apiUtil()
      );
    }
    return _dayRepository;
  }
}
