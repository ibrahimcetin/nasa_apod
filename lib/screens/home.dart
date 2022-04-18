import 'package:flutter/material.dart';

import '../constants.dart';
import 'random_apods_screen.dart';

class Home extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeMode;

  const Home({Key? key, required this.themeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: buildTitle(),
        leading: buildThemeModeButton(Theme.of(context).brightness),
      ),
      body: const RandomApodsScreen(),
    );
  }

  Text buildTitle() {
    return const Text(
      "NASA APOD",
      style: TextStyle(fontFamily: "Nasalization", color: kNasaLogoColor),
    );
  }

  IconButton buildThemeModeButton(Brightness brightness) {
    final IconData icon = brightness == Brightness.light
        ? Icons.light_mode_outlined
        : Icons.dark_mode_outlined;

    return IconButton(
      icon: Icon(icon),
      splashRadius: 24,
      onPressed: () {
        themeMode.value =
            brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light;
      },
    );
  }
}
