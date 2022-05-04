import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void uploadGameInfo(
    String gameCode,
    String cardsRemember,
    String passcodeAttempts,
    bool passcodeChanges,
    String bombExplosionSec,
    bool soundOn,
    String waitSeconds) {
  String gameInfoPath = "games/" + gameCode + "/info/";
  DatabaseReference ref = FirebaseDatabase.instance.ref(gameInfoPath);
  ref.set({
    'gamemode': "Search n Destroy",
    'startGame': true, // signal for additional bombs to start
    'cardsRemember': double.parse(cardsRemember),
    'passcodeAttempts': double.parse(passcodeAttempts),
    'passcodeChanges': passcodeChanges,
    'bombExplosionSec': (double.parse(
            bombExplosionSec.substring(0, bombExplosionSec.length - 1)) *
        60),
    'soundOn': soundOn,
    'waitSeconds':
        double.parse(waitSeconds.substring(0, waitSeconds.length - 1)),
    'gameCode': gameCode,
  });
}

// future to upload game info
Future<void> uploadGameInfoFuture(
    String gameCode,
    String cardsRemember,
    String passcodeAttempts,
    bool passcodeChanges,
    String bombExplosionSec,
    bool soundOn,
    String waitSeconds) async {
  uploadGameInfo(gameCode, cardsRemember, passcodeAttempts, passcodeChanges,
      bombExplosionSec, soundOn, waitSeconds);
}
