import 'package:firebase_database/firebase_database.dart';

Future<Map<String, String>> getSndInfo(String gamecode) async {
  Map<String, String> info = {};
  DatabaseReference databaseref =
      FirebaseDatabase.instance.ref("games/" + gamecode + "/info/");
  await databaseref.once(DatabaseEventType.value).then((value) => {
        if (value.snapshot.value != null)
          {info = value.snapshot.value as Map<String, String>}
      });

  for (var key in info.keys) {
    print("key: " + key + " value: " + info[key].toString());
  }

  return info;
}
