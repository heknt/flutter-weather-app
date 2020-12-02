import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:weather_app/presentation/home.dart';
import 'package:weather_app/domain/bloc/home_bloc.dart';
import 'package:weather_app/internal/dependencies/home_bloc_module.dart';


class Application extends StatelessWidget {
  static const _title = 'Revolution(Weather)';

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<HomeBloc>(
          create: (_) => HomeBlocModule.homeBloc(),
          dispose: (_, HomeBloc homeBloc) => homeBloc.dispose(),
        ),
      ],
      child: MaterialApp(
        title: _title,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Home(_title),
      ),
    );
  }
}
