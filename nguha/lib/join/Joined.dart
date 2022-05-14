import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/games/snd/WaitingPage.dart';
import 'package:Nguha/util/firebase/add_user.dart';
import 'package:Nguha/util/firebase/remove_user.dart';
import 'package:Nguha/util/firebase/listener.dart';
import 'package:Nguha/util/gamestate.dart';

import '../util/firebase/get_snd_info.dart';

class User {
  int id;
  String name;
  String team;
  User(this.id, this.name, this.team);
}

class JoinedPage extends StatefulWidget {
  String code = "";
  bool sound = true;
  String name = "";
  PreferenceModel themeNotifier;
  JoinedPage(
      {required Key key,
      required String code,
      required this.themeNotifier,
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
  int game_state = 0;
  bool muted = false;

  List<User> redTeam = [
    User(0, "User23525", "Red"),
    User(0, "User23525", "Red"),
  ];

  List<User> blueTeam = [
    User(0, "Hazzah", "Blue"),
    User(0, "Hazzah", "Blue"),
  ];

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

  void _addUserToTeam(User user, String teamName) {
    if (teamName == "Red") {
      redTeam.add(user);
    } else if (teamName == "Blue") {
      blueTeam.add(user);
    }
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
      //if event not null
      if (event != "null") {
        setState(() {
          game_state = int.parse(event);
        });
      }
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
                  builder: (context) => WaitingPage(
                      bombExplosionSec,
                      soundOn,
                      cardsRemember,
                      passcodeAttempts,
                      passcodeChanges,
                      waitSeconds,
                      widget.code,
                      userCode,
                      widget.themeNotifier),
                ),
              );
            }

            DatabaseListener("games/" + widget.code + "/info/bombExplosionSec")
                .getOnceString()
                .then((String _bombExplosionSec) {
              bombExplosionSec = double.parse(_bombExplosionSec);
              _incrementVars();
            });

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

  Widget _userListTile(String name, String team) {
    // Inline list tile
    return Container(
      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
      height: 60,
      child: Card(
        color: team == "Blue" ? Colors.blue : Colors.red,
        elevation: 2,
        shape: RoundedRectangleBorder(
            side: BorderSide(
                color: team == "Blue" ? Colors.blue : Colors.red, width: 0.5),
            borderRadius: BorderRadius.circular(5)),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              name,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferenceModel>(
        builder: (context, PreferenceModel themeNotifier, child) {
      return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Center(
                child: Text(
                    translate(getTextPlaySound(game_state, widget.sound),
                        themeNotifier.language),
                    style: TextStyle(
                        fontSize: 32, color: themeNotifier.fontcolor)),
              ),
              const SizedBox(
                height: 15.0,
              ),
              // Show red team
              Expanded(
                child: ListView.builder(
                  itemCount: redTeam.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _userListTile(
                        redTeam[index].name, redTeam[index].team);
                  },
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              // show blue team
              Expanded(
                child: ListView.builder(
                  itemCount: blueTeam.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _userListTile(
                        blueTeam[index].name, blueTeam[index].team);
                  },
                ),
              ),
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
