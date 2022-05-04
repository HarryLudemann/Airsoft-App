import 'package:firebase_database/firebase_database.dart';

void deleteGame(String gameCode) {
  String gameStatePath = "games/" + gameCode;
  FirebaseDatabase.instance.ref(gameStatePath).remove();
}
