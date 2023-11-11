import 'package:flutter/material.dart';
import 'package:weather_test/data/models/weather_details_model.dart';

class RowWeatherItem extends StatelessWidget {
  final int index;
  final ListElement listElement;
  final String day;
  final Function()? onTap;
  const RowWeatherItem({super.key, required this.index, required this.listElement, required this.day, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        width: MediaQuery.sizeOf(context).width * .16,
        // decoration: BoxDecoration(color: Colors.amber),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FittedBox(child: Text(day, style: const TextStyle(fontSize: 20, color: Colors.white))),
            Image.network(
              "http://openweathermap.org/img/w/${listElement.weather?[0].icon ?? ''}.png",
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return SizedBox(
                  width: MediaQuery.sizeOf(context).height * .1,
                  child: Icon(
                    Icons.fmd_bad_rounded,
                    size: MediaQuery.sizeOf(context).height * .1,
                    color: Colors.blueAccent.shade100,
                  ),
                );
              },
            ),
            Text('${(listElement.main!.temp! / 10).toStringAsFixed(1)}°',
                style: const TextStyle(fontSize: 20, color: Colors.white)),
          ],
        ),
      ),
    );
  }
}
