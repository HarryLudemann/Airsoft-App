import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class BackgroundPreferences {
  static const PREF_KEY = "app_background_color";

  // function to convert a color

  setBackground(Color value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value.value.toString());
  }

  getBackground() async {
    // setBackground(Color.fromRGBO(32, 32, 32, 1));
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? theme = sharedPreferences.getString(PREF_KEY);
    if (theme != null) {
      return Color.fromRGBO(32, 32, 32, 1);
      return Color(int.parse(theme));
    }
  }
}
