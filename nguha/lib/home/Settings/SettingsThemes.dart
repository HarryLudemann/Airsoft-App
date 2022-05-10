import 'package:flutter/material.dart';
import 'package:Nguha/home/HomeWidget.dart';
import 'package:Nguha/home/HelpWidget.dart';
import 'package:Nguha/home/SettingWidget.dart';
// for SettingsHome widget
import 'package:provider/provider.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/settings/language_preference.dart';
import 'package:flutter/services.dart';
import 'package:Nguha/util/languages.dart';

// create stateless widget
class ThemePage extends StatefulWidget {
  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  double mediumFontSize = 36.0;

  @override
  Widget build(BuildContext context) {
    // List of the widget pages
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

    // theme map key is background, value is font color
    final Map<Color, Color> themeMap = {
      const Color.fromARGB(255, 34, 34, 34):
          const Color.fromARGB(255, 238, 238, 238),
      const Color.fromARGB(255, 238, 238, 238):
          const Color.fromARGB(255, 34, 34, 34)
    };

    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Consumer<PreferenceModel>(
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
                          translate('Themes', themeNotifier.language),
                          style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: themeNotifier.fontcolor),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          translate('Primary Color:', themeNotifier.language),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: themeNotifier.fontcolor),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 6,
                    children: <Widget>[
                      // loop through the list of colors
                      for (Color color in _primaryColors)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: color, // NEW
                          ),
                          onPressed: () {
                            themeNotifier.primaryColor = color;
                          },
                          child: const Text(""),
                        ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          translate('Theme:', themeNotifier.language),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: themeNotifier.fontcolor),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 6,
                    children: <Widget>[
                      // loop through the list of colors
                      for (Color color in themeMap.keys)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: color,
                          ),
                          onPressed: () {
                            themeNotifier.fontcolor = themeMap[color] as Color;
                            themeNotifier.backgroundColor = color;
                          },
                          child: const Text(""),
                        ),
                    ],
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        SizedBox(
                          height: 60,
                          child: RaisedButton(
                            color: themeNotifier.primaryColor,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              translate('Back', themeNotifier.language),
                              style: const TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
