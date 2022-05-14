import 'package:Nguha/games/snd/GamePage.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/firebase/is_host_bomb.dart';
import 'package:Nguha/util/firebase/upload_game_info.dart';
import 'package:Nguha/games/snd/SelectBombsPage.dart';
import 'package:Nguha/games/snd/PassiveHostPage.dart';
import 'package:Nguha/games/snd/WaitingPage.dart';
import 'package:Nguha/util/firebase/get_snd_info.dart';

class SndSettingsWidget extends StatefulWidget {
  PreferenceModel themeNotifier;
  String userCode;
  String gameCode;
  SndSettingsWidget(
      {Key? key,
      required this.themeNotifier,
      required this.gameCode,
      required this.userCode})
      : super(key: key);

  @override
  State<SndSettingsWidget> createState() => _SndSettingsWidgetState();
}

class _SndSettingsWidgetState extends State<SndSettingsWidget> {
  Color cardColor = const Color.fromARGB(255, 80, 80, 80);
  double mediumFontSize = 36.0;
  double smallFontSize = 18.0;
  late double spacing = 5.0;

  String cardsRemember = '5';
  String passcodeAttempts = '3';
  bool passcodeChanges = true;
  String bombExplosionSec = '5m';
  bool soundOn = true;
  String waitSeconds = '15s'; // game starts in

  @override
  void initState() {
    super.initState();
    getSndInfo(widget.gameCode);
  }

  @override
  Widget build(BuildContext context) {
    void _gotoGamePage() {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(
              int.parse(cardsRemember),
              passcodeChanges,
              widget.gameCode,
              (double.parse(bombExplosionSec.substring(
                      0, bombExplosionSec.length - 1)) *
                  60),
              int.parse(passcodeAttempts),
              widget.themeNotifier,
              widget.userCode,
              false),
        ),
      );
    }

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
                translate('Bomb Explosion:', widget.themeNotifier.language),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      underline: const SizedBox(),
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
                translate('Wait Screen', widget.themeNotifier.language),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                      underline: const SizedBox(),
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
                translate(
                    'Plant/Defuse Attempts:', widget.themeNotifier.language),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      underline: const SizedBox(),
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
                translate('Cards To Remember', widget.themeNotifier.language),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // use theme of widget to style dropdown background color

              Container(
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
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
                      style: const TextStyle(
                          color: Colors.white,
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
                translate('Passcode Changes', widget.themeNotifier.language),
                style: const TextStyle(
                  color: Colors.white,
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

        SizedBox(height: spacing),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                translate('Sound', widget.themeNotifier.language),
                style: const TextStyle(
                  color: Colors.white,
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

        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            style: widget.userCode == ""
                ? ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    minimumSize: const Size.fromHeight(40),
                  )
                : ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    minimumSize: const Size.fromHeight(40),
                  ),
            onPressed: () {
              if (widget.userCode != "") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SndSelectPage(code: widget.gameCode),
                  ),
                );
              }
            },
            child: Text(
              translate('Set Bombs', widget.themeNotifier.language),
              // if statement that if userCode is "" then style button as disabled
              style: widget.userCode == ""
                  ? const TextStyle(
                      color: Color.fromARGB(255, 99, 99, 99),
                      fontSize: 20,
                    )
                  : const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
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
              uploadGameInfoFuture(
                  widget.gameCode,
                  cardsRemember,
                  passcodeAttempts,
                  passcodeChanges,
                  bombExplosionSec,
                  soundOn,
                  waitSeconds);
              isHostBomb(widget.gameCode, widget.userCode).then((value) => {
                    if (waitSeconds == "0s")
                      {
                        _gotoGamePage(),
                      }
                    else if (value)
                      {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: WaitingPage(
                              // remove last character from bombExplosionSec, convert to double and muiltply by 60
                              (double.parse(bombExplosionSec.substring(
                                      0, bombExplosionSec.length - 1)) *
                                  60),
                              soundOn,
                              double.parse(cardsRemember),
                              double.parse(passcodeAttempts),
                              passcodeChanges,
                              //    remove last character from string and parse to double
                              double.parse(waitSeconds.substring(
                                  0, waitSeconds.length - 1)),
                              widget.gameCode,
                              widget.userCode,
                              widget.themeNotifier,
                            ),
                          ),
                        )
                      }
                    else
                      {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: PassiveHostPage(gameCode: widget.gameCode),
                          ),
                        )
                      }
                  });
            },
            child: Text(
              translate('Start', widget.themeNotifier.language),
              style: const TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
        )
      ]),
    );
  }
}
