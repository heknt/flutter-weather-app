import 'dart:async';
import 'dart:ui';
import 'dart:math';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/model/day.dart';
import 'package:weather_app/domain/model/hour.dart';
import 'package:weather_app/domain/bloc/home_bloc.dart';
import 'package:weather_app/data/storage/constants.dart';


bool isTablet() {
  Size size = window.physicalSize;
  double ratio = window.devicePixelRatio;
  double width = min(size.width / ratio, size.height / ratio);
  print(width);
  return width > 600;
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();    
}


class _HomeState extends State<Home> {
  Geolocator geolocator;
  Position _currentPosition;
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
    if(!isTablet()) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    // homeBloc = Provider.of<HomeBloc>(context);
    return FutureBuilder<void>(
      future: _getCurrentLocation(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          print('snapshot: $snapshot');
        }
        return Scaffold(
        // body: SafeArea(
        //   child: Padding(
        //     padding: EdgeInsets.all(10),
        //     child: Column(
          appBar: AppBar(
            title: Text("Weather App"),
          ),
          body: _consumerHomeBloc(),
        );
      },
    );
  }

  Widget _consumerHomeBloc() {
    return Consumer<HomeBloc>(
      builder: (context, _homeBloc, child) {
        homeBloc = _homeBloc;
        return StreamBuilder<List<Day>>(
          stream: homeBloc.dailyStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _daily = snapshot.data;
            }
            // else {
            //   return _whileLoading();
            // } 
            pressed
              ? print('snapshot.data ${snapshot.data}')
              : print('not pressed yet.');
            return pressed
              ? _showDaily(snapshot.data)
              : StreamBuilder<List<Hour>>(
              stream: homeBloc.hourlyStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _hourly = snapshot.data;
                }
                // else {
                //   return _whileLoading();
                // }
                return _columnContent();
              },
            );
          },
        );
      },
    );
  }

  Widget _showDaily(List<Day> dayList) {
    return dayList != null
      ? Column(
          children: _getDayWidgetList(dayList),
        )
      : Text('_showDaily error: dayList is null');
  }

// TimeOfDay for hours
  List<Widget> _getDayWidgetList(List<Day> dayList) {
    List<Widget> _dayWidgetList = [];
    for (final day in dayList) {
      _dayWidgetList.add(
        Text('Weather for ${DateFormat.yMMMMEEEEd().format(day.time)}')
      );
      _dayWidgetList.add(_getDayWidget(day));
    }
    return _dayWidgetList;
  }

  Widget _getDayWidget(Day day) {
    final doNotExistLable = 'not today';
    return Container(
      child: Column(
        children: <Widget>[
          _getFieldDataRow(dayFieldsTitle['time'], day.time),
          _getFieldDataRow(dayFieldsTitle['sunrise'], day.sunrise),
          _getFieldDataRow(dayFieldsTitle['sunset'], day.sunset),
          _getFieldDataRow(dayFieldsTitle['weather_main'], day.weatherMain),
          _getFieldDataRow(dayFieldsTitle['weather_desc'], day.weatherDesc),
          _getFieldDataRow(dayFieldsTitle['weather_icon_code'], day.weatherIconCode),
          _getFieldDataRow(dayFieldsTitle['day_temp'], day.dayTemp),
          _getFieldDataRow(dayFieldsTitle['min_temp'], day.minTemp),
          _getFieldDataRow(dayFieldsTitle['max_temp'], day.maxTemp),
          _getFieldDataRow(dayFieldsTitle['night_temp'], day.nightTemp),
          _getFieldDataRow(dayFieldsTitle['day_temp_feels_like'], day.dayTempFeelsLike),
          _getFieldDataRow(dayFieldsTitle['night_temp_feels_like'], day.nightTempFeelsLike),
          _getFieldDataRow(dayFieldsTitle['eve_temp_feels_like'], day.eveTempFeelsLike),
          _getFieldDataRow(dayFieldsTitle['morn_temp_feels_like'], day.mornTempFeelsLike),
          _getFieldDataRow(dayFieldsTitle['pressure'], day.pressure),
          _getFieldDataRow(dayFieldsTitle['humidity'], day.humidity),
          _getFieldDataRow(dayFieldsTitle['atmospheric_temp'], day.atmosphericTemp),
          _getFieldDataRow(dayFieldsTitle['clouds'], day.clouds),
          _getFieldDataRow(dayFieldsTitle['wind_speed'], day.windSpeed),
          _getFieldDataRow(dayFieldsTitle['wind_degrees'], day.windDegrees),
          _getFieldDataRow(dayFieldsTitle['wind_gust'], day.windGust ?? doNotExistLable),
          _getFieldDataRow(dayFieldsTitle['snow'], day.snow ?? doNotExistLable),
          _getFieldDataRow(dayFieldsTitle['rain'], day.rain ?? doNotExistLable),
        ],
      ),
    );
  }

  Widget _getFieldDataRow(String attrTitle, var attrValue) {
    return Row(
      children: <Widget>[
        Text('$attrTitle: '),
        Text('$attrValue'),
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

  Widget _columnContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          RaisedButton(
            child: Text('Get location'),
            onPressed: _getLocationWidget,
          ),
          _getLocationWidget(),
          RaisedButton(
            child: Text('Daily'),
            onPressed: _getDaily,
          ),
          RaisedButton(
            child: Text('Hourly'),
            onPressed: _getHourly,
          ),
          pressed
            ? _daily ?? Text('_daily is null')
            : Text('no _daily'),
        ],
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
    setState(() { pressed = true; });
    return _daily;
  }

  List<Hour> _getHourly() {
    homeBloc.updateHourly.add({
      'latitude': _latitude,
      'longitude': _longitude,
    });
    print('home.dart: hourly: $_hourly');
    setState(() { pressed = true; });
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

