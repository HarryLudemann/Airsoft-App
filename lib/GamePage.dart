import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flame/input.dart';
import 'package:flame_audio/flame_audio.dart';

// create stateless widget
class GamePage extends StatefulWidget {
  double bombExplosionSec = 0;
  double cardsRemember = 5;
  double allowedAttempts = 0;
  double passPlaAttempts = 0;
  double passDefAttempts = 0;
  double waitSeconds = 0;

  bool soundOn = true;
  bool soundBombCountdownOn = true;
  bool passcodeChanges = true;

  List<int> Game = [0, 5, 0, 3, 0, 2, 6, 0, 4, 1, 0, 0];

  GamePage(
      double bombExplosionSec,
      bool soundOn,
      bool soundBombCountdownOn,
      double cardsRemember,
      double passcodeAttempts,
      bool passcodeChanges,
      double waitSeconds) {
    this.bombExplosionSec = bombExplosionSec;
    this.soundOn = soundOn;
    this.soundBombCountdownOn = soundBombCountdownOn;
    this.cardsRemember = cardsRemember;
    this.passPlaAttempts = passcodeAttempts;
    this.passDefAttempts = passcodeAttempts;
    this.allowedAttempts = passcodeAttempts;
    this.passcodeChanges = passcodeChanges;
    this.waitSeconds = waitSeconds;
  }

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Timer? bombTimer;
  List<int> Answer = [];
  bool hideTiles = false;
  bool bombPlanted = false;
  String currState = "";
  Timer? timer; // used for waiting screen countdown

  Future<void> loadAssets() async {
    await FlameAudio.audioCache.loadAll(['explosion.mp3', 'beep3.mp3']);
  }

  void PlayMusic(String music) {
    if (!widget.soundOn) return;
    FlameAudio.play(music + '.mp3');
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

  void resetGame() {
    setState(() {
      if (widget.passcodeChanges) {
        // if passcode changes change passcode
        widget.Game = _getRandomList(widget.cardsRemember.toInt());
      }
      Answer = [];
      hideTiles = false;
    });
  }

  void explodeBomb() {
    PlayMusic('explosion');
    setState(() {
      hideTiles = true;
      currState = "Bomb Exploded";
    });
  }

  void addToAnswer(int number) {
    // if answer length is 1 less then number
    if (number == (Answer.length + 1)) {
      Answer.add(number);
      if (number == widget.cardsRemember.toInt()) {
        if (bombPlanted) {
          // defused bomb
          PlayMusic('BombDefused');
          setState(() {
            currState = "Bomb Defused";
            hideTiles = true;
            bombTimer?.cancel(); // stop bombTimer
          });
        } else {
          // planted bomb
          resetGame();
          setState(() {
            PlayMusic('BombPlanted');
            startbombTimer();
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
      else if (bombPlanted && widget.passDefAttempts > 0) {
        setState(() {
          widget.passDefAttempts--;
          resetGame();
        });
      } else if (bombPlanted) {
        explodeBomb();
      }
    }
  }

  void startbombTimer() {
    bombTimer = Timer.periodic(Duration(seconds: 1), (Timer bombTimer) {
      setState(() {
        if (widget.bombExplosionSec > 0) {
          widget.bombExplosionSec--;
          // play sound if at correct interval 10, 30, 45 sec, 1, 2, 5, 10, 15 minutes
          if (widget.soundBombCountdownOn) {
            if (widget.bombExplosionSec == 10) {
              PlayMusic('10second');
            } else if (widget.bombExplosionSec == 30) {
              PlayMusic('30second');
            } else if (widget.bombExplosionSec == 45) {
              PlayMusic('45second');
            } else if (widget.bombExplosionSec == 60) {
              PlayMusic('1minute');
            } else if (widget.bombExplosionSec == 120) {
              PlayMusic('2minute');
            } else if (widget.bombExplosionSec == 300) {
              PlayMusic('5minute');
            } else if (widget.bombExplosionSec == 600) {
              PlayMusic('10minute');
            } else if (widget.bombExplosionSec == 900) {
              PlayMusic('15minute');
            }
          }
        } else {
          bombTimer.cancel();
          explodeBomb();
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getThingsOnStartup().then((value) {});
  }

  Future _getThingsOnStartup() async {
    // generate list for game
    widget.Game = _getRandomList(widget.cardsRemember.toInt());
    // start wait time countdown
    if (widget.waitSeconds > 0) {
      timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    if (widget.waitSeconds == 3 && widget.soundBombCountdownOn) {
      PlayMusic('3');
    } else if (widget.waitSeconds == 2 && widget.soundBombCountdownOn) {
      PlayMusic('2');
    } else if (widget.waitSeconds == 1 && widget.soundBombCountdownOn) {
      PlayMusic('1');
    } else if (widget.waitSeconds == 1 && widget.soundBombCountdownOn) {
      PlayMusic('go');
    }
    // if waitSeconds is 0 show game else show empty material app
    if (widget.waitSeconds == 0) {
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
                  currState,
                  style: TextStyle(
                      // change font family to poppins
                      color: currState == "Bomb Defused"
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
                        child: Text(secondsToMinutes(widget.bombExplosionSec),
                            style: TextStyle(
                              color: currState == "Bomb Planted"
                                  ? Colors.red
                                  : currState == "Bomb Defused"
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
                                  title: const Text(
                                    "Help",
                                    style: TextStyle(
                                        fontFamily: 'BebasNeue',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30),
                                  ),
                                  content: const Text(
                                    "1. Plant/Defuse bomb by completing keycode.\n\n2. Finish keycode by selecting numbers in ascending order.\n\n3. Numbers disappear after first tile is selected.\n\n",
                                    style: TextStyle(
                                        fontFamily: 'BebasNeue',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: const Text(
                                        "Close",
                                        style: TextStyle(
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
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              color: (widget.Game[index] == 0 || hideTiles)
                                  ? Colors.transparent
                                  : Colors.blue,
                              onPressed: () {
                                addToAnswer(widget.Game[index]);
                              },
                              child: Text(
                                widget.Game[index] == 0
                                    ? ''
                                    : widget.Game[index].toString(),
                                style: TextStyle(
                                    fontSize: 50,
                                    // color white unless hidetiles then transparent
                                    color: hideTiles
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
                currState == "Bomb Defused" || currState == "Bomb Exploded"
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue,
                            minimumSize: const Size.fromHeight(80), // NEW
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                            bombTimer?.cancel();
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
    // else show loading screen
    else {
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
                const Text(
                  "Starting in",
                  style: TextStyle(
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
                    padding: EdgeInsets.all(10),
                    child: TextButton(
                      child: const Text(
                        "Back",
                        style: TextStyle(
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
}
