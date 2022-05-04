import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:math';

Future<String> getRandomGameCode() async {
  // gets unique 6 digit code
  String digits = "";
  for (int i = 0; i < 6; i++) {
    digits += Random().nextInt(10).toString();
  }
  DatabaseReference databaseref =
      FirebaseDatabase.instance.ref("games/" + digits);
  final event = await databaseref.once(DatabaseEventType.value);
  if (event.snapshot.value == null) {
    return digits;
  } else {
    return getRandomGameCode();
  }
}
