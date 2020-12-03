import 'package:weather_app/data/api/model/day/api_day.dart';
import 'package:weather_app/domain/model/day/day.dart';
// import 'package:weather_app/data/storage/constants.dart';


class DayMapper {
  static Day fromApi(ApiDay day) {
    print('DayMapper: day.time: ${day.time}');
    return Day(
      time: DateTime.fromMillisecondsSinceEpoch(
        day.time.toInt()*1000),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        day.sunrise.toInt()*1000),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        day.sunset.toInt()*1000),
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
      windSpeed: day.windSpeed,
      windDegrees: day.windDegrees.toInt(),
      windGust: day.windGust,
      snow: day.snow != null
        ? day.snow*100
        : null,
      rain: day.rain != null
        ? day.rain*100
        : null,
    );
  }

  static Map<String, dynamic> toMap(Day day) => {
      'time': day.time.millisecondsSinceEpoch,
      'sunrise': day.sunrise.millisecondsSinceEpoch,
      'sunset': day.sunset.millisecondsSinceEpoch,
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
      'windSpeed': day.windSpeed,
      'windDegrees': day.windDegrees,
      'windGust': day.windGust,
      'snow': day.snow,
      'rain': day.rain,
    };

  static Day fromJson(Map<String, dynamic> jsonData) {
    return Day(
      time: DateTime.fromMillisecondsSinceEpoch(
        jsonData['time']),
      sunrise: DateTime.fromMillisecondsSinceEpoch(
        jsonData['sunrise']),
      sunset: DateTime.fromMillisecondsSinceEpoch(
        jsonData['sunset']),
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
