import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/games/snd/PassiveBomb.dart';
import 'package:Nguha/util/firebase/listener.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/sound.dart';

// create stateless widget
class Variables extends StatefulWidget {
  // Varibles passed to game page
  double bombExplosionSec = 0;
  double cardsRemember = 5;
  double allowedAttempts = 0;
  double passPlaAttempts = 0;
  double passDefAttempts = 0;
  double waitSeconds = 0;

  bool soundOn = true;
  bool passcodeChanges = true;
  String code = "";
  String userCode = "";

  List<int> Game = [0, 5, 0, 3, 0, 2, 6, 0, 4, 1, 0, 0];

  Variables(
      this.bombExplosionSec,
      this.soundOn,
      this.cardsRemember,
      double passcodeAttempts,
      this.passcodeChanges,
      this.waitSeconds,
      this.code,
      this.userCode) {
    passPlaAttempts = passcodeAttempts;
    passDefAttempts = passcodeAttempts;
    allowedAttempts = passcodeAttempts;
  }

  @override
  State<Variables> createState() => exist();
}

class exist extends State<Variables> {
  // listen for startgame to equal false to pop context

  StreamSubscription? _onStartGameStateChanged;

  // varibles used for game function
  Timer? _bombTimer;
  List<int> _Answer = [];
  bool _hideTiles = false;
  bool _bombPlanted = false;
  String _currState = "";
  Timer? _timer; // used for waiting screen countdown
  String _bombName = "";

  @override
  void initState() {
    super.initState();

    _setGameState("1006");
    _getThingsOnStartup();
    _activateListeners();
  }

  void _deactivateListeners() {
    super.deactivate();
    if (_onStartGameStateChanged != null) {
      _onStartGameStateChanged!.cancel();
      _onStartGameStateChanged = null;
    }
  }

