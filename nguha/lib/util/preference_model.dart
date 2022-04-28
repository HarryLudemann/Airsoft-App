//theme_model.dart
import 'package:flutter/material.dart';
import 'package:Nguha/util/theme_preference.dart';
import 'package:Nguha/util/language_preference.dart';
import 'package:Nguha/util/username_preference.dart';

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

  PreferenceModel() {
    _primaryColor = Colors.green;
    _preferences = ThemePreferences();

    _language = "English";
    _langPreferences = LanguagePreferences();

    _username = "User13552";
    _usernamePreferences = UsernamePreferences();
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
  }
}
