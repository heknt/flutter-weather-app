import 'package:weather_app/data/repository/hour_data_repository.dart';
import 'package:weather_app/domain/repository/hour_repository.dart';

import 'api_module.dart';


class HourRepositoryModule {
  static HourRepository _hourRepository;

  static HourRepository hourRepository() {
    if (_hourRepository == null) {
      _hourRepository = HourDataRepository(
        ApiModule.apiUtil()
      );
    }
    return _hourRepository;
  }
}
