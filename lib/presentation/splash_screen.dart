import 'package:flutter/material.dart';
import 'package:weather_app/internal/routes.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: _backgroundBody(context),
    );
  }

  Widget _backgroundBody(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: _delayedImageNavigator(context),
          ),
        ],
      ),
    );
  }

  Widget _delayedImageNavigator(BuildContext context) {
    Future.delayed(
      Duration(milliseconds: 4000),
      () async {
        await Navigator.of(context).pushReplacementNamed(homeScreenRouteName);
      }
    );
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacementNamed(homeScreenRouteName);
      },
      child: Image(
        image: AssetImage('assets/multi-logo.jpg'),
        width: MediaQuery.of(context).size.width/1.5,
      ),
    );
  }
}
