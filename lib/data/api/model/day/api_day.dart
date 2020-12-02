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
  final num windSpeed; // [metre/sec]
  final num windDegrees;
  final num windGust;
  final num snow;
  final num rain;

  ApiDay.fromApi(Map<String, dynamic> map, int _index)
    : time = map['daily'][_index]['dt'],
      sunrise = map['daily'][_index]['sunrise'],
      sunset = map['daily'][_index]['sunset'],
      weatherMain = map['daily'][_index]['weather'][0]['main'],
      weatherDesc = map['daily'][_index]['weather'][0]['description'],
      weatherIconCode = map['daily'][_index]['weather'][0]['icon'],
      dayTemp = map['daily'][_index]['temp']['day'],
      minTemp = map['daily'][_index]['temp']['min'],
      maxTemp = map['daily'][_index]['temp']['max'],
      nightTemp = map['daily'][_index]['temp']['night'],
      eveTemp = map['daily'][_index]['temp']['eve'],
      mornTemp = map['daily'][_index]['temp']['morn'],
      dayTempFeelsLike = map['daily'][_index]['feels_like']['day'],
      nightTempFeelsLike = map['daily'][_index]['feels_like']['night'],
      eveTempFeelsLike = map['daily'][_index]['feels_like']['eve'],
      mornTempFeelsLike = map['daily'][_index]['feels_like']['morn'],
      pressure = map['daily'][_index]['pressure'],
      humidity = map['daily'][_index]['humidity'],
      atmosphericTemp = map['daily'][_index]['dew_point'],
      clouds = map['daily'][_index]['clouds'],
      windSpeed = map['daily'][_index]['wind_speed'],
      windDegrees = map['daily'][_index]['wind_deg'],
      windGust = map['daily'][_index].containsKey('wind_gust')
        ? map['daily'][_index]['wind_gust']
        : null,
      snow = map['daily'][_index].containsKey('snow')
        ? map['daily'][_index]['snow']
        : null,
      rain = map['daily'][_index].containsKey('rain')
        ? map['daily'][_index]['rain']
        : null {
          print('ApiDay.fromApi: map: $map');
        }

  // _getValueByKey(Map<String, dynamic> map, int _index, String key) {
  //   return map['daily'][_index][key];
  // }
}
