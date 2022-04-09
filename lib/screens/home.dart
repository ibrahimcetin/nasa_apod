import 'package:flutter/material.dart';

import 'random_apods_screen.dart';

class Home extends StatelessWidget {
  final ValueNotifier<ThemeMode> themeMode;

  const Home({Key? key, required this.themeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: buildTitle(),
          centerTitle: true,
          leading: buildThemeModeButton(Theme.of(context).brightness),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: const RandomApodsScreen(),
      ),
    );
  }

  Text buildTitle() {
    return const Text(
      "NASA APOD",
      style: TextStyle(
        fontFamily: "Nasalization",
        color: Color.fromRGBO(219, 54, 45, 1),
      ),
    );
  }

  IconButton buildThemeModeButton(Brightness brightness) {
    return IconButton(
      icon: brightness == Brightness.light ? lightThemeIcon() : darkThemeIcon(),
      splashRadius: 24,
      onPressed: () {
        themeMode.value =
            brightness == Brightness.light ? ThemeMode.dark : ThemeMode.light;
      },
    );
  }

  Icon lightThemeIcon() {
    return const Icon(
      Icons.light_mode_outlined,
      color: Colors.black,
    );
  }

  Icon darkThemeIcon() {
    return const Icon(
      Icons.dark_mode_outlined,
      color: Colors.white,
    );
  }
}
