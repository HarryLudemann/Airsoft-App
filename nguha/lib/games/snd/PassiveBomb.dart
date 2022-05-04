// page to show another bomb is active, shown until game is over
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:Nguha/util/firebase/listener.dart';

class PassiveBombPage extends StatefulWidget {
  String code = "";
  PassiveBombPage({Key? key, required String gameCode}) : super(key: key) {
    this.code = gameCode;
  }

  @override
  State<PassiveBombPage> createState() => _PassiveBombPageState();
}

class _PassiveBombPageState extends State<PassiveBombPage> {
  StreamSubscription? _onGameStateChanged;
  String? activeBombName;

  @override
  void initState() {
    super.initState();
    DatabaseListener("games/" + widget.code + "/info/active_bomb")
        .getOnceString()
        .then((_bombName) {
      setState(() {
        activeBombName = _bombName;
      });
    });

    _activateListeners();
  }

  void _activateListeners() {
    DatabaseListener gameStateListener =
        DatabaseListener("games/" + widget.code + "/game_state");

    _onGameStateChanged = gameStateListener.listenString((String _gameState) {
      if (_gameState == "0") {
        _deactivateListeners();
        Navigator.pop(context);
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
          children: <Widget>[
            const Text(
              "Active Bomb:",
              style: TextStyle(fontSize: 28, color: Colors.white),
            ),
            Text(
              activeBombName ?? "",
              style: const TextStyle(fontSize: 28, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
