import 'package:shared_preferences/shared_preferences.dart';

class LanguagePreferences {
  static const PREF_KEY = "app_language";

  setLanguage(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(PREF_KEY, value);
  }

  getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? language = sharedPreferences.getString(PREF_KEY);
    if (language != null) {
      return language;
    }
  }
}
