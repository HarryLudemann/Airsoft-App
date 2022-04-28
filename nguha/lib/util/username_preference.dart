import 'package:shared_preferences/shared_preferences.dart';

class UsernamePreferences {
  static const PREF_KEY = "app_username";

  setUsername(String value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(PREF_KEY, value.toString());
  }

  getUsername() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString(PREF_KEY);
    if (username != null) {
      return username;
    }
  }
}
