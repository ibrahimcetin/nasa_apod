import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'nasa_apod_theme.dart';
import 'screens/home.dart';

void main() => runApp(const NasaApod());

class NasaApod extends StatefulWidget {
  const NasaApod({Key? key}) : super(key: key);

  @override
  State<NasaApod> createState() => _NasaApodState();
}

class _NasaApodState extends State<NasaApod> {
  ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.system);

  bool didGetTheme = false;

  @override
  void initState() {
    final prefs = SharedPreferences.getInstance();
    prefs.then((prefs) {
      final savedMode = prefs.getInt('themeMode');

      if (savedMode != null) {
        themeMode.value = ThemeMode.values.elementAt(savedMode);
      }

      didGetTheme = true;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: themeMode,
      builder: (context, value, child) {
        if (didGetTheme) {
          final prefs = SharedPreferences.getInstance();
          prefs.then((prefs) {
            prefs.setInt('themeMode', themeMode.value.index);
          });
        }

        return MaterialApp(
          title: 'Nasa APOD',
          theme: NasaApodThemeData.light(),
          darkTheme: NasaApodThemeData.dark(),
          themeMode: themeMode.value,
          home: Home(themeMode: themeMode),
        );
      },
    );
  }
}
