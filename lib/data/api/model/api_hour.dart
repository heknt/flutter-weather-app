class ApiHour {
  final num time;
  final num sunrise;
  final num sunset;
  final String weatherMain; // [Rain, Snow, Extreme etc.]
  final String weatherDesc; // description
  final String weatherIconCode; // ex: 03d
  final num temperature; // [Celsius]
  final num tempFeelsLike; // [Celsius]
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

  ApiHour.fromApi(Map<String, dynamic> map, int index)
    : time = _getValueByKey(map, index, 'dt'),
      sunrise = _getValueByKey(map, index, 'sunrise'),
      sunset = _getValueByKey(map, index, 'sunset'),
      weatherMain = _getValueByKey(map, index, 'weather')['main'],
      weatherDesc = _getValueByKey(map, index, 'weather')['description'],
      weatherIconCode = _getValueByKey(map, index, 'weather')['icon'],
      temperature = _getValueByKey(map, index, 'temp'),
      tempFeelsLike = _getValueByKey(map, index, 'feels_like'),
      pressure = _getValueByKey(map, index, 'pressure'),
      humidity = _getValueByKey(map, index, 'humidity'),
      atmosphericTemp = _getValueByKey(map, index, 'dew_point'),
      clouds = _getValueByKey(map, index, 'clouds'),
      visibility = _getValueByKey(map, index, 'visibility'),
      windSpeed = _getValueByKey(map, index, 'wind_speed'),
      windDegrees = _getValueByKey(map, index, 'wind_deg'),
      windGust = map['hourly'][index].containsKey('wind_gust')
        ? _getValueByKey(map, index, 'wind_gust')
        : null,
      snow = map['hourly'][index].containsKey('snow')
        ? _getValueByKey(map, index, 'snow')
        : null,
      rain = map['hourly'][index].containsKey('rain')
        ? _getValueByKey(map, index, 'rain')
        : null;

  _getValueByKey(Map<String, dynamic> map, int index, String key) {
    return map['hourly'][index][key];
  }
}
