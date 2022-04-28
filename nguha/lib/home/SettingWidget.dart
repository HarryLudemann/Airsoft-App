import 'package:Nguha/util/language_preference.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/preference_model.dart';
import 'package:Nguha/util/languages.dart';

Widget SettingWidget(context) {
  // Possible Theme Colors
  const List<Color> _colors = [
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
                    style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    translate('Display Name:', themeNotifier.language),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          // text field input for display name
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  TextFormField(
                    initialValue: themeNotifier.username,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    onChanged: (value) {
                      // if value over 3 characters, set
                      if (value.length > 3) {
                        themeNotifier.username = value;
                      }
                    },
                    onFieldSubmitted: (value) {
                      SystemChrome.setEnabledSystemUIOverlays([]); // hide ui
                      if (value.length > 3) {
                        themeNotifier.username = value;
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('Updated Username to $value'),
                        ));
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content:
                              Text('Error Username must be over 3 characters'),
                          backgroundColor: Colors.red,
                        ));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),

          // set language
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    translate('Language:', themeNotifier.language),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                      backgroundColor: const Color.fromARGB(255, 32, 32, 32),
                      canvasColor: const Color.fromARGB(255, 32, 32, 32),
                    ),
                    child: DropdownButtonFormField<String>(
                      value: themeNotifier.language,
                      // icon: const Icon(Icons.arrow_downward),
                      iconSize: 0,
                      elevation: 16,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      decoration: const InputDecoration(
                        icon: Icon(
                          Icons.language_sharp,
                          color: Colors.white,
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                        ),
                      ),
                      onChanged: (newValue) {
                        if (newValue != null) {
                          LanguagePreferences().setLanguage(newValue);
                          themeNotifier.language = newValue;
                        }
                      },
                      items: <String>['English', 'French', 'Spanish']
                          .map<DropdownMenuItem<String>>((String value) {
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
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    translate('Primary Color:', themeNotifier.language),
                    style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                for (Color color in _colors)
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
        ],
      );
    },
  );
}
