import 'package:weather_app/data/api/api_hour.dart';
import 'package:weather_app/domain/model/hour.dart';


class HourMapper {
  static Hour fromApi(Apihour hour) {
    return Hour(
      time: DateTime.fromMillisecondsSinceEpoch(
        hour.time.toInt()),
      weatherMain: hour.weatherMain,
      weatherDesc: hour.weatherDesc,
      weatherIconCode: hour.weatherIconCode,
      temperature: hour.temperature,
      tempFeelsLike: hour.tempFeelsLike,
      pressure: hour.pressure.toInt(),
      humidity: hour.humidity.toInt(),
      atmosphericTemp: hour.atmosphericTemp,
      clouds: hour.clouds.toInt(),
      visibility: hour.visibility.toInt(),
      windSpeed: hour.windSpeed,
      windDegrees: hour.windDegrees.toInt(),
      windGust: hour.windGust,
      snow: hour.snow,
      rain: hour.rain,
    );
  }  
}
