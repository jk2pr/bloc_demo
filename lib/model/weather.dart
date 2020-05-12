import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class Weather extends Equatable {
  final double temp;
  final String cityName;

  Weather(this.temp, this.cityName,) : super([temp, cityName]);
}
