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
class LanguagePage extends StatefulWidget {
  @override
  State<LanguagePage> createState() => _LanguagePageState();
}

class _LanguagePageState extends State<LanguagePage> {
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

    const List<Color> _themes = [
      Color.fromARGB(255, 34, 34, 34),
      Color.fromARGB(255, 238, 238, 238),
    ];

    // themes get corresponding index in this list as index in themes list
    const List<Color> _fontcolors = [
      Color.fromARGB(255, 238, 238, 238),
      Color.fromARGB(255, 51, 51, 51),
    ];

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
                          translate('Languages', themeNotifier.language),
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
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          translate('Language:', themeNotifier.language),
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
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Theme(
                          data: Theme.of(context).copyWith(
                            backgroundColor: themeNotifier.backgroundColor,
                            canvasColor: themeNotifier.backgroundColor,
                          ),
                          child: DropdownButtonFormField<String>(
                            value: themeNotifier.language,
                            // icon: const Icon(Icons.arrow_downward),
                            iconSize: 0,
                            elevation: 16,
                            style: TextStyle(
                                color: themeNotifier.fontcolor,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.language_sharp,
                                color: themeNotifier.fontcolor,
                              ),
                              border: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                            ),
                            onChanged: (newValue) {
                              if (newValue != null) {
                                LanguagePreferences().setLanguage(newValue);
                                themeNotifier.language = newValue;
                              }
                            },
                            items: <String>[
                              'English',
                              'French',
                              'Spanish',
                              'Russian',
                              'German'
                            ].map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Container(
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
