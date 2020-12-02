import 'package:weather_app/data/api/services/openweathermap_service.dart';


/// TODO: Add Localization
Map<String, String> dayFieldsTitle = {
  'time': 'Time',
  'sunrise': 'Sunrise',
  'sunset': 'Sunset',
  'weather_main': 'Main Info',
  'weather_desc': 'Description',
  /// not working. can not find _getIconUrl method in OpenWeatherMapService
  // 'weather_icon_code': ((String iconCode) =>
  //     OpenWeatherMapService._getIconUrl(iconCode)).toString(),
  'day_temp': 'Day Temperature',
  'min_temp': 'Temp. Minimum',
  'max_temp': 'Temp. Maximum',
  'night_temp': 'Night Temp.',
  'eve_time': 'Evening Temp.',
  'morn_time': 'Morning Temp.',
  'day_temp_feels_like': 'Day Temp. Feels Like',
  'night_temp_feels_like': 'Night Temp. Feels Like',
  'eve_temp_feels_like': 'Evening Temp. Feels Like',
  'morn_temp_feels_like': 'Morning Temp. Feels Like',
  'pressure': 'Pressure',
  'humidity': 'Humidity',
  'atmospheric_temp': 'Atmospheric Temp.',
  'clouds': 'Clouds',
  'wind_speed': 'Wind Speed',
  'wind_degrees': 'Wind Degrees',
  'wind_gust': 'Wind Gust',
  'snow': 'Snow',
  'rain': 'Rain',
};

Map<String, String> hourFieldsTitle = {
  'time': 'Time',
  'weather_main': 'Main Info',
  'weather_desc': 'Description',
  // 'weather_icon_code': ((String iconCode) =>
  //     OpenWeatherMapService._getIconUrl(iconCode)).toString(),
  'temperature': 'Temperature',
  'temp_feels_like': 'Temp. Feels Like',
  'pressure': 'Pressure',
  'humidity': 'Humidity',
  'atmospheric_temp': 'Atmospheric Temp.',
  'clouds': 'Clouds',
  'wind_speed': 'Wind Speed',
  'wind_degrees': 'Wind Degrees',
  'wind_gust': 'Wind Gust',
  'snow': 'Snow',
  'rain': 'Rain',
};


enum dayFields {
  time,
  sunrise,
  sunset,
  weatherMain,
  weatherDesc,
  weatherIconCode,
  dayTemp,
  minTemp,
  maxTemp,
  nightTemp,
  eveTemp,
  mornTemp,
  dayTempFeelsLike,
  nightTempFeelsLike,
  eveTempFeelsLike,
  mornTempFeelsLike,
  pressure,
  humidity,
  atmosphericTemp,
  clouds,
  windSpeed,
  windDegrees,
  windGust,
  snow,
  rain,
}

enum hourFields {
  time,
  weatherMain,
  weatherDesc,
  weatherIconCode,
  temperature,
  tempFeelsLike,
  pressure,
  humidity,
  atmosphericTemp,
  clouds,
  windSpeed,
  windDegrees,
  windGust,
  snow,
  rain,
}