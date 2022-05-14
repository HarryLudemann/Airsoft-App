import 'package:Nguha/games/snd/SettingWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/firebase/add_user.dart';
import 'package:Nguha/util/firebase/random_game_code.dart';
import 'package:Nguha/util/firebase/delete_game.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/firebase/is_host_bomb.dart';
import 'package:Nguha/util/firebase/upload_game_info.dart';
import 'package:Nguha/games/snd/SelectBombsPage.dart';
import 'package:Nguha/games/snd/PassiveHostPage.dart';
import 'package:Nguha/games/snd/WaitingPage.dart';

import '../games/snd/GamePage.dart';

class SettingPage extends StatefulWidget {
  String name = "";
  PreferenceModel themeNotifier;
  SettingPage(
      {Key? key, required String givenName, required this.themeNotifier})
      : super(key: key) {
    name = givenName;
  }

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  String userCode = "";

  Color cardColor = const Color.fromARGB(255, 80, 80, 80);
  double mediumFontSize = 36.0;
  double smallFontSize = 18.0;

  late double spacing = 5.0;
  String selected_game = 'Search n Destroy';
  String gameCode = "";

  // snd settings
  bool _isHostBomb = true;
  String cardsRemember = '5';
  String passcodeAttempts = '3';
  bool passcodeChanges = true;
  String bombExplosionSec = '5m';
  bool soundOn = true;
  String waitSeconds = '15s'; // game starts in

  @override
  void initState() {
    super.initState();
    // get random game code then add user
    getRandomGameCode().then((code) {
      addUser(widget.name, code).then((code) {
        setState(() {
          userCode = code;
        });
      });
      setState(() {
        gameCode = code;
      });
    });
  }

  // deactivate method deletes widget.code from firebase
  @override
  void deactivate() {
    super.deactivate();
    deleteGame(gameCode);
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceModel>(
        builder: (context, PreferenceModel themeNotifier, child) {
      return Column(
        children: <Widget>[
          const Spacer(),
          SizedBox(
            height: spacing,
          ),
          // centered text with game code
          Text(
            gameCode,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 48,
                color: themeNotifier.fontcolor),
          ),
          const SizedBox(
            height: 0,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Game:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: themeNotifier.fontcolor,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  // add padding to left right
                  padding: const EdgeInsets.only(left: 20, right: 0),
                  child: DropdownButton<String>(
                    value: selected_game,
                    dropdownColor: cardColor,
                    //remove icon
                    icon: Icon(
                      Icons.arrow_drop_down_rounded,
                      color: themeNotifier.fontcolor, size: 40,
                      // add padding to left
                    ),
                    elevation: 0,
                    style: TextStyle(
                      color: themeNotifier.fontcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    underline: Container(
                      height: 0,
                    ),
                    onChanged: (String? newValue) {
                      // if last 13 characters equal (Coming Soon) dont select
                      if (newValue?.substring(newValue.length - 13) ==
                          '(Coming Soon)') {
                        return;
                      }
                      setState(() {
                        selected_game = newValue!;
                      });
                    },
                    items: <String>[
                      'Search n Destroy',
                      'Domination (Coming Soon)'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value,
                              style: TextStyle(
                                  color: // if last 13 char are (Coming Soon)
                                      value.substring(value.length - 13) ==
                                              '(Coming Soon)'
                                          ? Colors.grey
                                          : themeNotifier.fontcolor)));
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: spacing,
          ),
          // create simple expansion panel

          if (selected_game == 'Search n Destroy')
            Container(
              // 10 padding each side
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 43, 43, 43),
                  borderRadius: BorderRadius.circular(5)),
              child: SndSettingsWidget(
                themeNotifier: themeNotifier,
                userCode: userCode,
                gameCode: gameCode,
              ),
            )
          else if (selected_game == 'Domination')
            const Text("Domination"),

          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 60, 60, 60),
                minimumSize: const Size.fromHeight(80),
              ),
              onPressed: () {
                // show alert to confirm quitting
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Text(
                        translate('Are you sure you want to quit this game?',
                            themeNotifier.language),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      actions: <Widget>[
                        FlatButton(
                          child: Text(
                            translate('No', themeNotifier.language),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        FlatButton(
                          child: Text(
                            translate('Yes', themeNotifier.language),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                translate('Back', themeNotifier.language),
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ),
          ),

          const Spacer(),
        ],
      );
    });
  }
}
