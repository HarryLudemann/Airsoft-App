import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Nguha/util/firebase/random_user_code.dart';

// given name and game code, generates random user code and adds user to game
// return user code
Future<String> addUser(String name, String gameCode) async {
  String userCode = await getRandomUserCode(gameCode);
  DatabaseReference databaseref =
      FirebaseDatabase.instance.ref("games/" + gameCode + "/users/");
  databaseref.child(userCode).set({
    "name": name,
    "team": "#1 Bomb",
  });
  return userCode;
}
