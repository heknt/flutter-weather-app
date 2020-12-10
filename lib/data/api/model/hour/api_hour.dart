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
  final num windSpeed; // [metre/sec]
  final num windDegrees;
  final num snow;
  final num rain;

  ApiHour.fromApi(Map<String, dynamic> map, int _index)
    : time = map['hourly'][_index]['dt'],
      sunrise = map['hourly'][_index]['sunrise'],
      sunset = map['hourly'][_index]['sunset'],
      weatherMain = map['hourly'][_index]['weather'][0]['main'],
      weatherDesc = map['hourly'][_index]['weather'][0]['description'],
      weatherIconCode = map['hourly'][_index]['weather'][0]['icon'],
      temperature = map['hourly'][_index]['temp'],
      tempFeelsLike = map['hourly'][_index]['feels_like'],
      pressure = map['hourly'][_index]['pressure'],
      humidity = map['hourly'][_index]['humidity'],
      atmosphericTemp = map['hourly'][_index]['dew_point'],
      clouds = map['hourly'][_index]['clouds'],
      windSpeed = map['hourly'][_index]['wind_speed'],
      windDegrees = map['hourly'][_index]['wind_deg'],
      snow = map['hourly'][_index].containsKey('snow')
        ? map['hourly'][_index]['snow']['1h']
        : null,
      rain = map['hourly'][_index].containsKey('rain')
        ? map['hourly'][_index]['rain']['1h']
        : null;

  // _getValueByKey(Map<String, dynamic> map, int _index, String key) {
  //   return map['hourly'][_index][key];
  // }
}
