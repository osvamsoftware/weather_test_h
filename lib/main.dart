import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_test/data/datasource/weather_datasource.dart';
import 'package:weather_test/domain/repository/weather_repository.dart';
import 'package:weather_test/ui/home/cubit/weather_details_cubit.dart';
import 'package:weather_test/ui/router/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider(
      create: (context) => WeatherRepositoryImpl(datasource: WeatherDatasourceImpl()),
    ),
    RepositoryProvider<SharedPreferences>(
      create: (context) => sharedPreferences,
    ),
  ], child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //! when have a lot of providers, can make a ProviderManager class.
    return BlocProvider(
      create: (context) => WeatherDetailsCubit(context.read<WeatherRepositoryImpl>(), context.read<SharedPreferences>())
        ..getWeatherInfo(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: RouterProvider.router,
      ),
    );
  }
}
