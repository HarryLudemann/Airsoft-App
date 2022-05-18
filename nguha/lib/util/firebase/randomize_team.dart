import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:Nguha/util/firebase/change_user_team.dart';
import 'package:firebase_database/firebase_database.dart';

class User {
  String id;
  String name;
  String team;
  User(this.id, this.name, this.team);
}

// get list of users, excluding users that are bombs
Future<List<User>> _getUsers(String gameCode) async {
  List<User> _users = [];
  DatabaseReference ref =
      FirebaseDatabase.instance.ref("games/$gameCode/users/");
  // get list of users
  await ref.once().then((snapshot) {
    for (var child in snapshot.snapshot.children) {
      String team = child.child("team").value.toString();
      if (team == '#1 Bomb' || team == '#2 Bomb') {
        continue;
      }
      _users.add(User(
          child.key.toString(), child.child("name").value.toString(), team));
    }
  });

  return _users;
}

// gets users, halfs total and sets players teams
void randomize_team(String gameCode) async {
  await _getUsers(gameCode).then((value) {
    if (value.isEmpty) {
      return;
    }
    int total = value.length;
    int redCount = 0;
    int blueCount = 0;
    int maxCount = total ~/ 2;
    for (var child in value) {
      if (Random().nextBool() && redCount < maxCount) {
        setUserTeam(child.id, gameCode, "Red");
        redCount++;
      } else {
        setUserTeam(child.id, gameCode, "Red");
        blueCount++;
      }
    }
  });
}
