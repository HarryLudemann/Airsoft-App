import 'dart:async';
import 'dart:convert';
import 'package:firebase_database/firebase_database.dart';

class User {
  String id;
  String name;
  String team;
  User(this.id, this.name, this.team);
}

class GameUsers {
  StreamSubscription? _onInfoChanged;
  StreamSubscription? _onInfoAdded;
  StreamSubscription? _onInfoRemoved;
  late DatabaseReference _database;
  List<User> users = [];

  GameUsers(String gameCode) {
    _database = FirebaseDatabase.instance.ref("games/" + gameCode + "/users/");
  }

  // parse function from json style string to user object
  User _parseUser(String jsonString, String key) {
    Map<String, dynamic> map = jsonDecode(jsonString);
    return User(key, map['name'], map['team']);
  }

  User? _getUser(String id) {
    for (User user in users) {
      if (user.id == id) {
        return user;
      }
    }
    return null;
  }

  void _updateUser(User user) {
    User? oldUser = _getUser(user.id);
    if (oldUser != null) {
      users.remove(oldUser);
    }
    users.add(user);
  }

  void _deleteUser(User user) {
    User? oldUser = _getUser(user.id);
    if (oldUser != null) {
      users.remove(oldUser);
    }
  }

  List<User> getTeam(bool redTeam) {
    List<User> team = [];
    for (User user in users) {
      if (user.team == 'Red' && redTeam) {
        team.add(user);
      } else if (user.team == 'Blue' && !redTeam) {
        team.add(user);
      }
    }
    return team;
  }

  void listen() {
    _onInfoAdded = _database.onChildAdded.listen((event) {
      User user = _parseUser(
          event.snapshot.value.toString(), event.snapshot.key.toString());
      _updateUser(user);
    });
    _onInfoChanged = _database.onChildChanged.listen((event) {
      User user = _parseUser(
          event.snapshot.value.toString(), event.snapshot.key.toString());
      _updateUser(user);
    });
    _onInfoRemoved = _database.onChildRemoved.listen((event) {
      User user = _parseUser(
          event.snapshot.value.toString(), event.snapshot.key.toString());
      _deleteUser(user);
    });
  }

  void deactivate() {
    _onInfoAdded?.cancel();
    _onInfoChanged?.cancel();
    _onInfoRemoved?.cancel();
  }
}
