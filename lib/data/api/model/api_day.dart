class ApiDay {
  final num time;
  final num sunrise;
  final num sunset;
  final String weatherMain; // [Rain, Snow, Extreme etc.]
  final String weatherDesc; // description
  final String weatherIconCode; // ex: 03d
  final num dayTemp; // [Celsius]
  final num minTemp;
  final num maxTemp;
  final num nightTemp;
  final num eveTemp;
  final num mornTemp;
  final num dayTempFeelsLike; // [Celsius]
  final num nightTempFeelsLike;
  final num eveTempFeelsLike;
  final num mornTempFeelsLike;
  final num pressure; // hPa
  final num humidity; // %
  final num atmosphericTemp; // dew_point, [Celsius]
  final num clouds; // Cloudiness, %
  final num visibility; // Average visibility, metres
  final num windSpeed; // [metre/sec]
  final num windDegrees;
  final num windGust;
  final num snow;
  final num rain;

  ApiDay.fromApi(Map<String, dynamic> map, int index)
    : time = _getValueByKey(map, index, 'dt'),
      sunrise = _getValueByKey(map, index, 'sunrise'),
      sunset = _getValueByKey(map, index, 'sunset'),
      weatherMain = _getValueByKey(map, index, 'weather')['main'],
      weatherDesc = _getValueByKey(map, index, 'weather')['description'],
      weatherIconCode = _getValueByKey(map, index, 'weather')['icon'],
      dayTemp = _getValueByKey(map, index, 'temp')['day'],
      minTemp = _getValueByKey(map, index, 'temp')['min'],
      maxTemp = _getValueByKey(map, index, 'temp')['max'],
      nightTemp = _getValueByKey(map, index, 'temp')['night'],
      eveTemp = _getValueByKey(map, index, 'temp')['eve'],
      mornTemp = _getValueByKey(map, index, 'temp')['morn'],
      dayTempFeelsLike = _getValueByKey(map, index, 'feels_like')['day'],
      nightTempFeelsLike = _getValueByKey(map, index, 'feels_like')['night'],
      eveTempFeelsLike = _getValueByKey(map, index, 'feels_like')['eve'],
      mornTempFeelsLike = _getValueByKey(map, index, 'feels_like')['morn'],
      pressure = _getValueByKey(map, index, 'pressure'),
      humidity = _getValueByKey(map, index, 'humidity'),
      atmosphericTemp = _getValueByKey(map, index, 'dew_point'),
      clouds = _getValueByKey(map, index, 'clouds'),
      visibility = _getValueByKey(map, index, 'visibility'),
      windSpeed = _getValueByKey(map, index, 'wind_speed'),
      windDegrees = _getValueByKey(map, index, 'wind_deg'),
      windGust = map['daily'][index].containsKey('wind_gust')
        ? _getValueByKey(map, index, 'wind_gust')
        : null,
      snow = map['daily'][index].containsKey('snow')
        ? _getValueByKey(map, index, 'snow')
        : null,
      rain = map['daily'][index].containsKey('rain')
        ? _getValueByKey(map, index, 'rain')
        : null;

  _getValueByKey(Map<String, dynamic> map, int index, String key) {
    return map['daily'][index][key];
  }
}
