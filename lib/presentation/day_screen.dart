import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/domain/model/day/day.dart';
import 'package:weather_app/data/storage/constants.dart';

import 'helpers/day_helper.dart';
import 'helpers/list_helper.dart';


class DayScreen extends StatelessWidget {
  Day day;
  final String language;
  final String dayTimeFormatOfLang;
  final String dateFormatOfLang;
  String timeFormat;

  DayScreen({
      this.day,
      this.language,
      this.dayTimeFormatOfLang,
      this.dateFormatOfLang,
    });

  @override
  Widget build(BuildContext context) {
    timeFormat =
        DateFormat("$dateFormatOfLang").format(day.time);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '$timeFormat',
          // style: ListHelper.titleStyle(),
        ),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: _getDayFullWidget(),
      ),
    );
  }

  Widget _getDayFullWidget() {
    return Column(
      children: <Widget>[
        ListHelper.getIconFromNetwork(day.weatherIconCode),
        Container(
          padding: const EdgeInsets.all(10.0),
          // decoration: ListHelper.boxDecorList(),
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: flatDayFields.length-1, // omitting 'time'
            itemBuilder: (context, index) {
              String _title = flatDayFields[index+1];
              return ListTile(
                title: Text(dayFieldsInfo[_title][language]),
                onTap: () {},
                trailing: DayHelper.getDayFieldValueBoxByTitle(
                    day, _title, dayTimeFormatOfLang, language
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

