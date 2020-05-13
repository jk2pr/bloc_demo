
import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final double temp;
  final String cityName;

  Weather(this.temp, this.cityName,) : super([temp, cityName]);
}
