import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// create stateless widget
class PlaySnD extends StatefulWidget {
  double bombExplosionSec = 0;
  double cardsRemember = 5;
  double allowedAttempts = 3;
  double passPlaAttempts = 3;
  double passDefAttempts = 3;

  bool soundOn = true;
  bool soundBombCountdownOn = true;

  List<int> Game = [0, 5, 0, 3, 0, 2, 6, 0, 4, 1, 0, 0];

  PlaySnD(double bombExplosionSec, bool soundOn, bool soundBombCountdownOn,
      double cardsRemember, double passcodeAttempts) {
    this.bombExplosionSec = bombExplosionSec;
    this.soundOn = soundOn;
    this.soundBombCountdownOn = soundBombCountdownOn;
    this.cardsRemember = cardsRemember;
    this.passPlaAttempts = passcodeAttempts;
    this.passDefAttempts = passcodeAttempts;
    this.allowedAttempts = passcodeAttempts;
  }

  @override
  State<PlaySnD> createState() => _PlaySnDState();
}

class _PlaySnDState extends State<PlaySnD> {
  Timer? timer;

  List<int> Answer = [];

  bool hideTiles = false;

  bool bombPlanted = false;

  String currState = "";

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

  void resetGame() {
    setState(() {
      Answer = [];
      currState = "";
      bombPlanted = false;
      hideTiles = false;
    });
  }

  void explodeBomb() {
    setState(() {
      hideTiles = true;
      currState = "Bomb Exploded";
    });
  }

  void addToAnswer(int number) {
    // if answer length is 1 less then number
    if (number == (Answer.length + 1)) {
      Answer.add(number);
      if (number == widget.allowedAttempts.toInt()) {
        if (bombPlanted) {
          // defused bomb
          currState = "Bomb Defused";
          setState(() {
            hideTiles = true;
          });
          timer?.cancel(); // stop timer
        } else {
          // planted bomb
          startTimer();
          setState(() {
            resetGame();
            bombPlanted = true;
            currState = "Bomb Planted";
          });
        }
      } else {
        // hide tiles after 1 first press
        setState(() {
          hideTiles = true;
        });
      }
    } else {
      // failed passcode attempt
      // if bomb is not planted and passPlaAttempts is greater then 0 remove 1 and restart game
      if (!bombPlanted && widget.passPlaAttempts > 0) {
        setState(() {
          widget.passPlaAttempts--;
          resetGame();
        });
      } else if (!bombPlanted) {
        explodeBomb();
      }

      // if bomb is planted and passDefAttempts is greater then 0 remove 1 and restart game
      if (bombPlanted && widget.passDefAttempts > 0) {
        setState(() {
          widget.passDefAttempts--;
          resetGame();
        });
      } else if (bombPlanted) {
        explodeBomb();
      }
    }
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (widget.bombExplosionSec > 0) {
          widget.bombExplosionSec--;
        } else {
          timer.cancel();
          explodeBomb();
        }
      });
    });
  }

  @override
  void initState() {
    _getThingsOnStartup().then((value) {});
    super.initState();
  }

  Future _getThingsOnStartup() async {
    // widget.Game = _getRandomList(widget.allowedAttempts.toInt());
    // startTimer(); // start bomb timer
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // show text of current state
              Text(
                currState,
                style: TextStyle(
                  color:
                      currState == "Bomb Defused" ? Colors.green : Colors.red,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // add space
              const SizedBox(
                height: 20,
              ),
              Text(
                widget.bombExplosionSec.toStringAsFixed(0),
                style: TextStyle(
                    color: currState == "Bomb Planted"
                        ? Colors.red
                        : currState == "Bomb Defused"
                            ? Colors.green
                            : Colors.white,
                    fontSize: 50),
              ),
              // Game Squares
              // grid view of square buttons
              // if currState does not equal 'Bomb Defused' show grid
              if (currState != "Bomb Defused" && currState != "Bomb Exploded")
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  children: List.generate(
                    12,
                    (index) {
                      return Padding(
                          padding: EdgeInsets.all(5),
                          child: RaisedButton(
                            // if game[index] is not 0 and game[index] not in answer add 5 elevation else 0
                            elevation: (widget.Game[index] != 0 &&
                                    !Answer.contains(widget.Game[index]))
                                ? 5
                                : 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            color: (widget.Game[index] == 0 || hideTiles)
                                ? Colors.white
                                : Colors.blue,
                            onPressed: () {
                              addToAnswer(widget.Game[index]);
                            },
                            child: Text(
                              widget.Game[index] == 0
                                  ? ''
                                  : widget.Game[index].toString(),
                              style: const TextStyle(
                                  fontSize: 50, color: Colors.white),
                            ),
                          ));
                    },
                  ),
                ),
              const SizedBox(
                height: 10,
              ),
              currState == "Bomb Defused" || currState == "Bomb Exploded"
                  ? Padding(
                      padding: EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.blue,
                          minimumSize: const Size.fromHeight(100), // NEW
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Back",
                          style: TextStyle(
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
  }
}
