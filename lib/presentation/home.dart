import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/domain/model/day.dart';
import 'package:weather_app/domain/model/hour.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();    
}


class _HomeState extends State<Home> {
  Geolocator geolocator;
  Position _currentPosition;
  String _currentAddress;

  Day _day;
  Hour _hour;

  // @override
  // void initState() {
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
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
      },
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
                            style: Theme.of(context).textTheme.bodyText2),
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


  Future<void> _getCurrentLocation() async {
    print('_getCurrentLocation');
    geolocator =
      await Geolocator()..forceAndroidLocationManager;
    geolocator
        .getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        print('_getCurrentLocation222');
      });
      print('_getCurrentLocation333');
      _getAddressFromLatLng();
      print('_getCurrentLocation444');
    }).catchError((e) {
      print(e);
    });
    print('_getCurrentLocation555');
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

