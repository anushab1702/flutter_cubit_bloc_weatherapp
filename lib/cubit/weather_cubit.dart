// ignore: import_of_legacy_library_into_null_safe
import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/data/model/weather.dart';
import 'package:flutter_cubit_bloc_tutorial/models/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository _weatherRepository;

  // ignore: prefer_const_constructors
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async {
    try {
      // ignore: prefer_const_constructors
      emit(WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException {
      // ignore: prefer_const_constructors
      emit(WeatherError("Couldn't fetch weather. Is the device online?"));
    }
  }
}
