//theme_model.dart
import 'package:flutter/material.dart';
import 'package:Nguha/util/settings/theme_preference.dart';
import 'package:Nguha/util/settings/language_preference.dart';
import 'package:Nguha/util/settings/username_preference.dart';
import 'package:Nguha/util/settings/font_color_preference.dart';
import 'package:Nguha/util/settings/background_preference.dart';

class PreferenceModel extends ChangeNotifier {
  late Color _primaryColor;
  late ThemePreferences _preferences;
  Color get primaryColor => _primaryColor;

  late String _language;
  late LanguagePreferences _langPreferences;
  String get language => _language;

  late String _username;
  late UsernamePreferences _usernamePreferences;
  String get username => _username;

  late Color _fontColor;
  late FontColorPreferences _fontColorPreferences;
  Color get fontcolor => _fontColor;

  late Color _backgroundColor;
  late BackgroundPreferences _backgroundColorPreferences;
  Color get backgroundColor => _backgroundColor;

  PreferenceModel() {
    _primaryColor = Colors.green;
    _preferences = ThemePreferences();

    _language = "English";
    _langPreferences = LanguagePreferences();

    _username = "User13552";
    _usernamePreferences = UsernamePreferences();

    _fontColor = const Color.fromARGB(255, 230, 230, 230);
    _fontColorPreferences = FontColorPreferences();

    _backgroundColor = const Color.fromRGBO(32, 32, 32, 1);
    _backgroundColorPreferences = BackgroundPreferences();
    getPreferences();
  }

//Switching themes in the flutter apps - Flutterant
  set primaryColor(Color value) {
    _primaryColor = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  set language(String value) {
    _language = value;
    _langPreferences.setLanguage(value);
    notifyListeners();
  }

  set username(String value) {
    _username = value;
    _usernamePreferences.setUsername(value);
    notifyListeners();
  }

  set fontcolor(Color value) {
    _fontColor = value;
    _fontColorPreferences.setFontColor(value);
    notifyListeners();
  }

  set backgroundColor(Color value) {
    _backgroundColor = value;
    _backgroundColorPreferences.setBackground(value);
    notifyListeners();
  }

  getPreferences() async {
    // await getTheme if not null
    Color? theme = await _preferences.getTheme();
    if (theme != null) {
      _primaryColor = theme;
      notifyListeners();
    }

    String? lang = await _langPreferences.getLanguage();
    if (lang != null) {
      _language = lang;
      notifyListeners();
    }

    String? user = await _usernamePreferences.getUsername();
    if (user != null) {
      _username = user;
      notifyListeners();
    }

    Color? fontcolor = await _fontColorPreferences.getFontColor();
    if (fontcolor != null) {
      _fontColor = fontcolor;
      notifyListeners();
    }

    Color? background = await _backgroundColorPreferences.getBackground();
    if (background != null) {
      _backgroundColor = background;
      notifyListeners();
    }
  }
}
