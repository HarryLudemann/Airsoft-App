// page to show another bomb is active, shown until game is over
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Nguha/util/firebase/listener.dart';

class PassiveHostPage extends StatefulWidget {
  String code = "";
  PassiveHostPage({Key? key, required String gameCode}) : super(key: key) {
    this.code = gameCode;
  }

  @override
  State<PassiveHostPage> createState() => _PassiveHostPageState();
}

class _PassiveHostPageState extends State<PassiveHostPage> {
  StreamSubscription? _onGameStateChanged;

  @override
  void initState() {
    super.initState();
    _activateListeners();
  }

  void _activateListeners() {
    DatabaseListener gameStateListener =
        DatabaseListener("games/" + widget.code + "/game_state");

    _onGameStateChanged = gameStateListener.listenString((String _gameState) {
      if (_gameState == "0") {
        _deactivateListeners();
        Navigator.pop(context);
      }
    });
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

  @override
  Widget build(BuildContext context) {
    // display the active bomb name
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              "Game in progress",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
