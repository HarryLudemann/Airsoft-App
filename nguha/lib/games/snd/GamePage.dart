// class game to represent snd game view
// return list: -1 is empty, 1 - 12 means active
// game object is usable once
import 'dart:async';
import 'package:Nguha/util/firebase/delete_game.dart';
import 'package:flutter/material.dart';
import 'package:Nguha/util/firebase/listener.dart';
import 'package:Nguha/util/gamestate.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/games/snd/PassiveBombPage.dart';

// given seconds return formated time
String secondsToMinutes(double seconds) {
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

class GamePage extends StatefulWidget {
  final bool passCodeChanges;
  final int cardsToRemember;
  final int passcodeAttempts;
  final String gameCode;
  final double bombExplosionSeconds;
  final PreferenceModel themeNotifier;
  final String userCode;
  final bool doublePop;

  GamePage(
      this.cardsToRemember,
      this.passCodeChanges,
      this.gameCode,
      this.bombExplosionSeconds,
      this.passcodeAttempts,
      this.themeNotifier,
      this.userCode,
      this.doublePop) {}

  @override
  State<GamePage> createState() => Game();
}

class Game extends State<GamePage> {
  StreamSubscription? _onStartGameStateChanged;
  double _bombExplosionSeconds = 0.0;
  int _gameState = 0; // just to check not double setting same game state
  bool _sound = true;
  Timer? _bombTimer;
  List<int> _board = []; // represent game keypad
  List<int> _currentAnswer = []; // current inputed answer
  bool _hideTiles = false; // if true, game returns 12 "-1"
  int _passDefuseAttempts = 0;
  String _bombName = "";

  @override
  void initState() {
    super.initState();
    _board = _getRandomList(widget.cardsToRemember);
    _bombExplosionSeconds = widget.bombExplosionSeconds;
    _passDefuseAttempts = widget.passcodeAttempts;
    _setGameState(GAME_STARTING);
    _activateListeners();
  }

  @override
  void deactivate() {
    DatabaseListener("games/" + widget.gameCode + "/info/").update({
      "startGame": false,
    });
    _setGameState(WAITING);
    deleteGame(widget.gameCode);
    _deactivateListeners();
    super.deactivate();
  }

  @override
  void setState(void Function() fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void _activateListeners() {
    DatabaseListener startGameListener =
        DatabaseListener("games/" + widget.gameCode + "/info/startGame");

    _onStartGameStateChanged = startGameListener.listenBool((bool _startGame) {
      if (_startGame == false) {
        _deactivateListeners();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PassiveBombPage(
              gameCode: widget.gameCode,
            ),
          ),
        );
      }
    });
  }

  void _deactivateListeners() {
    super.deactivate();
    if (_onStartGameStateChanged != null) {
      _onStartGameStateChanged!.cancel();
      _onStartGameStateChanged = null;
    }
  }

  // Set game state for game code in real time database,
  // wont set if same gamestate
  void _setGameState(int newState) {
    if (_gameState == newState) {
      return;
    }
    _gameState = newState;
    DatabaseListener("games/" + widget.gameCode + "/game_state")
        .set(newState.toString());
    getTextPlaySound(newState, _sound); // if sound, plays
  }

  // Given int "value", returns list of 12 ints of 1-"value" rest being 0
  List<int> _getRandomList(int value) {
    List<int> list = [];
    // add numbers 1 - value
    for (int i = 0; i < value; i++) {
      list.add(i + 1);
    }
    // add 0's until 12 items
    while (list.length < 12) {
      list.add(0);
    }
    list.shuffle();
    return list;
  }

  void _addToAnswer(int number) {
    // if given number is correct
    if (number == (_currentAnswer.length + 1)) {
      _currentAnswer.add(number);
      if (number == widget.cardsToRemember.toInt()) {
        // if bomb planted
        if (_gameState == BOMB_PLANTED) {
          _defuseBomb();
        } else {
          _plantBomb();
        }
      } else if (_currentAnswer.length == 1) {
        setState(() {
          _hideTiles = true;
        });
      }
    } else {
      // if wrong number, if still has attempts restart, else explode
      if (_gameState != BOMB_PLANTED ||
          _gameState == BOMB_PLANTED && _passDefuseAttempts > 0) {
        _resetBoard();
      } else if (_gameState != BOMB_PLANTED) {
        _explodeBomb();
      }
    }
  }

  // Shows tiles, clears answer and regenerates list if needed
  void _resetBoard() {
    setState(() {
      if (widget.passCodeChanges) {
        _board = _getRandomList(widget.cardsToRemember);
      }
      _currentAnswer = [];
      _hideTiles = false;
    });
  }

  void _plantBomb() {
    DatabaseListener(
            "games/" + widget.gameCode + "/users/" + widget.userCode + "/name/")
        .getOnceString()
        .then((_name) {
      _bombName = _name;
    });
    _deactivateListeners();
    DatabaseListener("games/" + widget.gameCode + "/info/").update({
      "startGame": false,
      "active_bomb": _bombName,
    });
    _resetBoard();
    setState(() {
      _startBombTimer();
      _setGameState(BOMB_PLANTED);
    });
  }

  void _explodeBomb() {
    setState(() {
      _setGameState(EXPLODED);
    });
  }

  void _defuseBomb() {
    setState(() {
      _bombTimer?.cancel();
      _setGameState(BOMB_DEFUSED);
    });
  }

  // future function to call sound after second
  Future<void> _playGoSound() async {
    await Future.delayed(Duration(seconds: 1));
    _setGameState(GO);
  }

  void _startBombTimer() {
    _bombTimer = Timer.periodic(const Duration(seconds: 1), (Timer _bombTimer) {
      // this point is run once every second
      if (_bombExplosionSeconds > 0) {
        setState(() {
          // update UI
          _bombExplosionSeconds--;
        });

        if (possibleStates.contains(_bombExplosionSeconds.round())) {
          _setGameState(_bombExplosionSeconds.round());
        }
      } else {
        _bombTimer.cancel();
        _explodeBomb();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: widget.themeNotifier.backgroundColor,
        primaryColor: widget.themeNotifier.primaryColor,
      ),
      home: Scaffold(
          backgroundColor: widget.themeNotifier.backgroundColor,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // show text of current state
                Text(
                  translate(getTextPlaySound(_gameState, false),
                      widget.themeNotifier.language),
                  style: TextStyle(
                      // change font family to poppins
                      color: _gameState == BOMB_DEFUSED
                          ? Colors.green
                          : _gameState == BOMB_PLANTED
                              ? Colors.red
                              : Colors.transparent,
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
                        child: Text(secondsToMinutes(_bombExplosionSeconds),
                            style: TextStyle(
                              color: _gameState == BOMB_PLANTED
                                  ? Colors.red
                                  : _gameState == BOMB_DEFUSED
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
                                    translate(
                                        "Help", widget.themeNotifier.language),
                                    style: const TextStyle(
                                        fontFamily: 'BebasNeue',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  content: Text(
                                    translate(
                                        "1. Plant/Defuse bomb by completing keycode.\n\n2. Finish keycode by selecting numbers in ascending order.\n\n3. Numbers disappear after first tile is selected.\n\n",
                                        widget.themeNotifier.language),
                                    style: const TextStyle(
                                        fontFamily: 'BebasNeue',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text(
                                        translate("Close",
                                            widget.themeNotifier.language),
                                        style: const TextStyle(
                                            fontFamily: 'BebasNeue',
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        if (!widget.doublePop) {
                                          Navigator.pop(context);
                                        } else {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
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
                if (_gameState != BOMB_DEFUSED && _gameState != EXPLODED)
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
                              color: (_board[index] == 0 || _hideTiles)
                                  ? Colors.transparent
                                  : Theme.of(context).primaryColor,
                              onPressed: () {
                                _addToAnswer(_board[index]);
                              },
                              child: Text(
                                _board[index] == 0
                                    ? ''
                                    : _board[index].toString(),
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
                _gameState == BOMB_DEFUSED || _gameState == EXPLODED
                    ? Padding(
                        padding: const EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                            minimumSize: const Size.fromHeight(80), // NEW
                          ),
                          onPressed: () {
                            _bombTimer?.cancel();
                            if (!widget.doublePop) {
                              Navigator.pop(context);
                            } else {
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },
                          child: Text(
                            translate("Back", widget.themeNotifier.language),
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
          )),
    );
  }
}
