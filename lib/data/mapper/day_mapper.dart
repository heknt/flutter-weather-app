import 'package:weather_app/data/api/api_day.dart';
import 'package:weather_app/domain/model/day.dart';


class DayMapper {
  static Day fromApi(ApiDay day) {
    return Day(
      time: DateTime.fromMillisecondsSinceEpoch(
        day.time.toInt()),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        day.sunrise.toInt()),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        day.sunset.toInt()),
      weatherMain: day.weatherMain,
      weatherDesc: day.weatherDesc,
      weatherIconCode: day.weatherIconCode,
      dayTemp: day.dayTemp,
      minTemp: day.minTemp,
      maxTemp: day.maxTemp,
      nightTemp: day.nightTemp,
      eveTemp: day.eveTemp,
      mornTemp: day.mornTemp,
      dayTempFeelsLike: day.dayTempFeelsLike,
      nightTempFeelsLike: day.nigthTempFeelsLike,
      eveTempFeelsLike: day.eveTempFeelsLike,
      mornTempFeelsLike: day.mornTempFeelsLike,
      pressure: day.pressure.toInt(),
      humidity: day.humidity.toInt(),
      atmosphericTemp: day.atmosphericTemp,
      clouds: day.clouds.toInt(),
      visibility: day.visibility.toInt(),
      windSpeed: day.windSpeed,
      windDegrees: day.windDegrees.toInt(),
      windGust: day.windGust,
      snow: day.snow,
      rain: day.rain,
    );
  }  
}
