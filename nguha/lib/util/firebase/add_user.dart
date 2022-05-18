import 'package:firebase_database/firebase_database.dart';
import 'package:Nguha/util/firebase/random_user_code.dart';

// given name and game code, generates random user code and adds user to game
// return user code
// add user given optional team
Future<String> addUser(String name, String gameCode,
    {String team = "Def"}) async {
  String userCode = await getRandomUserCode(gameCode);
  DatabaseReference databaseref =
      FirebaseDatabase.instance.ref("games/" + gameCode + "/users/");
  int count = await databaseref.once().then((snapshot) {
    return snapshot.snapshot.children.length;
  });
  if (team == "Def" && count % 2 == 0) {
    team = 'Red';
  } else if (team == "Def") {
    team = 'Blue';
  }
  databaseref.child(userCode).set({
    "name": name,
    "team": team,
  });
  return userCode;
}
