import 'package:firebase_database/firebase_database.dart';

Future<bool> isHostBomb(String gameCode, String userCode) async {
  bool result = true;
  DatabaseReference databaseref = FirebaseDatabase.instance
      .ref("games/" + gameCode + "/users/" + userCode + "/team");

  final event =
      await databaseref.once(DatabaseEventType.value).then((value) => {
            if (value.snapshot.value == "#1 Bomb" ||
                value.snapshot.value == "#2 Bomb")
              result = true
            else
              result = false
          });
  return result;
}
