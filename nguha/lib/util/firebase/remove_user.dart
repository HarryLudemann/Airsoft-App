import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

void removeUser(String gameCode, String userCode) {
  FirebaseDatabase.instance
      .ref("games/" + gameCode + "/users/userCode")
      .remove();

  // if users list empty delete game
  FirebaseDatabase.instance
      .ref("games/" + gameCode + "/users/")
      .once(DatabaseEventType.value)
      .then((event) {
    if (event.snapshot.value == null) {
      FirebaseDatabase.instance.ref("games/" + gameCode).remove();
    }
  });
}
