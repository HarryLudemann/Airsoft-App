import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:Nguha/util/languages.dart';
import 'package:provider/provider.dart';
import 'package:Nguha/util/preference_model.dart';

class JoinedPage extends StatefulWidget {
  String code = "";
  bool sound = true;
  JoinedPage({required Key key, required String code, bool? sound})
      : super(key: key) {
    if (sound != null) {
      this.sound = sound;
    }
    this.code = code;
  }
  @override
  State<JoinedPage> createState() => _JoinedPageState();
}

class _JoinedPageState extends State<JoinedPage> {
  String game_state = "";
  String gameStatePath = "";
  DatabaseReference databaseref = FirebaseDatabase.instance.ref();
  StreamSubscription? _onGameStateChanged;

  bool muted = false;

  @override
  void initState() {
    super.initState();
    String gameStatePath = "games/" + widget.code + "/game_state";
    databaseref = FirebaseDatabase.instance.ref(gameStatePath);
    _activateListeners();
  }

  @override
  void deactivate() {
    _deactivateListeners();
    super.deactivate();
  }

  void _deactivateListeners() {
    super.deactivate();
    if (_onGameStateChanged != null) {
      _onGameStateChanged!.cancel();
      _onGameStateChanged = null;
    }
  }

  void _activateListeners() {
    Stream<DatabaseEvent> stream = databaseref.onValue;

    _onGameStateChanged = stream.listen((DatabaseEvent event) {
      setState(() {
        this.game_state = event.snapshot.value as String;
      });
    });
  }

  void PlayMusic(String music) {
    if (!widget.sound) return;
    FlameAudio.play(music + '.mp3');
  }

  void playSound(String sound) {
    if (muted) return;
    if (sound == "10") {
      PlayMusic('10second');
    } else if (sound == '1') {
      PlayMusic('1');
    } else if (sound == '2') {
      PlayMusic('2');
    } else if (sound == '3') {
      PlayMusic('3');
    } else if (sound == "go") {
      PlayMusic('go');
    } else if (sound == '30') {
      PlayMusic('30second');
    } else if (sound == '45') {
      PlayMusic('45second');
    } else if (sound == '60') {
      PlayMusic('1minute');
    } else if (sound == '120') {
      PlayMusic('2minute');
    } else if (sound == '300') {
      PlayMusic('5minute');
    } else if (sound == '600') {
      PlayMusic('10minute');
    } else if (sound == '900') {
      PlayMusic('15minute');
    } else if (sound == '1001') {
      PlayMusic('BombDefused');
    } else if (sound == '1002') {
      PlayMusic('BombPlanted');
    } else if (sound == '1003') {
      PlayMusic('explosion');
    }
  }

  // function given gamestate or sound return text
  String getText(String gameState) {
    playSound(gameState);
    if (gameState == "10") {
      return "10 seconds";
    } else if (gameState == "1") {
      return "1";
    } else if (gameState == "2") {
      return "2";
    } else if (gameState == "3") {
      return "3";
    } else if (gameState == "go") {
      return "GO!";
    } else if (gameState == "30") {
      return "30 seconds";
    } else if (gameState == "45") {
      return "45 seconds";
    } else if (gameState == "60") {
      return "1 minute";
    } else if (gameState == "120") {
      return "2 minutes";
    } else if (gameState == "300") {
      return "5 minutes";
    } else if (gameState == "600") {
      return "10 minutes";
    } else if (gameState == "900") {
      return "15 minutes";
    } else if (gameState == "1001") {
      return "Bomb Defused";
    } else if (gameState == "1002") {
      return "Bomb Planted";
    } else if (gameState == "1003") {
      return "Explosion";
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
                    translate(getText(game_state), themeNotifier.language),
                    style: const TextStyle(fontSize: 32, color: Colors.white)),
              ),
              const Spacer(),
              IconButton(
                iconSize: 48,
                color: Colors.white,
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
