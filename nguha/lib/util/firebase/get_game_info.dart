import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

Future<Map<String, Object>> getGameInfo(String gameCode) async {
  Map<String, Object> info = {};
  DatabaseReference inforef =
      FirebaseDatabase.instance.ref("games/" + gameCode + "/info/");
  // get info
  await inforef.once().then((event) {
    for (var item in event.snapshot.children) {
      info[item.key.toString()] = item.value!;
    }
  });
  return info;
}
