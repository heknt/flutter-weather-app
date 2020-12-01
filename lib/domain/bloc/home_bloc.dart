import 'dart:async';

import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
import 'package:weather_app/domain/repository/day_repository.dart';
import 'package:weather_app/domain/repository/hour_repository.dart';
import 'package:weather_app/domain/model/day.dart';
import 'package:weather_app/domain/model/hour.dart';


class HomeBloc {
  final DayRepository _dayRepository;
  final HourRepository _hourRepository;
  Future<SharedPreferences> prefs = SharedPreferences.getInstance();


  HomeBloc(this._dayRepository, this._hourRepository);
  // {
    // prefs.then((val) {
      /// through network 

      // if (val.get('count') != null) {
      //   _counter = val.getInt('count') ?? 1;
      // } else {
      //   _counter = 1;
      // }
      // _actionController.stream.listen(_changeStream);
      // _addValue.add(_counter);
  //   });
  // };

  /// Daily
  final StreamController<List<Day>> _dailyController = StreamController.broadcast();
  Stream<List<Day>> get dailyStream => _dailyController.stream;
  Sink get _addDay => _dailyController.sink;
  // void get resetDaily => _dailyActionController.sink.add(null);
  /// for SharedPreferences
  StreamController _dailyActionController = StreamController();
  StreamSink get addDay => _dailyActionController.sink;

  /// Chosen Day
  final BehaviorSubject<Day> _currDayController = BehaviorSubject();
  Stream get currDayStream => _currDayController.stream;
  Sink get _setCurrDay => _currDayController.sink;
  StreamController _currDayActionController = StreamController();
  StreamSink get setCurrDay => _currDayActionController.sink;


  /// Hourly
  final StreamController<List<Hour>> _hourlyController = StreamController.broadcast();
  Stream<List<Hour>> get hourlyStream => _hourlyController.stream;
  Sink get _addHour => _hourlyController.sink;
  StreamController _hourlyActionController = StreamController();
  StreamSink get addHour => _hourlyActionController.sink;

  /// Chosen Hour
  final BehaviorSubject<Hour> _currHourController = BehaviorSubject();
  Stream get currHourStream => _currHourController.stream;
  Sink get _setCurrHour => _currHourController.sink;
  StreamController _currHourActionController = StreamController();
  StreamSink get setCurrHour => _currHourActionController.sink;

  Day day;
  Hour hour;
  bool isLoading = false;

  Future<void> getDay({
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
    isLoading = false;
  }

  Future<void> getHour({
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
    isLoading = false;
  }

  void _chooseDay() {

  }

  void init() {

  }

  void dispose() {
    print('HomeBloc dispose');
    _dailyController.close();
    _currDayController.close();
    _hourlyController.close();
    _currHourController.close();
  }
}
