import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/bloc/weather_bloc_bloc.dart';
import 'package:weather_app/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider<WeatherBlocBloc>(
        create: (context) => WeatherBlocBloc()..add(FetchWeather()),
        child: const HomeScreen(),
      ),
    );
  }
}
