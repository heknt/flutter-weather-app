import 'package:weather_app/data/api/model/api_hour.dart';
import 'package:weather_app/domain/model/hour.dart';
// import 'package:weather_app/data/storage/constants.dart';


class HourMapper {
  static Hour fromApi(ApiHour hour) {
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

  static Map<String, dynamic> toMap(Hour hour) => {
      'time': hour.time,
      'weatherMain': hour.weatherMain,
      'weatherDesc': hour.weatherDesc,
      'weatherIconCode': hour.weatherIconCode,
      'temperature': hour.temperature,
      'tempFeelsLike': hour.tempFeelsLike,
      'pressure': hour.pressure,
      'humidity': hour.humidity,
      'atmosphericTemp': hour.atmosphericTemp,
      'clouds': hour.clouds,
      'visibility': hour.visibility,
      'windSpeed': hour.windSpeed,
      'windDegrees': hour.windDegrees,
      'windGust': hour.windGust,
      'snow': hour.snow,
      'rain': hour.rain,
    };

  static Hour fromJson(Map<String, dynamic> jsonData) {
    return Hour(
      time: jsonData['time'],
      weatherMain: jsonData['weatherMain'],
      weatherDesc: jsonData['weatherDesc'],
      weatherIconCode: jsonData['weatherIconCode'],
      temperature: jsonData['temperature'],
      tempFeelsLike: jsonData['tempFeelsLike'],
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

  // Map<String, dynamic> toMap(Hour hour) => new Map.fromIterable(
  //     hourFields,
  //     key: (item) => item.toString(),
  //     value: (item) => hour.item
  //   );
}
