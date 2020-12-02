import 'package:weather_app/data/api/model/api_day.dart';
import 'package:weather_app/domain/model/day.dart';
// import 'package:weather_app/data/storage/constants.dart';


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
      nightTempFeelsLike: day.nightTempFeelsLike,
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

  static Map<String, dynamic> toMap(Day day) => {
      'time': day.time,
      'sunrise': day.sunrise,
      'sunset': day.sunset,
      'weatherMain': day.weatherMain,
      'weatherDesc': day.weatherDesc,
      'weatherIconCode': day.weatherIconCode,
      'dayTemp': day.dayTemp,
      'minTemp': day.minTemp,
      'maxTemp': day.maxTemp,
      'nightTemp': day.nightTemp,
      'eveTemp': day.eveTemp,
      'mornTemp': day.mornTemp,
      'dayTempFeelsLike': day.dayTempFeelsLike,
      'nightTempFeelsLike': day.nightTempFeelsLike,
      'eveTempFeelsLike': day.eveTempFeelsLike,
      'mornTempFeelsLike': day.mornTempFeelsLike,
      'pressure': day.pressure,
      'humidity': day.humidity,
      'atmosphericTemp': day.atmosphericTemp,
      'clouds': day.clouds,
      'visibility': day.visibility,
      'windSpeed': day.windSpeed,
      'windDegrees': day.windDegrees,
      'windGust': day.windGust,
      'snow': day.snow,
      'rain': day.rain,
    };

  static Day fromJson(Map<String, dynamic> jsonData) {
    return Day(
      time: jsonData['time'],
      sunrise: jsonData['sunrise'],
      sunset: jsonData['sunset'],
      weatherMain: jsonData['weatherMain'],
      weatherDesc: jsonData['weatherDesc'],
      weatherIconCode: jsonData['weatherIconCode'],
      dayTemp: jsonData['dayTemp'],
      minTemp: jsonData['minTemp'],
      maxTemp: jsonData['maxTemp'],
      nightTemp: jsonData['nightTemp'],
      eveTemp: jsonData['eveTemp'],
      mornTemp: jsonData['mornTemp'],
      dayTempFeelsLike: jsonData['dayTempFeelsLike'],
      nightTempFeelsLike: jsonData['nightTempFeelsLike'],
      eveTempFeelsLike: jsonData['eveTempFeelsLike'],
      mornTempFeelsLike: jsonData['mornTempFeelsLike'],
      pressure: jsonData['pressure'],
      humidity: jsonData['humidity'],
      atmosphericTemp: jsonData['atmosphericTemp'],
      clouds: jsonData['clouds'],
      visibility: jsonData['visibility'],
      windSpeed: jsonData['windSpeed'],
      windDegrees: jsonData['windDegrees'],
      windGust: jsonData['windGust'],
      snow: jsonData['snow'],
      rain: jsonData['rain'],
    );
  }

  // Map<String, dynamic> toMap(Day day) => new Map.fromIterable(
  //     dayFields,
  //     key: (item) => item.toString(),
  //     value: (item) => day.item
  //   );
}
