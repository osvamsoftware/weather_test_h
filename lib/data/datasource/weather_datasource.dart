import 'package:weather_test/core/constants/url_constants.dart';
import 'package:weather_test/data/models/weather_details_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherDatasourceBase {
  Future<WeatherDetailsModel> getWeatherDetails(double lat, double lng, int days);
}

class WeatherDatasourceImpl extends WeatherDatasourceBase {
  @override
  Future<WeatherDetailsModel> getWeatherDetails(double lat, double lng, int days) async {
    //! this informatiopn can be provide by .ENV, but to keep the single test, put here the info
    const apiKey = 'fcfba3d50196bd708bf668f7cec2b527';
    try {
      final uri = Uri.parse('${urlConstants.baseUrl}/forecast?lat=$lat&lon=$lng&cnt=$days&APPID=$apiKey');
      final response = await http.get(uri);
      final detailsModel = WeatherDetailsModel.fromJson(response.body);
      return detailsModel;
    } on Exception catch (_) {
      throw Exception('Hubo un problema, por favor intente más tarde.');
    }
  }
}
