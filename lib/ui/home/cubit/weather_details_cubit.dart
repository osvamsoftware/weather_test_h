import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_test/data/models/lat_lng.dart';
import 'package:weather_test/data/models/weather_details_model.dart';
import 'package:weather_test/domain/repository/weather_repository.dart';

part 'weather_details_state.dart';

class WeatherDetailsCubit extends Cubit<WeatherDetailsState> {
  final WeatherRepositoryBase _repositoryBase;
  final SharedPreferences sharedPreferences;
  WeatherDetailsCubit(this._repositoryBase, this.sharedPreferences) : super(WeatherDetailsInitial());

  Future<void> getWeatherInfo({LatLng? latLng}) async {
    final LatLng tempLatLng = latLng ?? await _loadCoordinates();
    emit(WeatherDetailsInitial());
    try {
      final detailsModel = await _repositoryBase.getWeatherDetails(tempLatLng.lat ?? 0, tempLatLng.lng ?? 0, 5);
      emit(state.copyWith(weatherDetailsModel: detailsModel, currentElement: detailsModel.list?[0]));
    } catch (e) {
      emit(WeatherDetailsError());
    }
  }

  void changeCurrentDay(int index) {
    emit(
      state.copyWith(
        currentElement: state.weatherDetailsModel?.list?[index] ?? ListElement(),
      ),
    );
  }

  Future<LatLng> _loadCoordinates() async {
    final savedLatitude = sharedPreferences.getDouble('latitude');
    final savedLongitude = sharedPreferences.getDouble('longitude');

    if (savedLatitude != null && savedLongitude != null) {
      return LatLng(lat: savedLatitude, lng: savedLongitude);
    } else {
      final defaultLatitude = LocationWeather.miami.getCoordinates().lat;
      final defaultLongitude = LocationWeather.miami.getCoordinates().lng;

      await sharedPreferences.setDouble('latitude', defaultLatitude ?? 0);
      await sharedPreferences.setDouble('longitude', defaultLongitude ?? 0);

      return LatLng(lat: defaultLatitude, lng: defaultLongitude);
    }
  }

  Future<void> changeCurrentLocation(LocationWeather locationWeather) async {
    final defaultLatitude = locationWeather.getCoordinates().lat;
    final defaultLongitude = locationWeather.getCoordinates().lng;

    await sharedPreferences.setDouble('latitude', defaultLatitude ?? 0);
    await sharedPreferences.setDouble('longitude', defaultLongitude ?? 0);

    await getWeatherInfo();
  }
}
