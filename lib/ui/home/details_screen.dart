import 'package:flutter/material.dart';
import 'package:weather_test/data/models/weather_details_model.dart';

class WeatherDetailsScreen extends StatelessWidget {
  static const String path = '/details-screen';
  final ListElement listElement;

  const WeatherDetailsScreen({super.key, required this.listElement});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400), 'Detalles del Clima'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Temperatura: ${(listElement.main!.temp! / 10).toStringAsFixed(1)} °C'),
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Sensación Térmica: ${(listElement.main!.temp! / 10).toStringAsFixed(1)}  °C'),
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Presión: ${listElement.main?.pressure ?? 0} hPa'),
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Humedad: ${listElement.main?.humidity ?? 0} %'),
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Velocidad del Viento: ${listElement.wind?.speed ?? 0.0} m/s'),
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Descripción del Tiempo: ${listElement.weather?.first.description ?? "Descripción no disponible"}'),
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Nubosidad: ${listElement.clouds?.all ?? 0} %'),
            const SizedBox(
              height: 30,
            ),
            Text(
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                'Visibilidad: ${listElement.visibility ?? 0} m'),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
