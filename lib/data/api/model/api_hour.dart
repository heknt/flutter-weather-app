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
    : time = map['hourly'][index]['dt'],
      sunrise = map['hourly'][index]['sunrise'],
      sunset = map['hourly'][index]['sunset'],
      weatherMain = map['hourly'][index]['weather']['main'],
      weatherDesc = map['hourly'][index]['weather']['description'],
      weatherIconCode = map['hourly'][index]['weather']['icon'],
      temperature = map['hourly'][index]['temp'],
      tempFeelsLike = map['hourly'][index]['feels_like'],
      pressure = map['hourly'][index]['pressure'],
      humidity = map['hourly'][index]['humidity'],
      atmosphericTemp = map['hourly'][index]['dew_point'],
      clouds = map['hourly'][index]['clouds'],
      visibility = map['hourly'][index]['visibility'],
      windSpeed = map['hourly'][index]['wind_speed'],
      windDegrees = map['hourly'][index]['wind_deg'],
      windGust = map['hourly'][index].containsKey('wind_gust')
        ? map['hourly'][index]['wind_gust']
        : null,
      snow = map['hourly'][index].containsKey('snow')
        ? map['hourly'][index]['snow']
        : null,
      rain = map['hourly'][index].containsKey('rain')
        ? map['hourly'][index]['rain']
        : null;

  // _getValueByKey(Map<String, dynamic> map, int index, String key) {
  //   return map['hourly'][index][key];
  // }
}
