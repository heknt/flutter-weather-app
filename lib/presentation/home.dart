import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/model/day.dart';
import 'package:weather_app/domain/model/hour.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();    
}


class _HomeState extends State<Home> {
  final Geolocator geolocator =
    Geolocator()..forceAndroidLocationManager;
  Position _currentPosition;
  String _currentAddress;

  Day _day;
  Hour _hour;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: SafeArea(
      //   child: Padding(
      //     padding: EdgeInsets.all(10),
      //     child: Column(
      appBar: AppBar(
        title: Text("Weather App"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _getLocationWidget(),
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
                        if (_currentPosition != null &&
                            _currentAddress != null)
                          Text(_currentAddress,
                              style:
                                  Theme.of(context).textTheme.bodyText2),
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

  _getDaily() {
    return null;
  }

  _getHourly() {
    return null;
  }


  void _getCurrentLocation() {
    geolocator
        .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
      });
      _getAddressFromLatLng();
    }).catchError((e) {
      print(e);
    });
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
}

