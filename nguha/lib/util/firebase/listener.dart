import 'dart:async';
import 'package:firebase_database/firebase_database.dart';

// class that controls listening to database
class DatabaseListener {
  // variables
  late DatabaseReference _database;

  // constructor
  DatabaseListener(String path) {
    _database = FirebaseDatabase.instance.ref(path);
  }

  // methods
  Future<String> getOnceString() async {
    String result = "";
    await _database.once(DatabaseEventType.value).then((event) {
      result = event.snapshot.value.toString();
    });
    return result;
  }

  Future<bool> getOnceBool() async {
    bool result = true;
    await _database.once(DatabaseEventType.value).then((event) {
      result = event.snapshot.value as bool;
    });
    return result;
  }

  StreamSubscription<DatabaseEvent> listenString(void onData(String event)) {
    return _database.onValue.listen((event) {
      onData(event.snapshot.value.toString());
    });
  }

  StreamSubscription<DatabaseEvent> listenBool(void onData(bool event)) {
    return _database.onValue.listen((event) {
      // if event.snapshot.value is not null
      if (event.snapshot.value != null) {
        onData(event.snapshot.value as bool);
      }
    });
  }

  // listen for a table with two values for each base item
  StreamSubscription<DatabaseEvent> listenTwoChildList(
      void onData(Map<String, String> map, Map<String, String> mapKeys)) {
    return _database.onValue.listen((event) {
      Map<String, String> map = {};
      Map<String, String> mapKeys = {};
      for (var item in event.snapshot.children) {
        mapKeys[item.children.first.value.toString()] = item.key.toString();
        map[item.children.first.value.toString()] =
            item.children.last.value.toString();
        onData(map, mapKeys);
      }
    });
  }

  // given list eg. {'team': value}
  void update(Map<String, Object?> value) {
    _database.update(value);
  }

  // given string sets value
  void set(String value) {
    _database.set(value);
  }
}
