import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/domain/repository/day_repository.dart';
import 'package:weather_app/domain/repository/hour_repository.dart';
import 'package:weather_app/domain/model/day.dart';
import 'package:weather_app/domain/model/hour.dart';
import 'package:weather_app/data/mapper/daily_mapper.dart';
import 'package:weather_app/data/mapper/hourly_mapper.dart';


class HomeBloc {
  final _defaultLanguage;
  final DayRepository _dayRepository;
  final HourRepository _hourRepository;
  String _language;
  List<Day> _daily;
  List<Hour> _hourly;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();

  Day day;
  Hour hour;
  bool isLoading = false;

  HomeBloc(this._dayRepository, this._hourRepository)
    : _defaultLanguage = 'en' {
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
        val.setString('daily', null);
        if (_dailyStr != null) {
          // _daily = DailyMapper.decode(_dailyStr);
          // _updateDaily.add(_daily);
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
  /// for SharedPreferences
  StreamController<Map<String, double>> _dailyActionController =
      StreamController();
  StreamSink get updateDaily => _dailyActionController.sink;

  /// Chosen Day
  final BehaviorSubject<Day> _currDayController = BehaviorSubject();
  Stream get currDayStream => _currDayController.stream;
  Sink get _setCurrDay => _currDayController.sink;
  StreamController _currDayActionController = StreamController();
  StreamSink get setCurrDay => _currDayActionController.sink;


  /// Hourly Api
  final StreamController<List<Hour>> _hourlyController = StreamController.broadcast();
  Stream<List<Hour>> get hourlyStream => _hourlyController.stream;
  Sink get _updateHourly => _hourlyController.sink;
  StreamController<Map<String, double>> _hourlyActionController =
      StreamController();
  StreamSink get updateHourly => _hourlyActionController.sink;

  /// Chosen Hour
  final BehaviorSubject<Hour> _currHourController = BehaviorSubject();
  Stream get currHourStream => _currHourController.stream;
  Sink get _setCurrHour => _currHourController.sink;
  StreamController _currHourActionController = StreamController();
  StreamSink get setCurrHour => _currHourActionController.sink;

  /// Language
  final BehaviorSubject<String> _languageController = BehaviorSubject();
  Stream get languageStream => _languageController.stream;
  Sink get _setLanguage => _languageController.sink;
  StreamController<String> _languageActionController = StreamController();
  StreamSink get setLanguage => _languageActionController.sink;


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
    isLoading = true;
    final data = await _dayRepository.getDay(
      latitude: latitude,
      longitude: longitude,
      language: language
    );
    
    if (data != null) {
      print('daily data: $data with time ${data.time}');
      _daily = [data];
      _updateDaily.add(_daily);
      prefs.then((val) {
        // val.setString('daily', DailyMapper.encode([data]));
      });
    }
    isLoading = false;
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
    isLoading = true;
    final data = await _hourRepository.getHour(
      latitude: latitude,
      longitude: longitude,
      language: language
    );

    if (data != null) {
      print('hourly data: $data');
      _hourly = [data];
      prefs.then((val) {
        val.setString('hourly', HourlyMapper.encode([data]));
      });
    }
    isLoading = false;
  }

  void _chooseDay() {

  }

  void _changeLanguage(String chosenLang) async {
    _language = chosenLang ?? _defaultLanguage;

    _setLanguage.add(_language);
    prefs.then((val) {
      val.setString('language', _language);
    });
  }

  void init() {

  }

  void dispose() {
    print('HomeBloc dispose');
    _dailyController.close();
    _dailyActionController.close();
    _currDayController.close();
    // _currDayActionController.close();
    _hourlyController.close();
    _hourlyActionController.close();
    _currHourController.close();
    // _currHourActionController.close();
    _languageController.close();
    _languageActionController.close();
  }
}
