import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/model/day/day.dart';
import 'package:weather_app/domain/model/hour/hour.dart';
import 'package:weather_app/domain/bloc/home_bloc.dart';
import 'package:weather_app/data/storage/constants.dart';
// import 'package:weather_app/data/api/services/openweathermap_service.dart';


bool isTablet() {
  Size size = window.physicalSize;
  double ratio = window.devicePixelRatio;
  double width = min(size.width / ratio, size.height / ratio);
  print(width);
  return width > 600;
}

class Home extends StatefulWidget {
  final String _title;

  Home(this._title);

  @override
  HomeState createState() => HomeState();    
}


class HomeState extends State<Home> {
  final List<String> _availableLangs = ['en', 'ru'];
  String _language;
  String _timeFormatOfLang;
  Geolocator geolocator;
  Position _currentPosition;
  Widget _locationWidget;
  String _currentAddress;
  double _latitude = 50.0;
  double _longitude = 30.0;

  Day _day;
  Hour _hour;
  List<Day> _daily;
  List<Hour> _hourly;
  HomeBloc homeBloc;
  bool pressed = false;

  @override
  void initState() {
    super.initState();
    if (!isTablet()) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationWidget = _getLocationWidget();
  }

  @override
  Widget build(BuildContext context) {
    // homeBloc = Provider.of<HomeBloc>(context);
    return FutureBuilder<void>(
      future: _getCurrentLocation(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          print('snapshot has error: $snapshot');
        }
        return _consumeHomeBloc();
      },
    );
  }

  Widget _consumeHomeBloc() {
    return Consumer<HomeBloc>(
      builder: (context, _homeBloc, child) {
        homeBloc = _homeBloc;
        return StreamBuilder<List<Day>>(
          stream: homeBloc.dailyStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _daily = snapshot.data;
              print('hass Daily');
            } else { print('hass NOT Daily Dataa'); }
            // else {
            //   return _whileLoading();
            // } 
            pressed
              ? print('snapshot.data ${snapshot.data}')
              : print('not pressed yet.');
            return StreamBuilder<List<Hour>>(
              stream: homeBloc.hourlyStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _hourly = snapshot.data;
                  print('hass Hourly');
                } else { print('hass NOT Hourly Dataa'); }
                // else {
                //   return _whileLoading();
                // }
                return StreamBuilder<String>(
                  stream: homeBloc.languageStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _language = snapshot.data;
                      _timeFormatOfLang = _language == 'en'
                        ? 'h:mm a'
                        : 'k:mm';
                      print('hass Language $_language');
                    } else { print('hass NOT Language Dataa'); }
                    
                    return _scaffold();
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _scaffold() {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._title),
        actions: <Widget>[
          _languageChooser(),
        ],
      ),
      body: _contentColumn(),
    );
  }

  Widget _languageChooser() {
    return DropdownButton<String>(
      value: _language,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      // style: TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        // color: Colors.white,
      ),
      onChanged: (String chosenLang) {
        setState(() {
          _language = chosenLang;
        });
        homeBloc.setLanguage.add(_language);
      },
      items: _availableLangs
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget _contentColumn() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            child: Text('Get location'),
            onPressed: () {
              setState(() {
                _locationWidget = _getLocationWidget();
              });
            }
          ),
          _locationWidget,
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('Daily'),
                onPressed: _getDaily,
              ),
              RaisedButton(
                child: Text('Hourly'),
                onPressed: _getHourly,
              ),
            ],
          ),
          // if (pressed) {
            _daily != null
              ? _showDaily(_daily) ?? Text('_daily is null')
              : Text('no _daily'),
            _hourly != null
              ? _showHourly(_hourly) ?? Text('_hourly is null')
              : Text('no _hourly'),
          // }
        ],
      ),
    );
  }

  Widget _showDaily(List<Day> dayList) {
    return dayList != null
      ? Column(
          children: _getDayWidgetList(dayList),
        )
      : Text('_showDaily error: dayList is null');
  }

  Widget _showHourly(List<Hour> hourList) {
    return hourList != null
      ? Column(
          children: _getHourWidgetList(hourList),
        )
      : Text('_showHourly error: hourList is null');
  }


  List<Widget> _getDayWidgetList(List<Day> dayList) {
    List<Widget> _dayWidgetList = [];
    

    for (final day in dayList) {
      _dayWidgetList.add(
        _getIconFromNetwork(day.weatherIconCode)
      );
      _dayWidgetList.add(
        Text('${dayFieldsInfo["time"][_language]}  ${DateFormat.yMMMMEEEEd().format(day.time)}')
      );
      _dayWidgetList.add(_getDayWidget(day));
    }
    return _dayWidgetList;
  }

  // TimeOfDay for hours
  List<Widget> _getHourWidgetList(List<Hour> hourList) {
    List<Widget> _hourWidgetList = [];
    // final OpenWeatherMapService _service = OpenWeatherMapService();

    for (final hour in hourList) {
      _hourWidgetList.add(
        _getIconFromNetwork(
          // _service,
          hour.weatherIconCode)
      );
      _hourWidgetList.add(
        Text('${hourFieldsInfo["time"][_language]} ${DateFormat("$_timeFormatOfLang, EEEE, MMMM d").format(hour.time)}')
      );
      _hourWidgetList.add(_getHourWidget(hour));
    }
    return _hourWidgetList;
  }

  Widget _getIconFromNetwork(
    // OpenWeatherMapService _service,
    String iconCode
  ){
    return Image.network(
      /// _service doesn't want to define methods
      /// i.e. '_getIconUrl()', '_apiBaseUrl'...
      // _service._getIconUrl(iconCode)

      /// so local full-defined url for this
      'http://openweathermap.org/img/wn/$iconCode@2x.png'
    );
  }

  Widget _getDayWidget(Day day) {
    final doNotExistLable = 'not this day';
    return Container(
      child: Column(
        children: <Widget>[
          _getFieldDataRow(dayFieldsInfo['sunrise'], _toTimeOfDayStr(day.sunrise)),
          _getFieldDataRow(dayFieldsInfo['sunset'], _toTimeOfDayStr(day.sunset)),
          _getFieldDataRow(dayFieldsInfo['weather_main'], day.weatherMain),
          _getFieldDataRow(dayFieldsInfo['weather_desc'], day.weatherDesc),
          _getFieldDataRow(dayFieldsInfo['day_temp'], day.dayTemp),
          _getFieldDataRow(dayFieldsInfo['min_temp'], day.minTemp),
          _getFieldDataRow(dayFieldsInfo['max_temp'], day.maxTemp),
          _getFieldDataRow(dayFieldsInfo['night_temp'], day.nightTemp),
          _getFieldDataRow(dayFieldsInfo['eve_temp'], day.eveTemp),
          _getFieldDataRow(dayFieldsInfo['morn_temp'], day.mornTemp),
          _getFieldDataRow(dayFieldsInfo['day_temp_feels_like'], day.dayTempFeelsLike),
          _getFieldDataRow(dayFieldsInfo['night_temp_feels_like'], day.nightTempFeelsLike),
          _getFieldDataRow(dayFieldsInfo['eve_temp_feels_like'], day.eveTempFeelsLike),
          _getFieldDataRow(dayFieldsInfo['morn_temp_feels_like'], day.mornTempFeelsLike),
          _getFieldDataRow(dayFieldsInfo['pressure'], day.pressure),
          _getFieldDataRow(dayFieldsInfo['humidity'], day.humidity),
          _getFieldDataRow(dayFieldsInfo['atmospheric_temp'], day.atmosphericTemp),
          _getFieldDataRow(dayFieldsInfo['clouds'], day.clouds),
          _getFieldDataRow(dayFieldsInfo['wind_speed'], day.windSpeed),
          _getFieldDataRow(dayFieldsInfo['wind_degrees'], day.windDegrees),
          _getFieldDataRow(dayFieldsInfo['wind_gust'], day.windGust ?? doNotExistLable),
          _getFieldDataRow(dayFieldsInfo['snow'], day.snow ?? doNotExistLable),
          _getFieldDataRow(dayFieldsInfo['rain'], day.rain ?? doNotExistLable),
        ],
      ),
    );
  }

  String _toTimeOfDayStr(DateTime rawTime) {
    return DateFormat(_timeFormatOfLang).format(rawTime);
  }

  Widget _getHourWidget(Hour hour) {
    final doNotExistLable = 'not this hour';
    return Container(
      child: Column(
        children: <Widget>[
          _getFieldDataRow(hourFieldsInfo['weather_main'], hour.weatherMain),
          _getFieldDataRow(hourFieldsInfo['weather_desc'], hour.weatherDesc),
          _getFieldDataRow(hourFieldsInfo['temperature'], hour.temperature),
          _getFieldDataRow(hourFieldsInfo['temp_feels_like'], hour.tempFeelsLike),
          _getFieldDataRow(hourFieldsInfo['pressure'], hour.pressure),
          _getFieldDataRow(hourFieldsInfo['humidity'], hour.humidity),
          _getFieldDataRow(hourFieldsInfo['atmospheric_temp'], hour.atmosphericTemp),
          _getFieldDataRow(hourFieldsInfo['clouds'], hour.clouds),
          _getFieldDataRow(hourFieldsInfo['wind_speed'], hour.windSpeed),
          _getFieldDataRow(hourFieldsInfo['wind_degrees'], hour.windDegrees),
          _getFieldDataRow(hourFieldsInfo['wind_gust'], hour.windGust ?? doNotExistLable),
          _getFieldDataRow(hourFieldsInfo['snow'], hour.snow ?? doNotExistLable),
          _getFieldDataRow(hourFieldsInfo['rain'], hour.rain ?? doNotExistLable),
        ],
      ),
    );
  }

  Widget _getFieldDataRow(Map<String, dynamic> fieldMap, var fieldValue) {
    return Row(
      children: <Widget>[
        Text('${fieldMap[_language]}: '),
        Text('$fieldValue ${fieldMap["unit"][_language]}'),
      ],
    );
  }

  Widget _whileLoading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  Widget _getLocationWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(Icons.location_on),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Location',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '_currentAddress $_currentAddress',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text(
                          '_currentPosition $_currentPosition',
                          style: Theme.of(context).textTheme.caption,
                        ),
                        if (_currentPosition != null &&
                            _currentAddress != null)
                          Text(
                            _currentAddress,
                            style: Theme.of(context).textTheme.bodyText2
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Day> _getDaily() {
    homeBloc.updateDaily.add({
      'latitude': _latitude,
      'longitude': _longitude,
    });
    print('home.dart: daily: $_daily');
    return _daily;
  }

  List<Hour> _getHourly() {
    homeBloc.updateHourly.add({
      'latitude': _latitude,
      'longitude': _longitude,
    });
    print('home.dart: hourly: $_hourly');
    return _hourly;
  }


  Future<void> _getCurrentLocation() async {
    print('_getCurrentLocation111 IN');
    geolocator =
      await Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print('_getCurrentLocation222 position: $position setState OUT');
      });
      print('_getCurrentLocation333 setState After');
      _getAddressFromLatLng();
      print('_getCurrentLocation444 geolocator OUT');
    }).catchError((e) {
      print(e);
    });
    print('_getCurrentLocation555 OUT');
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark place = p[0];
      setState(() {
        _currentAddress =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }
}

