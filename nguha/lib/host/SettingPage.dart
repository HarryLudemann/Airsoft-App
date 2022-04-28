import 'dart:math';

import 'package:flutter/material.dart';
import '../games/snd/GamePage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Nguha/util/languages.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/preference_model.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  Color backgroundColor = const Color.fromARGB(255, 32, 32, 32);
  // Color backgroundColor = Color.fromARGB(255, 80, 80, 80);
  Color cardColor = const Color.fromARGB(255, 80, 80, 80);
  // Color cardColor = Color.fromARGB(255, 138, 138, 138);
  Color whiteColor = const Color.fromARGB(255, 255, 255, 255);
  double mediumFontSize = 36.0;
  double smallFontSize = 18.0;

  late double spacing = 5.0;
  String selected_game = 'Search n Destroy';
  String cardsRemember = '5';
  String passcodeAttempts = '3';
  bool passcodeChanges = true;
  String bombExplosionSec = '5m';
  bool soundOn = true;
  String waitSeconds = '15s'; // game starts in
  String gameCode = "";

  String gameStatePath = "";
  DatabaseReference databaseref = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    _getRandomCode().then((code) {
      setState(() {
        gameCode = code;
      });
    });
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  String secondsToMinutes(double seconds) {
    int sec = seconds.toInt();
    // if seconds is less then 60 return seconds
    if (seconds < 60) {
      return seconds.toStringAsFixed(0) + 's';
    } else {
      int min = sec ~/ 60;
      sec = sec % 60;
      // if sec if less then 10 add 0 to front
      if (sec < 10) {
        return "$min:0$sec";
      } else {
        return "$min:$sec";
      }
    }
  }

  Future<String> _getRandomCode() async {
    // gets unique 6 digit code
    String digits = "";
    for (int i = 0; i < 6; i++) {
      digits += Random().nextInt(10).toString();
    }
    databaseref = FirebaseDatabase.instance.ref("games/" + digits);
    final event = await databaseref.once(DatabaseEventType.value);
    if (event.snapshot.value == null) {
      return digits;
    } else {
      return _getRandomCode();
    }
  }

  Widget SndSettings(themeNotifier) {
    return Container(
      child: Column(children: <Widget>[
        // SizedBox(height: spacing),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              // color: Color.fromARGB(255, 132, 132, 132),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translate('Bomb Explosion:', themeNotifier.language),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),

                  // dropdown below..
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Theme.of(context).primaryColor,
                    ),
                    child: DropdownButton<String>(
                      value: bombExplosionSec,
                      iconSize: 0,
                      elevation: 16,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          bombExplosionSec = newValue!;
                        });
                      },
                      items: <String>[
                        '5m',
                        '10m',
                        '15m',
                        '20m',
                        '25m',
                        '30m',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
            ],
          ),
        ),

        SizedBox(height: spacing),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              // color: Color.fromARGB(255, 132, 132, 132),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translate('Wait Screen', themeNotifier.language),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),

                  // dropdown below..
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Theme.of(context).primaryColor,
                    ),
                    child: DropdownButton<String>(
                      value: waitSeconds,
                      iconSize: 0,
                      elevation: 16,
                      style: TextStyle(
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          waitSeconds = newValue!;
                        });
                      },
                      items: <String>['0s', '15s', '30s', '45s', '60s']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
            ],
          ),
        ),

        SizedBox(height: spacing),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              // color: Color.fromARGB(255, 132, 132, 132),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translate('Plant/Defuse Attempts:', themeNotifier.language),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),

                  // dropdown below..
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Theme.of(context).primaryColor,
                    ),
                    child: DropdownButton<String>(
                      value: passcodeAttempts,
                      iconSize: 0,
                      elevation: 16,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      underline: SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          passcodeAttempts = newValue!;
                        });
                      },
                      items: <String>[
                        '1',
                        '2',
                        '3',
                        '4',
                        '5',
                        '6',
                        '7',
                        '8',
                        '9',
                        '10'
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
            ],
          ),
        ),

        SizedBox(height: spacing),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          // padding: const EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
              // color: Color.fromARGB(255, 132, 132, 132),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translate('Cards To Remember', themeNotifier.language),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5)),

                  // dropdown below..
                  child: Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Theme.of(context).primaryColor,
                    ),
                    child: DropdownButton<String>(
                      value: cardsRemember,
                      iconSize: 0,
                      elevation: 16,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      underline: const SizedBox(),
                      onChanged: (String? newValue) {
                        setState(() {
                          cardsRemember = newValue!;
                        });
                      },
                      items: <String>['5', '6', '7', '8', '9', '10', '11', '12']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  )),
            ],
          ),
        ),

        SizedBox(height: spacing),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translate('Passcode Changes', themeNotifier.language),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                activeColor: Theme.of(context).primaryColor,
                value: passcodeChanges,
                onChanged: (bool newValue) {
                  setState(() {
                    passcodeChanges = newValue;
                  });
                },
              ),
            ],
          ),
        ),

        // SizedBox(height: spacing),
        // Text(
        //   'Sound:',
        //   style: TextStyle(
        //     color: whiteColor,
        //     fontSize: 20,
        //     fontWeight: FontWeight.bold,
        //   ),
        // ),

        SizedBox(height: spacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translate('Sound', themeNotifier.language),
                style: TextStyle(
                  color: whiteColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Switch(
                activeColor: Theme.of(context).primaryColor,
                value: soundOn,
                onChanged: (bool newValue) {
                  setState(() {
                    soundOn = newValue;
                  });
                },
              ),
            ],
          ),
        ),

        Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              minimumSize: const Size.fromHeight(40),
            ),
            onPressed: () {},
            child: Text(
              translate('Set Teams/Bombs', themeNotifier.language),
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        ),

        Container(
          margin: const EdgeInsets.only(top: 10),
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              minimumSize: const Size.fromHeight(80),
            ),
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: Variables(
                      // remove last character from bombExplosionSec, convert to double and muiltply by 60
                      (double.parse(bombExplosionSec.substring(
                              0, bombExplosionSec.length - 1)) *
                          60),
                      soundOn,
                      double.parse(cardsRemember),
                      double.parse(passcodeAttempts),
                      passcodeChanges,
                      //    remove last character from string and parse to double
                      double.parse(
                          waitSeconds.substring(0, waitSeconds.length - 1)),
                      gameCode),
                ),
              );
            },
            child: Text(
              translate('Start', themeNotifier.language),
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        )
      ]),
    );
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
                fontWeight: FontWeight.bold, fontSize: 48, color: whiteColor),
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
                    color: whiteColor,
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
                      color: whiteColor, size: 40,
                      // add padding to left
                    ),
                    elevation: 0,
                    style: TextStyle(
                      color: whiteColor,
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
                                          : whiteColor)));
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                margin: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 43, 43, 43),
                    borderRadius: BorderRadius.circular(5)),
                child: SndSettings(themeNotifier))
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
