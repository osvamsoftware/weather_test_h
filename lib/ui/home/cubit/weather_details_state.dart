part of 'weather_details_cubit.dart';

enum LocationWeather {
  miami,
  buenosAires,
  paris;

//! Quedamos en Poner las coordenadas de cada location y después tenemos que crear la pantallita con botones
//!pa mandar la location
  LatLng getCoordinates() {
    switch (this) {
      case LocationWeather.miami:
        return LatLng(lat: 25.783333333333, lng: -80.216666666667);
      case LocationWeather.buenosAires:
        return LatLng(lat: -34.61315, lng: -58.37723);
      case LocationWeather.paris:
        return LatLng(lat: 48.85341, lng: 2.3488);
    }
  }
}

sealed class WeatherDetailsState {
  final WeatherDetailsModel? weatherDetailsModel;
  final ListElement? currentElement;

  WeatherDetailsState({this.weatherDetailsModel, this.currentElement});

  WeatherDetailsState copyWith({
    WeatherDetailsModel? weatherDetailsModel,
    ListElement? currentElement,
  });
}

final class WeatherDetailsInitial extends WeatherDetailsState {
  WeatherDetailsInitial({super.weatherDetailsModel, super.currentElement});

  @override
  WeatherDetailsInitial copyWith({
    WeatherDetailsModel? weatherDetailsModel,
    ListElement? currentElement,
  }) {
    return WeatherDetailsInitial(
      weatherDetailsModel: weatherDetailsModel ?? this.weatherDetailsModel,
      currentElement: currentElement ?? this.currentElement,
    );
  }
}

final class WeatherDetailsError extends WeatherDetailsState {
  WeatherDetailsError({super.weatherDetailsModel, super.currentElement});

  @override
  WeatherDetailsError copyWith({
    WeatherDetailsModel? weatherDetailsModel,
    ListElement? currentElement,
  }) {
    return WeatherDetailsError(
      weatherDetailsModel: weatherDetailsModel ?? this.weatherDetailsModel,
      currentElement: currentElement ?? this.currentElement,
    );
  }
}
