// import 'package:weather_app/data/api/services/openweathermap_service.dart';


Map<String, dynamic> dayFieldsInfo = {
  'time': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Weather on',
    'ru': 'Погода на',
  },
  'sunrise': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Sunrise',
    'ru': 'Восход',
  },
  'sunset': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Sunset',
    'ru': 'Закат',
  },
  'weather_main': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Main Info',
    'ru': 'Основная информация',
  },
  'weather_desc': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Description',
    'ru': 'Описание',
  },
  /// not working. can not find _getIconUrl method in OpenWeatherMapService
  // 'weather_icon_code': ((String iconCode) =>
  //     OpenWeatherMapService._getIconUrl(iconCode)).toString(),
  'day_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Day Temperature',
    'ru': 'Температура днём',
  },
  'min_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Min Temp.',
    'ru': 'Минимальная температура',
  },
  'max_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Max Temp.',
    'ru': 'Максимальная температура',
  },
  'night_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Night Temperature',
    'ru': 'Температура ночью',
  },
  'eve_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Evening Temp.',
    'ru': 'Температура вечером',
  },
  'morn_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Morning Temp.',
    'ru': 'Температура утром',
  },
  'day_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Day Temp. feels like',
    'ru': 'Температура днём ощущается как',
  },
  'night_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Night Temp. feels like',
    'ru': 'Температура ночью ощущается как',
  },
  'eve_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Evening Temp. feels like',
    'ru': 'Температура вечером ощущается как',
  },
  'morn_temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Morning Temp. feels like',
    'ru': 'Температура утром ощущается как',
  },
  'pressure': {
    'unit': {
      'en': 'hPa',
      'ru': 'кПа',
    },
    'en': 'Pressure',
    'ru': 'Давление',
  },
  'humidity': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Humidity',
    'ru': 'Влажность',
  },
  'atmospheric_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Atmospheric Temp.',
    'ru': 'Температура в атмосфере',
  },
  'clouds': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Cloudiness',
    'ru': 'Облачность',
  },
  'wind_speed': {
    'unit': {
      'en': 'metre/sec',
      'ru': 'м/с',
    },
    'en': 'Wind Speed',
    'ru': 'Скорость ветра',
  },
  'wind_degrees': {
    'unit': {
      'en': '°',
      'ru': '°',
    },
    'en': 'Wind Degrees',
    'ru': 'Ветер под углом',
  },
  'wind_gust': {
    'unit': {
      'en': 'metre/sec',
      'ru': 'м/с',
    },
    'en': 'Wind Gust',
    'ru': 'Порыв ветра',
  },
  'snow': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Snow',
    'ru': 'Снег',
  },
  'rain': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Rain',
    'ru': 'Дождь',
  },
};


Map<String, dynamic> hourFieldsInfo = {
  'time': {
    'unit': {
      'en': "o'clock",
      'ru': '',
    },
    'en': 'Weather on',
    'ru': 'Погода на',
  },
  'weather_main': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Main Info',
    'ru': 'Основная информация',
  },
  'weather_desc': {
    'unit': {
      'en': '',
      'ru': '',
    },
    'en': 'Description',
    'ru': 'Описание',
  },
  /// not working. can not find _getIconUrl method in OpenWeatherMapService
  // 'weather_icon_code': ((String iconCode) =>
  //     OpenWeatherMapService._getIconUrl(iconCode)).toString(),
  'temperature': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Temperature',
    'ru': 'Температура',
  },
  'temp_feels_like': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Temperature feels like',
    'ru': 'Температура ощущается как',
  },
  'pressure': {
    'unit': {
      'en': 'hPa',
      'ru': 'кПа',
    },
    'en': 'Pressure',
    'ru': 'Давление',
  },
  'humidity': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Humidity',
    'ru': 'Влажность',
  },
  'atmospheric_temp': {
    'unit': {
      'en': '°C',
      'ru': '°C',
    },
    'en': 'Atmospheric Temp.',
    'ru': 'Температура в атмосфере',
  },
  'clouds': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Cloudiness',
    'ru': 'Облачность',
  },
  'wind_speed': {
    'unit': {
      'en': 'metre/sec',
      'ru': 'м/с',
    },
    'en': 'Wind Speed',
    'ru': 'Скорость ветра',
  },
  'wind_degrees': {
    'unit': {
      'en': '°',
      'ru': '°',
    },
    'en': 'Wind Degrees',
    'ru': 'Ветер под углом',
  },
  'wind_gust': {
    'unit': {
      'en': 'metre/sec',
      'ru': 'м/с',
    },
    'en': 'Wind Gust',
    'ru': 'Порыв ветра',
  },
  'snow': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Snow',
    'ru': 'Снег',
  },
  'rain': {
    'unit': {
      'en': '%',
      'ru': '%',
    },
    'en': 'Rain',
    'ru': 'Дождь',
  },
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