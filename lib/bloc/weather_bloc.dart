import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:blocdemo/model/weather.dart';
import 'bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  @override
  WeatherState get initialState => InitialWeatherState();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event,) async* {
    if (event is GetWeather) {
      yield WeatherLoadingState();
      final weather = await _fetchWeatherFromFakeApi(event.cityName);
      yield WeatherLoadedState(weather);
    }
  }
}

_fetchWeatherFromFakeApi(String cityName) {
  Future.delayed(Duration(seconds: 1), () {
    return Weather(20,'Gorakhpur');
  });
}
