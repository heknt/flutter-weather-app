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

class HomeScreen extends StatefulWidget {
  final String _title;

  HomeScreen(this._title);

  @override
  HomeScreenState createState() => HomeScreenState();    
}


class HomeScreenState extends State<HomeScreen> {
  final List<String> _availableLangs = ['en', 'ru'];
  String _language;
  String _dayTimeFormatOfLang;
  String _dateFormatOfLang;
  Geolocator geolocator;
  Position _currentPosition;
  String _currentAddress;
  Widget _locationWidget;
  double _latitude;
  double _longitude;
  bool _isLoading;
  Widget _apiContentWidget;

  List<Day> _daily;
  List<Hour> _hourly;
  HomeBloc homeBloc;
  bool dailyPressed;
  bool hourlyPressed;

  @override
  void initState() {
    super.initState();
    if (!isTablet()) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown
      ]);
    }
    _language = 'en';
    _latitude = 50.0;
    _longitude = 30.0;
    _isLoading = false;
    dailyPressed = false;
    hourlyPressed = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _locationWidget = _getLocationWidget();
  }

  @override
  Widget build(BuildContext context) {
    // homeBloc = Provider.of<HomeBloc>(context);
    return Consumer<HomeBloc>(
      builder: (context, _homeBloc, child) {
        homeBloc = _homeBloc;

        return StreamBuilder<List<Day>>(
          stream: homeBloc.dailyStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _daily = snapshot.data;
              if (dailyPressed) {
                _apiContentWidget = _showDaily(_daily);
                print('showing daily stream');
                dailyPressed = false;
              }
              print('hass Daily');
            } else { print('hass NOT Daily Dataa'); }

            return StreamBuilder<List<Hour>>(
              stream: homeBloc.hourlyStream,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  _hourly = snapshot.data;
                  if (hourlyPressed) {
                    _apiContentWidget = _showHourly(_hourly);
                    print('showing hourly stream');
                    hourlyPressed = false;
                  }
                  print('hass Hourly');
                } else { print('hass NOT Hourly Dataa'); }

                return StreamBuilder<String>(
                  stream: homeBloc.languageStream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _language = snapshot.data;
                      _dateFormatOfLang =
                          localePhrases['time']['date_format'][_language];
                      _dayTimeFormatOfLang =
                          localePhrases['time']['day_time_format'][_language];
                      print('hass Language $_language');
                    } else { print('hass NOT Language Dataa'); }
                    
                    return StreamBuilder<List<double>>(
                      stream: homeBloc.positionStream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          _latitude = snapshot.data[0];
                          _longitude = snapshot.data[1];
                          _locationWidget = _getLocationWidget();
                          print('hass Position ${snapshot.data}');
                        } else { print('hass NOT Hourly Dataa'); }

                        return StreamBuilder<bool>(
                          stream: homeBloc.isLoadingStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              _isLoading = snapshot.data;
                              print('hass isLoading ${snapshot.data}');
                            } else { print('hass NOT isLoading Dataa'); }

                            return _futureBuilderLocation();
                          },
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  Widget _futureBuilderLocation() {
    return FutureBuilder<void>(
      future: _getCurrentLocation(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          print('snapshot has error: $snapshot');
        }
        return _scaffold();
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
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _contentColumn(),
      ),
    );
  }

  Widget _languageChooser() {
    return DropdownButton<String>(
      value: _language,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.brown),
      underline: Container(
        height: 2,
        color: Colors.brown,
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
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
        );
      }).toList(),
    );
  }

  Widget _contentColumn() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _locationWidget,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton(
                  child: Text(localePhrases['data']['daily'][_language]),
                  onPressed: () {
                    setState(() {
                      dailyPressed = true;
                    });
                    _daily = _getDaily();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: RaisedButton(
                  child: Text(localePhrases['data']['hourly'][_language]),
                  onPressed: () {
                    setState(() {
                      hourlyPressed = true;
                    });
                    _hourly = _getHourly();
                  },
                ),
              ),
            ],
          ),
          _isLoading
            ? _whileLoading()
            : _apiContentWidget
              ?? Text(localePhrases['data']['data_is_coming'][_language]),
        ],
      ),
    );
  }

  Widget _showDaily(List<Day> dayList) {
    return dayList != null
      ? Column(
          children: _getDayWidgetList(dayList),
        )
      : Text(localePhrases['data']['press_one_more']['daily'][_language]);
  }

  Widget _showHourly(List<Hour> hourList) {
    return hourList != null
      ? Column(
          children: _getHourWidgetList(hourList),
        )
      : Text(localePhrases['data']['press_one_more']['hourly'][_language]);
  }


  List<Widget> _getDayWidgetList(List<Day> dayList) {
    List<Widget> _dayWidgetList = [];

    for (final day in dayList) {
      _dayWidgetList.add(
        _getIconFromNetwork(day.weatherIconCode)
      );
      String timeFormat = DateFormat(_dateFormatOfLang).format(day.time);
      _dayWidgetList.add(
        Text('${dayFieldsInfo["time"][_language]} $timeFormat',
          style: _titleStyle(),
        )
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
      String timeFormat =
          DateFormat("$_dayTimeFormatOfLang, $_dateFormatOfLang").format(hour.time);
      _hourWidgetList.add(
        Text('${hourFieldsInfo["time"][_language]} $timeFormat',
          style: _titleStyle(),
        )
      );
      _hourWidgetList.add(_getHourWidget(hour));
    }
    return _hourWidgetList;
  }

  TextStyle _titleStyle() {
    return TextStyle(
      height: 3,
      fontSize: 16,
      fontStyle: FontStyle.italic,
    );
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
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: _boxDecorWidget(),
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
          _getFieldDataRow(dayFieldsInfo['wind_gust'], day.windGust),
          _getFieldDataRow(dayFieldsInfo['snow'], day.snow),
          _getFieldDataRow(dayFieldsInfo['rain'], day.rain),
        ],
      ),
    );
  }

  String _toTimeOfDayStr(DateTime rawTime) {
    return DateFormat(_dayTimeFormatOfLang).format(rawTime);
  }

  Widget _getHourWidget(Hour hour) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: _boxDecorWidget(),
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
          _getFieldDataRow(hourFieldsInfo['wind_gust'], hour.windGust),
          _getFieldDataRow(hourFieldsInfo['snow'], hour.snow),
          _getFieldDataRow(hourFieldsInfo['rain'], hour.rain),
        ],
      ),
    );
  }

  BoxDecoration _boxDecorWidget() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.brown[500],
      ),
      borderRadius: BorderRadius.all(Radius.circular(8))
    );
  }

  Widget _getFieldDataRow(Map<String, dynamic> fieldMap, var fieldValue) {
    final doNotExistLable = localePhrases['data']['do_not_exist_lable'][_language];
    TextStyle _fieldStyle = TextStyle(
        fontSize: 15,
      );
    return Row(
      children: <Widget>[
        Text('${fieldMap[_language]}: ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
        fieldValue != null
          ? Text('$fieldValue ${fieldMap["unit"][_language]}',
              style: _fieldStyle,
            )
          : Text(doNotExistLable,
              style: _fieldStyle,
            ),
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
                      children: _locationContent(),
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

  List<Widget> _locationContent() {
    List<Widget> content = [
      Text(
        localePhrases['location'][_language],
        style: Theme.of(context).textTheme.caption,
      ),
    ];
    if (_currentPosition == null)
      content.add(Text(localePhrases['location']['update_position'][_language]));
      content.add(Text(
        "${localePhrases['location']['default_position'][_language]}: Lat: $_latitude, Long: $_longitude",
        style: Theme.of(context).textTheme.caption,
      ));
    if (_currentPosition != null) {
      content = [content[0]];
      content.add(Text(
        '${localePhrases['location']['current_position'][_language]}: $_currentPosition',
        style: Theme.of(context).textTheme.caption,
      ));
      if (_currentAddress != null) {
        content.add(Text(
          '${localePhrases['location']['current_address'][_language]}: $_currentAddress',
          style: Theme.of(context).textTheme.bodyText2,
        ));
      }
    }
    return content;
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
    // print('_getCurrentLocation111 IN');
    geolocator =
      await Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _latitude = _currentPosition.latitude;
        _longitude = _currentPosition.longitude;
        // print('_getCurrentLocation222 position: $position setState OUT');
      });
      homeBloc.setPosition.add([_latitude, _longitude]);
      // print('_getCurrentLocation333 setState After');
      _getAddressFromLatLng();
      // print('_getCurrentLocation444 geolocator OUT');
    }).catchError((e) {
      print(e);
    });
    // print('_getCurrentLocation555 OUT');
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude
        );
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
    super.dispose();
  }
}

