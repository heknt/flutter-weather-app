# Weather Getter
This app takes a weather API from [openweathermap](https://openweathermap.org) and shows it in a list format.

## Structure
Project divided by four structure levels (data, domain (business-logic), internal, presentation).

Presentation contains two screens:
- splash - with weather-logo (shown for several sec on app start, and you can tap on image to speed up the transition).
- home - main screen. Here is location detecting, localization feature (choose betweeb English and Russian), and two buttons (daily, hourly) which can open API by tap.


## API
#### Types of taken API:
- daily - shows weather info of each day of the next week.
- hourly - shows weather info of each hour of the next two days.

#### Example of API
results in my project - [daily.json](https://github.com/heknt/flutter-weather-app/blob/master/lib/data/storage/daily.json) and [hourly.json](https://github.com/heknt/flutter-weather-app/blob/master/lib/data/storage/hourly.json)

## Running
```bash
$ git clone https://github.com/heknt/flutter-weather-app.git
$ cd flutter-weather-app
```
Connect your phone to computer and enable USB debugging. Next:
```bash
flutter-weather-app$ flutter doctor
flutter-weather-app$ flutter pub get
flutter-weather-app$ flutter run
```
