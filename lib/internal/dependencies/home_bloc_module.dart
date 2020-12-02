import 'package:weather_app/domain/bloc/home_bloc.dart';
import 'package:weather_app/internal/dependencies/daily_repository_module.dart';
import 'package:weather_app/internal/dependencies/hour_repository_module.dart';


class HomeBlocModule {
  static HomeBloc homeBloc() {
    return HomeBloc(
      DailyRepositoryModule.dailyRepository(),
      HourRepositoryModule.hourRepository(),
    );
  }
}
