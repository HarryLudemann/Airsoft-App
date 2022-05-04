import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void removeUser(String gameCode, String userCode) {
  FirebaseDatabase.instance
      .ref("games/" + gameCode + "/users/userCode")
      .remove();
}
