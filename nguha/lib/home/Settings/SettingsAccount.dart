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
class AccountPage extends StatefulWidget {
  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
                          translate('Account', themeNotifier.language),
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
                  padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        Text(
                          translate('Display Name:', themeNotifier.language),
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: themeNotifier.fontcolor),
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
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: themeNotifier.fontcolor,
                            ),
                            focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            enabledBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                            ),
                            focusedBorder: const UnderlineInputBorder(
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
                            SystemChrome.setEnabledSystemUIOverlays(
                                []); // hide ui
                            if (value.length > 3) {
                              themeNotifier.username = value;
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text('Updated Username to $value'),
                              ));
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(
                                    'Error Username must be over 3 characters'),
                                backgroundColor: Colors.red,
                              ));
                            }
                          },
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
