import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_test/core/constants/paths.dart';
import 'package:weather_test/ui/home/cubit/weather_details_cubit.dart';
import 'package:weather_test/ui/home/details_screen.dart';
import 'package:weather_test/ui/home/settings_screen.dart';
import 'package:weather_test/ui/home/widgets/row_weather_item.dart';

class HomeScreen extends StatelessWidget {
  static const path = '/home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amber,
      body: SafeArea(
        child: Stack(
          children: [
            buildBackground(),
            BlocBuilder<WeatherDetailsCubit, WeatherDetailsState>(
              builder: (context, state) {
                if (state.weatherDetailsModel == null) {
                  return Center(
                    child: CircularProgressIndicator.adaptive(backgroundColor: Colors.blue.shade200),
                  );
                } else {
                  return Column(
                    children: [
                      _buildHeadFunctions(context),
                      _buildTempNumber(state),
                      _buildTempIcon(context, state),
                      _buildSmallInfoWH(state),
                      const Spacer(),
                      _buildCurrentLocation(state, context),
                      const SizedBox(height: 30),
                      _buildTempDaysRow(context, state)
                    ],
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  _buildTempDaysRow(BuildContext context, WeatherDetailsState state) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .2,
      width: double.infinity,
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.white.withOpacity(0.2),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(5, (index) {
                  final daysList = getDays();
                  return RowWeatherItem(
                    onTap: () => context.read<WeatherDetailsCubit>().changeCurrentDay(index),
                    listElement: (state.weatherDetailsModel!.list![index]),
                    index: index,
                    day: daysList[index],
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }

  _buildCurrentLocation(WeatherDetailsState state, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          state.weatherDetailsModel?.city?.name ?? '',
          style: const TextStyle(fontSize: 30, color: Colors.white, fontWeight: FontWeight.w300),
        ),
        CustomRoundedButton(
          color: Colors.white.withOpacity(.2),
          text: 'Ver detalles.. ',
          onTap: () => context.push(WeatherDetailsScreen.path, extra: state.currentElement),
        )
      ],
    );
  }

  _buildSmallInfoWH(WeatherDetailsState state) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'W: ${state.currentElement?.wind?.speed ?? 0}',
          style: const TextStyle(fontSize: 30, color: Colors.white),
        ),
        const SizedBox(width: 10),
        Text('H: ${state.currentElement?.main?.humidity ?? 0}',
            style: const TextStyle(fontSize: 30, color: Colors.white)),
      ],
    );
  }

  _buildTempIcon(BuildContext context, WeatherDetailsState state) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * .15,
      width: MediaQuery.sizeOf(context).height * .15,
      child: Image.network(
        "http://openweathermap.org/img/w/${state.currentElement!.weather![0].icon!}.png",
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
    );
  }

  _buildTempNumber(WeatherDetailsState state) {
    return Center(
      child: Text(
        '${(state.currentElement!.main!.temp! / 10).toStringAsFixed(1)}°',
        style: const TextStyle(fontSize: 130, fontWeight: FontWeight.w200, color: Colors.white),
      ),
    );
  }

  _buildHeadFunctions(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              context.push(SettingsScreen.path);
            },
            child: SvgPicture.asset(
              paths.settingsIconSvg,
              height: 30,
              color: Colors.blue.shade200,
            ),
          ),
        )
      ],
    );
  }
}

buildBackground() {
  return Expanded(
    child: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF090E32), Color.fromARGB(255, 121, 135, 239)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    ),
  );
}

List<String> getDays() {
  final today = DateTime.now();
  const daysAhead = 5;

  List<String> dayNames = [getDayName(today)];

  for (int i = 1; i <= daysAhead; i++) {
    final nextDay = today.add(Duration(days: i));
    dayNames.add(getDayName(nextDay));
  }

  return dayNames;
}

String getDayName(DateTime date) {
  final dayNames = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
  return dayNames[date.weekday - 1];
}
