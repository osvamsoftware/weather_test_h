import 'package:weather_test/data/datasource/weather_datasource.dart';
import 'package:weather_test/data/models/weather_details_model.dart';

abstract class WeatherRepositoryBase {
  Future<WeatherDetailsModel> getWeatherDetails(double lat, double lng, int days);
}

class WeatherRepositoryImpl implements WeatherRepositoryBase {
  final WeatherDatasourceBase datasource;
  WeatherRepositoryImpl({required this.datasource});

  //------------------------
  @override
  Future<WeatherDetailsModel> getWeatherDetails(double lat, double lng, int days) =>
      datasource.getWeatherDetails(lat, lng, days);
}
