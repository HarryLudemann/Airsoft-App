import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/games/snd/GamePage.dart';
import 'package:Nguha/util/firebase/add_user.dart';
import 'package:Nguha/util/firebase/remove_user.dart';
import 'package:Nguha/util/firebase/listener.dart';
import 'package:Nguha/util/sound.dart';

class JoinedPage extends StatefulWidget {
  String code = "";
  bool sound = true;
  String name = "";
  JoinedPage(
      {required Key key,
      required String code,
      bool? sound,
      required String name})
      : super(key: key) {
    if (sound != null) {
      this.sound = sound;
    }
    this.code = code;
    this.name = name;
  }
  @override
  State<JoinedPage> createState() => _JoinedPageState();
}

class _JoinedPageState extends State<JoinedPage> {
  StreamSubscription? _onGameStateChanged;
  StreamSubscription? _onInfoChanged;
  String userCode = "";
  String game_state = "";
  bool muted = false;

  @override
  void initState() {
    super.initState();
    addUser(widget.name, widget.code);
    _activateListeners();
  }

  @override
  void deactivate() {
    _deactivateListeners();
    removeUser(widget.code, userCode);
    super.deactivate();
  }

  void _deactivateListeners() {
    super.deactivate();
    if (_onGameStateChanged != null) {
      _onGameStateChanged!.cancel();
      _onGameStateChanged = null;
    }
    if (_onInfoChanged != null) {
      _onInfoChanged!.cancel();
      _onInfoChanged = null;
    }
  }

  void _activateListeners() {
    DatabaseListener gameStateListener =
        DatabaseListener("games/" + widget.code + "/game_state");

    DatabaseListener startGameListener =
        DatabaseListener("games/" + widget.code + "/info/startGame");

    _onGameStateChanged = gameStateListener.listenString((String event) {
      setState(() {
        this.game_state = event as String;
      });
    });

    _onInfoChanged = startGameListener.listenBool((bool event) {
      // if event.snapshot.value == true get info and pass to gamepage
      if (event == true) {
        // get user team from firebase
        // databaseref = FirebaseDatabase.instance
        //     .ref("games/" + widget.code + "/users/" + userCode + "/team");
        // if team is #1 Bomb or #2 Bomb or #3 Bomb
        DatabaseListener(
                "games/" + widget.code + "/users/" + userCode + "/team")
            .getOnceString()
            .then((String team) {
          if (team == "#1 Bomb" || team == "#2 Bomb") {
            double bombExplosionSec = 360.0;
            double cardsRemember = 5.0;
            double passcodeAttempts = 10.0;
            bool passcodeChanges = true;
            bool soundOn = true;
            double waitSeconds = 0.0;

            int varsReceived = 0;

            void _incrementVars() {
              varsReceived++;
              if (varsReceived != 6) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Variables(
                    bombExplosionSec,
                    soundOn,
                    cardsRemember,
                    passcodeAttempts,
                    passcodeChanges,
                    waitSeconds,
                    widget.code,
                    userCode,
                  ),
                ),
              );
            }

            // set values from firebase info
            DatabaseListener("games/" + widget.code + "/info/bombExplosionSec")
                .getOnceString()
                .then((String _bombExplosionSec) {
              bombExplosionSec = double.parse(_bombExplosionSec);
              _incrementVars();
            });

            DatabaseListener("games/" + widget.code + "/info/cardsRemember")
                .getOnceString()
                .then((String _cardsRemember) {
              cardsRemember = double.parse(_cardsRemember);
              _incrementVars();
            });

            DatabaseListener("games/" + widget.code + "/info/passcodeAttempts")
                .getOnceString()
                .then((String _passcodeAttempts) {
              passcodeAttempts = double.parse(_passcodeAttempts);
              _incrementVars();
            });

            DatabaseListener("games/" + widget.code + "/info/passcodeChanges")
                .getOnceBool()
                .then((bool _passcodeChanges) {
              passcodeChanges = _passcodeChanges;
              _incrementVars();
            });

            DatabaseListener("games/" + widget.code + "/info/soundOn")
                .getOnceBool()
                .then((bool _soundOn) {
              soundOn = _soundOn;
              _incrementVars();
            });

            DatabaseListener("games/" + widget.code + "/info/waitSeconds")
                .getOnceString()
                .then((String _waitSeconds) {
              waitSeconds = double.parse(_waitSeconds);
              _incrementVars();
            });
          }
        });
      }
    });
  }

  void _PlayMusic(String music) {
    if (!widget.sound) return;
    PlayMusic(music + '.mp3');
  }

  // function given gamestate or sound return text
  String getTextPlaySound(String gameState) {
    if (gameState == "10") {
      _PlayMusic('10second');
      return "10 seconds";
    } else if (gameState == "0") {
      return "Waiting";
    } else if (gameState == "1") {
      _PlayMusic('1');
      return "1";
    } else if (gameState == "2") {
      _PlayMusic('2');
      return "2";
    } else if (gameState == "3") {
      _PlayMusic('3');
      return "3";
    } else if (gameState == "go") {
      _PlayMusic('go');
      return "GO!";
    } else if (gameState == "30") {
      _PlayMusic('30second');
      return "30 seconds";
    } else if (gameState == "45") {
      _PlayMusic('45second');
      return "45 seconds";
    } else if (gameState == "60") {
      _PlayMusic('1minute');
      return "1 minute";
    } else if (gameState == "120") {
      _PlayMusic('2minute');
      return "2 minutes";
    } else if (gameState == "300") {
      _PlayMusic('5minute');
      return "5 minutes";
    } else if (gameState == "600") {
      _PlayMusic('10minute');
      return "10 minutes";
    } else if (gameState == "900") {
      _PlayMusic('15minute');
      return "15 minutes";
    } else if (gameState == "1001") {
      _PlayMusic('BombDefused');
      return "Bomb Defused";
    } else if (gameState == "1002") {
      _PlayMusic('BombPlanted');
      return "Bomb Planted";
    } else if (gameState == "1003") {
      _PlayMusic('explosion');
      return "Explosion";
    } else if (gameState == "1006") {
      return "Game Starting";
    } else {
      return "Waiting";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceModel>(
        builder: (context, PreferenceModel themeNotifier, child) {
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
            children: [
              const Spacer(),
              Center(
                child: Text(
                    translate(
                        getTextPlaySound(game_state), themeNotifier.language),
                    style: TextStyle(
                        fontSize: 32, color: themeNotifier.fontcolor)),
              ),
              const Spacer(),
              IconButton(
                iconSize: 48,
                color: themeNotifier.fontcolor,
                icon: muted
                    ? const Icon(Icons.volume_off)
                    : const Icon(Icons.volume_up),
                onPressed: () {
                  setState(() {
                    if (muted) {
                      muted = false;
                    } else {
                      muted = true;
                    }
                  });
                },
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 60, 60, 60),
                    minimumSize: const Size.fromHeight(80),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          content: Text(
                            translate(
                                'Are you sure you want to quit this game?',
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
                  child: const Text(
                    'Back',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
              ),
            ],
          ));
    });
  }
}
