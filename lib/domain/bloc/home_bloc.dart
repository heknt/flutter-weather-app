import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/domain/repository/day/daily_repository.dart';
import 'package:weather_app/domain/repository/hour/hourly_repository.dart';
import 'package:weather_app/domain/model/day/day.dart';
import 'package:weather_app/domain/model/hour/hour.dart';
import 'package:weather_app/data/mapper/day/daily_mapper.dart';
import 'package:weather_app/data/mapper/hour/hourly_mapper.dart';


class HomeBloc {
  final String _defaultLanguage;
  /// [latitude, longitude]
  final List<double> _defaultPosition;
  final DailyRepository _dailyRepository;
  final HourlyRepository _hourlyRepository;
  String _language;
  double _latitude;
  double _longitude;
  List<Day> _daily;
  List<Hour> _hourly;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Day day;
  Hour hour;
  bool isLoading = false;

  HomeBloc(this._dailyRepository, this._hourlyRepository)
    : _defaultLanguage = 'en',
      _defaultPosition = [50.0, 30.0]
    {
    prefs.then((val) {
      if (val.get('language') != null) {
        _language = val.getString('language') ?? _defaultLanguage;
      } else {
        _language = _defaultLanguage;
      }
      _languageActionController
          .stream
          .listen(_changeLanguage);
      _setLanguage.add(_language);

      if (val.get('latitude') != null && val.get('longitude') != null) {
        _latitude = val.getDouble('latitude') ?? _defaultPosition[0];
        _longitude = val.getDouble('longitude') ?? _defaultPosition[1];
      } else {
        _latitude = _defaultPosition[0];
        _longitude = _defaultPosition[1];
      }
      _positionActionController
          .stream
          .listen(_changePosition);
      _setPosition.add([_latitude, _longitude]);

      /// TODO: check for internet connection
      if (val.get('hourly') != null) {
        final _hourlyStr = val.getString('hourly');
        if (_hourlyStr != null) {
          _hourly = HourlyMapper.decode(_hourlyStr);
          _updateHourly.add(_hourly);
        }
      }
      _hourlyActionController
          .stream
          // .debounce(new Duration(milliseconds: 500))
          .listen(_getHourlyByCoords);

      if (val.get('daily') != null) {
        final _dailyStr = val.getString('daily');
        if (_dailyStr != null) {
          _daily = DailyMapper.decode(_dailyStr);
          _updateDaily.add(_daily);
        }
      }
      _dailyActionController
          .stream
          // .debounce(new Duration(milliseconds: 500))
          .listen(_getDailyByCoords);
    });
  }


  /// Daily Api
  final StreamController<List<Day>> _dailyController = StreamController.broadcast();
  Stream<List<Day>> get dailyStream => _dailyController.stream;
  Sink get _updateDaily => _dailyController.sink;
  // void get resetDaily => _dailyActionController.sink.add(null);
  StreamController<Map<String, double>> _dailyActionController =
      StreamController();
  StreamSink get updateDaily => _dailyActionController.sink;


  /// Hourly Api
  final StreamController<List<Hour>> _hourlyController = StreamController.broadcast();
  Stream<List<Hour>> get hourlyStream => _hourlyController.stream;
  Sink get _updateHourly => _hourlyController.sink;
  StreamController<Map<String, double>> _hourlyActionController =
      StreamController();
  StreamSink get updateHourly => _hourlyActionController.sink;


  /// Language
  final BehaviorSubject<String> _languageController = BehaviorSubject();
  Stream get languageStream => _languageController.stream;
  Sink get _setLanguage => _languageController.sink;
  StreamController<String> _languageActionController = StreamController();
  StreamSink get setLanguage => _languageActionController.sink;

  /// Position(double latitude, double longitude)
  final BehaviorSubject<List<double>> _positionController = BehaviorSubject();
  Stream get positionStream => _positionController.stream;
  Sink get _setPosition => _positionController.sink;
  StreamController<List<double>> _positionActionController = StreamController();
  StreamSink get setPosition => _positionActionController.sink;

  /// isLoading
  final BehaviorSubject<bool> _isLoadingController = BehaviorSubject();
  Stream get isLoadingStream => _isLoadingController.stream;
  Sink get _setIsLoading => _isLoadingController.sink;


  void _getDailyByCoords(Map<String, double> coords) async {
    await _getDaily(
      latitude: coords['latitude'],
      longitude: coords['longitude'],
      language: _language ?? _defaultLanguage
    );
  }

  Future<void> _getDaily({
    @required double latitude,
    @required double longitude,
    @required String language,
  }) async {
    _setIsLoading.add(true);
    final data = await _dailyRepository.getDaily(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
    
    if (data != null) {
      print('daily data: $data with time ${data[0].time}');
      _daily = data;
      _updateDaily.add(_daily);
      prefs.then((val) {
        val.setString('daily', null);
      });
    }
    _setIsLoading.add(false);
  }

  void _getHourlyByCoords(Map<String, double> coords) async {
    await _getHourly(
      latitude: coords['latitude'],
      longitude: coords['longitude'],
      language: _language ?? _defaultLanguage
    );
  }

  Future<void> _getHourly({
    @required double latitude,
    @required double longitude,
    @required String language,
  }) async {
    _setIsLoading.add(true);
    final data = await _hourlyRepository.getHourly(
      latitude: latitude,
      longitude: longitude,
      language: language
    );

    if (data != null) {
      print('hourly data: $data');
      _hourly = data;
      _updateHourly.add(_hourly);
      prefs.then((val) {
        val.setString('hourly', null);
      });
    }
    _setIsLoading.add(false);
  }

  void _changeLanguage(String chosenLang) async {
    _language = chosenLang ?? _defaultLanguage;

    _setLanguage.add(_language);
    prefs.then((val) {
      val.setString('language', _language);
    });
  }

  void _changePosition(List<double> receivedPosition) async {
    if (receivedPosition != null) {
      _latitude = receivedPosition[0] ?? _defaultPosition[0];
      _longitude = receivedPosition[1] ?? _defaultPosition[1];

      _setPosition.add(receivedPosition);
      prefs.then((val) {
        val.setDouble('latitude', _latitude);
        val.setDouble('longitude', _longitude);
      });
    }
  }

  void dispose() {
    print('HomeBloc dispose');
    _dailyController.close();
    _dailyActionController.close();
    _hourlyController.close();
    _hourlyActionController.close();
    _languageController.close();
    _languageActionController.close();
  }
}
