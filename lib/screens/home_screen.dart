import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../bloc/weather_bloc_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    determinePosition();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget getWeatherIco(int code) {
      switch (code) {
        case > 200 && < 300:
          return Image.asset("assets/1.png");
        case >= 300 && < 400:
          return Image.asset("assets/2.png");
        case >= 500 && < 600:
          return Image.asset("assets/3.png");
        case >= 600 && < 700:
          return Image.asset("assets/4.png");
        case >= 700 && < 800:
          return Image.asset("assets/5.png");
        case == 800:
          return Image.asset("assets/6.png");
        case > 800 && <= 804:
          return Image.asset("assets/7.png");

        default:
          return Image.asset("assets/1.png");
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xff001524),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   systemOverlayStyle:
      //       const SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
      // ),
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(
          40,
          1.2 * kToolbarHeight,
          40,
          20,
        ),
        child: BlocBuilder<WeatherBlocBloc, WeatherBlocState>(
            builder: (context, state) {
          if (state is WeatherBlocSuccess) {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📍 ${state.weather.areaName}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Good Morning",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  getWeatherIco(state.weather.weatherConditionCode!),
                  Center(
                    child: Text(
                      "${state.weather.temperature!.celsius!.round()} °C",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 55,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      state.weather.weatherMain!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: Text(
                      DateFormat("EEEE dd • ")
                          .add_jm()
                          .format(state.weather.date!),
                      // "Friday 16 • 09.41am",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      weatherWidget(
                        asset: "assets/11.png",
                        heading: "Sunrise",
                        subtitle: DateFormat()
                            .add_jm()
                            .format(state.weather.sunrise!),
                      ),
                      weatherWidget(
                        asset: "assets/12.png",
                        heading: "Sunset",
                        subtitle:
                            DateFormat().add_jm().format(state.weather.sunset!),
                      )
                    ],
                  ),
                  const Divider(
                    color: Colors.grey,
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      weatherWidget(
                        asset: "assets/13.png",
                        heading: "Temp Mac",
                        subtitle:
                            "${state.weather.tempMax!.celsius!.round()} °C",
                      ),
                      weatherWidget(
                        asset: "assets/14.png",
                        heading: "Temp Min",
                        subtitle:
                            "${state.weather.tempMin!.celsius!.round()} °C",
                      )
                    ],
                  ),
                ],
              ),
            );
          } else {
            return const Text(
              "Error",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            );
          }
        }),
      ),
    );
  }
}

Widget weatherWidget({
  required String asset,
  required String heading,
  required String subtitle,
}) {
  return Row(
    children: [
      Image.asset(
        asset,
        scale: 8,
      ),
      const SizedBox(width: 5),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      )
    ],
  );
}