  void _activateListeners() {
    DatabaseListener startGameListener =
        DatabaseListener("games/" + widget.code + "/info/startGame");

    _onStartGameStateChanged = startGameListener.listenBool((bool _startGame) {
      if (_startGame == false) {
        _deactivateListeners();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PassiveBombPage(
              gameCode: widget.code,
            ),
          ),
        );
      }
    });
  }

  // deactivate method to gamestate to waiting
  @override
  void deactivate() {
    // set to false
    DatabaseListener("games/" + widget.code + "/info/").update({
      "startGame": false,
    });
    _setGameState("0");
    _deactivateListeners();
    super.deactivate();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _setGameState(String newState) {
    DatabaseListener("games/" + widget.code + "/game_state").set(newState);
  }

  void _PlayMusic(String music) {
    if (!widget.soundOn) return;
    PlayMusic(music + '.mp3');
  }

  // get random 12 item list with 1 to given value rest being 0
  // eg given 5 could be [0, 5, 0, 3, 0, 2, 6, 0, 4, 1, 0, 0]
  List<int> _getRandomList(int value) {
    List<int> list = [];
    // add 1 to value to list
    for (int i = 0; i < value; i++) {
      list.add(i + 1);
    }
    // add 0 to list until list has 12 items
    while (list.length < 12) {
      list.add(0);
    }
    list.shuffle(); // shuffle list
    return list;
  }

  // given seconds return formated time
  String _secondsToMinutes(double seconds) {
    int sec = seconds.toInt();
    // if seconds is less then 60 return seconds
    if (seconds < 60) {
      return seconds.toStringAsFixed(0);
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

  void _resetGame() {
    setState(() {
      if (widget.passcodeChanges) {
        // if passcode changes change passcode
        widget.Game = _getRandomList(widget.cardsRemember.toInt());
      }
      _Answer = [];
      _hideTiles = false;
    });
  }

  void explodeBomb() {
    _PlayMusic('explosion');
    _setGameState("1003");
    setState(() {
      _hideTiles = true;
      _currState = "Bomb Exploded";
    });
  }

  void _plantBomb() {
    // get value
    DatabaseListener(
            "games/" + widget.code + "/users/" + widget.userCode + "/name/")
        .getOnceString()
        .then((_name) {
      setState(() {
        _bombName = _name;
      });
    });
    _deactivateListeners();

    DatabaseListener("games/" + widget.code + "/info/").update({
      "startGame": false,
      "active_bomb": _bombName,
    });

    _resetGame();
    _setGameState("1002");
    setState(() {
      _PlayMusic('_bombPlanted');
      _start_bombTimer();
      _bombPlanted = true;
      _currState = "Bomb Planted";
    });
  }

  void _defuseBomb() {
    _PlayMusic('BombDefused');
    _setGameState("1001");
    setState(() {
      _currState = "Bomb Defused";
      _hideTiles = true;
      _bombTimer?.cancel(); // stop _bombTimer
    });
  }

  void _hideAllTiles() {
    setState(() {
      _hideTiles = true;
    });
  }

  void _addTo_Answer(int number) {
    // if given number is correct
    if (number == (_Answer.length + 1)) {
      _Answer.add(number);
      if (number == widget.cardsRemember.toInt()) {
        if (_bombPlanted) {
          _defuseBomb();
        } else {
          _plantBomb();
        }
      } else if (_Answer.length == 1) {
        _hideAllTiles();
      }
    } else {
      // if wrong number, if still has attempts restart, else explode
      if (!_bombPlanted && widget.passPlaAttempts > 0 ||
          _bombPlanted && widget.passDefAttempts > 0) {
        setState(() {
          widget.passPlaAttempts--;
          _resetGame();
        });
      } else if (!_bombPlanted) {
        explodeBomb();
      }
    }
  }

  void _start_bombTimer() {
    _bombTimer = Timer.periodic(const Duration(seconds: 1), (Timer _bombTimer) {
      setState(() {
        if (widget.bombExplosionSec > 0) {
          widget.bombExplosionSec--;
          // play sound if at correct interval 10, 30, 45 sec, 1, 2, 5, 10, 15 minutes
          if (widget.soundOn) {
            if (widget.bombExplosionSec == 10) {
              _setGameState("10");
              _PlayMusic('10second');
            } else if (widget.bombExplosionSec == 30) {
              _setGameState("30");
              _PlayMusic('30second');
            } else if (widget.bombExplosionSec == 45) {
              _setGameState("45");
              _PlayMusic('45second');
            } else if (widget.bombExplosionSec == 60) {
              _setGameState("60");
              _PlayMusic('1minute');
            } else if (widget.bombExplosionSec == 120) {
              _setGameState("120");
              _PlayMusic('2minute');
            } else if (widget.bombExplosionSec == 300) {
              _setGameState("300");
              _PlayMusic('5minute');
            } else if (widget.bombExplosionSec == 600) {
              _setGameState("600");
              _PlayMusic('10minute');
            } else if (widget.bombExplosionSec == 900) {
              _setGameState("900");
              _PlayMusic('15minute');
            }
          }
        } else {
          _bombTimer.cancel();
          explodeBomb();
        }
      });
    });
  }

  Future _getThingsOnStartup() async {
    // generate list for game
    widget.Game = _getRandomList(widget.cardsRemember.toInt());
    // start wait time countdown
    if (widget.waitSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        setState(() {
          if (widget.waitSeconds > 0) {
            widget.waitSeconds--;
          } else {
            timer.cancel();
          }
        });
      });
    }
  }

  // future function to call sound after second
  Future<void> _playSound() async {
    await Future.delayed(Duration(seconds: 1));
    _setGameState("go");
    _PlayMusic('go');
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    if (widget.waitSeconds == 10 && widget.soundOn) {
      _setGameState("10");
      _PlayMusic('10second');
    } else if (widget.waitSeconds == 30 && widget.soundOn) {
      _setGameState("30");
      _PlayMusic('30second');
    } else if (widget.waitSeconds == 60 && widget.soundOn) {
      _setGameState("60");
      _PlayMusic('1minute');
    } else if (widget.waitSeconds == 3 && widget.soundOn) {
      _setGameState("3");
      _PlayMusic('3');
    } else if (widget.waitSeconds == 2 && widget.soundOn) {
      _setGameState("2");
      _PlayMusic('2');
    } else if (widget.waitSeconds == 1 && widget.soundOn) {
      _setGameState("1");
      _PlayMusic('1');
      _playSound();
    }
    // if waitSeconds is 0 show game else show empty material app
    if (widget.waitSeconds == 0) {
      return Consumer<PreferenceModel>(
          builder: (context, PreferenceModel themeNotifier, child) {
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            accentColor: Colors.black,
            backgroundColor: Colors.black,
          ),
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // show text of current state
                  Text(
                    translate(_currState, themeNotifier.language),
                    style: TextStyle(
                        // change font family to poppins
                        color: _currState == "Bomb Defused"
                            ? Colors.green
                            : Colors.red,
                        fontSize: 75,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BebasNeue'),
                  ),
                  // add space
                  const SizedBox(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 70.0),
                          child:
                              Text(_secondsToMinutes(widget.bombExplosionSec),
                                  style: TextStyle(
                                    color: _currState == "Bomb Planted"
                                        ? Colors.red
                                        : _currState == "Bomb Defused"
                                            ? Colors.green
                                            : Colors.transparent,
                                    fontSize: 55,
                                    fontFamily: 'BebasNeue',
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center),
                        ),
                      ),
                      // add help icon
                      Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: IconButton(
                          icon: const Icon(
                            Icons.help_outline_sharp,
                            size: 40,
                            color: Color.fromARGB(255, 95, 95, 95),
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      translate("Help", themeNotifier.language),
                                      style: const TextStyle(
                                          fontFamily: 'BebasNeue',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                    content: Text(
                                      translate(
                                          "1. Plant/Defuse bomb by completing keycode.\n\n2. Finish keycode by selecting numbers in ascending order.\n\n3. Numbers disappear after first tile is selected.\n\n",
                                          themeNotifier.language),
                                      style: const TextStyle(
                                          fontFamily: 'BebasNeue',
                                          fontWeight: FontWeight.bold,
                                          fontSize: 25),
                                    ),
                                    actions: <Widget>[
                                      FlatButton(
                                        child: Text(
                                          translate(
                                              "Close", themeNotifier.language),
                                          style: const TextStyle(
                                              fontFamily: 'BebasNeue',
                                              fontWeight: FontWeight.bold),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                });
                          },
                        ),
                      ),
                    ],
                  ),

                  // Game Squares
                  // grid view of square buttons
                  // if _currState does not equal 'Bomb Defused' show grid
                  if (_currState != "Bomb Defused" &&
                      _currState != "Bomb Exploded")
                    GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 3,
                      children: List.generate(
                        12,
                        (index) {
                          return Padding(
                              padding: const EdgeInsets.all(5),
                              child: RaisedButton(
                                // if game[index] is not 0 and game[index] not in _Answer add 5 elevation else 0
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                color: (widget.Game[index] == 0 || _hideTiles)
                                    ? Colors.transparent
                                    : Theme.of(context).primaryColor,
                                onPressed: () {
                                  _addTo_Answer(widget.Game[index]);
                                },
                                child: Text(
                                  widget.Game[index] == 0
                                      ? ''
                                      : widget.Game[index].toString(),
                                  style: TextStyle(
                                      fontSize: 50,
                                      // color white unless _hideTiles then transparent
                                      color: _hideTiles
                                          ? Colors.transparent
                                          : Colors.white),
                                ),
                              ));
                        },
                      ),
                    ),
                  const SizedBox(
                    height: 10,
                  ),
                  _currState == "Bomb Defused" || _currState == "Bomb Exploded"
                      ? Padding(
                          padding: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Theme.of(context).primaryColor,
                              minimumSize: const Size.fromHeight(80), // NEW
                            ),
                            onPressed: () {
                              _bombTimer?.cancel();
                              Navigator.pop(context);
                            },
                            child: Text(
                              translate("Back", themeNotifier.language),
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ))
                      : const SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
          ),
        );
      });
    }
    // else show loading screen
    else {
      return Consumer<PreferenceModel>(
          builder: (context, PreferenceModel themeNotifier, child) {
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            accentColor: Colors.black,
            backgroundColor: Colors.black,
          ),
          // simple loading screen
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    translate("Starting in", themeNotifier.language),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 75,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'BebasNeue'),
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Text(
                    _secondsToMinutes(widget.waitSeconds),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 55,
                      fontFamily: 'BebasNeue',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  // text button back button
                  // align at bottom center
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        child: Text(
                          translate("Back", themeNotifier.language),
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      });
    }
  }
}
