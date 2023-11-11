import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test/ui/home/cubit/weather_details_cubit.dart';
import 'package:weather_test/ui/home/home_screen.dart';

class SettingsScreen extends StatelessWidget {
  static const path = '/settings-screen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          buildBackground(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomRoundedButton(
                  text: 'Miami',
                  color: Colors.blue.shade200.withOpacity(.2),
                  onTap: () {
                    context.read<WeatherDetailsCubit>().changeCurrentLocation(LocationWeather.miami);
                    context.pop();
                  },
                ),
                const SizedBox(height: 30),
                CustomRoundedButton(
                  text: 'Buenos Aires',
                  color: Colors.green.shade200.withOpacity(.2),
                  onTap: () {
                    context.read<WeatherDetailsCubit>().changeCurrentLocation(LocationWeather.buenosAires);
                    context.pop();
                  },
                ),
                const SizedBox(height: 30),
                CustomRoundedButton(
                  text: 'París',
                  color: Colors.red.shade200.withOpacity(.2),
                  onTap: () {
                    context.read<WeatherDetailsCubit>().changeCurrentLocation(LocationWeather.paris);
                    context.pop();
                  },
                ),
              ],
            ),
          ),
        ],
      )),
    );
  }
}

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Function()? onTap;

  const CustomRoundedButton({super.key, required this.text, required this.color, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
