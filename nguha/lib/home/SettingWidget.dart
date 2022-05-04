import 'package:Nguha/util/settings/language_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/home/Settings/SettingsAccount.dart';
import 'package:Nguha/home/Settings/SettingsThemes.dart';
import 'package:Nguha/home/Settings/SettingsLanguage.dart';

// data class of settings contains name, icon and widget
class SettingsData {
  String name;
  IconData icon;
  Widget widget;

  SettingsData(this.name, this.icon, this.widget);
}

// list of setting options
final List<SettingsData> _settings = [
  SettingsData(
    'Account',
    Icons.account_circle,
    AccountPage(),
  ),
  SettingsData(
    'Themes',
    Icons.color_lens,
    ThemePage(),
  ),
  SettingsData(
    'Languages',
    Icons.language,
    LanguagePage(),
  ),
];

Widget SettingWidget(context) {
  // Possible Theme Colors
  const List<Color> _primaryColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
  ];

  const List<Color> _themes = [
    Color.fromARGB(255, 34, 34, 34),
    Color.fromARGB(255, 238, 238, 238),
  ];

  // themes get corresponding index in this list as index in themes list
  const List<Color> _fontcolors = [
    Color.fromARGB(255, 238, 238, 238),
    Color.fromARGB(255, 51, 51, 51),
  ];

  return Consumer<PreferenceModel>(
    builder: (context, PreferenceModel themeNotifier, child) {
      return CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    translate('Settings', themeNotifier.language),
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: themeNotifier.fontcolor),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  leading: Icon(
                    _settings[index].icon,
                    color: themeNotifier.fontcolor,
                  ),
                  title: Text(
                    _settings[index].name,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: themeNotifier.fontcolor),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => _settings[index].widget,
                      ),
                    );
                  },
                );
              },
              childCount: _settings.length, // 1000 list items
            ),
          ),
        ],
      );
    },
  );
}
