import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blocdemo/model/weather.dart';
import 'bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is GetWeather) {
      yield WeatherLoadingState();
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      print(weather.cityName);
      yield WeatherLoadedState(weather);
    }
  }
}

Future<Weather> _fetchWeatherFromFakeApi(String cityName) {
  return Future.delayed(Duration(milliseconds: 10000), () {
    var weather = Weather(20, 'Gorakhpur');

    return weather;
  });
}
