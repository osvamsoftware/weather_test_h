import 'package:go_router/go_router.dart';
import 'package:weather_test/data/models/weather_details_model.dart';
import 'package:weather_test/ui/home/details_screen.dart';
import 'package:weather_test/ui/home/settings_screen.dart';
import 'package:weather_test/ui/home/home_screen.dart';

class RouterProvider {
  static final router = GoRouter(
    initialLocation: HomeScreen.path,
    routes: [
      GoRoute(
        path: HomeScreen.path,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: SettingsScreen.path,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: WeatherDetailsScreen.path,
        builder: (context, state) {
          final weatherDetails = state.extra as ListElement;
          return WeatherDetailsScreen(
            listElement: weatherDetails,
          );
        },
      ),
    ],
  );
}
