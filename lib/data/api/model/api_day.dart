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
    : time = map['daily'][index]['dt'],
      sunrise = map['daily'][index]['sunrise'],
      sunset = map['daily'][index]['sunset'],
      weatherMain = map['daily'][index]['weather']['main'],
      weatherDesc = map['daily'][index]['weather']['description'],
      weatherIconCode = map['daily'][index]['weather']['icon'],
      dayTemp = map['daily'][index]['temp']['day'],
      minTemp = map['daily'][index]['temp']['min'],
      maxTemp = map['daily'][index]['temp']['max'],
      nightTemp = map['daily'][index]['temp']['night'],
      eveTemp = map['daily'][index]['temp']['eve'],
      mornTemp = map['daily'][index]['temp']['morn'],
      dayTempFeelsLike = map['daily'][index]['feels_like']['day'],
      nightTempFeelsLike = map['daily'][index]['feels_like']['night'],
      eveTempFeelsLike = map['daily'][index]['feels_like']['eve'],
      mornTempFeelsLike = map['daily'][index]['feels_like']['morn'],
      pressure = map['daily'][index]['pressure'],
      humidity = map['daily'][index]['humidity'],
      atmosphericTemp = map['daily'][index]['dew_point'],
      clouds = map['daily'][index]['clouds'],
      visibility = map['daily'][index]['visibility'],
      windSpeed = map['daily'][index]['wind_speed'],
      windDegrees = map['daily'][index]['wind_deg'],
      windGust = map['daily'][index].containsKey('wind_gust')
        ? map['daily'][index]['wind_gust']
        : null,
      snow = map['daily'][index].containsKey('snow')
        ? map['daily'][index]['snow']
        : null,
      rain = map['daily'][index].containsKey('rain')
        ? map['daily'][index]['rain']
        : null;

  // _getValueByKey(Map<String, dynamic> map, int index, String key) {
  //   return map['daily'][index][key];
  // }
}
