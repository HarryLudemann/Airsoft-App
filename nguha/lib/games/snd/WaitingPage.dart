import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/games/snd/PassiveBombPage.dart';
import 'package:Nguha/util/firebase/listener.dart';
import 'package:Nguha/util/settings/preference_model.dart';
import 'package:Nguha/util/languages.dart';
import 'package:Nguha/util/sound.dart';
import 'package:Nguha/games/snd/GamePage.dart';
import 'package:Nguha/util/gamestate.dart';

// create stateless widget
class WaitingPage extends StatefulWidget {
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
  PreferenceModel themeNotifier;

  List<int> Game = [0, 5, 0, 3, 0, 2, 6, 0, 4, 1, 0, 0];

  WaitingPage(
      this.bombExplosionSec,
      this.soundOn,
      this.cardsRemember,
      double passcodeAttempts,
      this.passcodeChanges,
      this.waitSeconds,
      this.code,
      this.userCode,
      this.themeNotifier) {
    passPlaAttempts = passcodeAttempts;
    passDefAttempts = passcodeAttempts;
    allowedAttempts = passcodeAttempts;
  }

  @override
  State<WaitingPage> createState() => exist();
}

class exist extends State<WaitingPage> {
  int _gameState = 0; // just to check not double setting same game state

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
    _startWaitTimer();
  }

  @override
  void setState(void Function() fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  // Set game state for game code in real time database,
  // wont set if same gamestate
  void _setGameState(int newState) {
    if (!_currState.contains(newState.toString())) {
      return;
    }
    if (_gameState == newState) {
      return;
    }
    _gameState = newState;
    DatabaseListener("games/" + widget.code + "/game_state")
        .set(newState.toString());
    getTextPlaySound(newState, widget.soundOn); // if sound, plays
  }

  void _gotoGamePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GamePage(
            widget.cardsRemember.toInt(),
            widget.passcodeChanges,
            widget.code,
            widget.bombExplosionSec,
            widget.passPlaAttempts.toInt(),
            widget.themeNotifier,
            widget.userCode,
            true),
      ),
    );
  }

  Future _startWaitTimer() async {
    // generate list for game
    // widget.Game = _getRandomList(widget.cardsRemember.toInt());
    // start wait time countdown
    if (widget.waitSeconds > 0) {
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        if (possibleStates.contains(widget.bombExplosionSec.round())) {
          _setGameState(widget.bombExplosionSec.round());
        }
        if (widget.waitSeconds > 0) {
          setState(() {
            widget.waitSeconds--;
          });
        } else {
          timer.cancel();
          _gotoGamePage();
        }
      });
    } else {
      _gotoGamePage();
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
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
                translate("Starting in", widget.themeNotifier.language),
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
                secondsToMinutes(widget.waitSeconds),
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
                      translate("Back", widget.themeNotifier.language),
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
  }
}
