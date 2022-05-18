import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:Nguha/util/firebase/random_user_code.dart';

// given name and game code, generates random user code and adds user to game
// return user code
void setUserTeam(String userCode, String gameCode, String value) async {
  DatabaseReference databaseref = FirebaseDatabase.instance
      .ref("games/" + gameCode + "/users/" + userCode + "/team/");
  databaseref.set(value);
}
