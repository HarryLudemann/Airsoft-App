import 'package:Nguha/util/sound.dart';

bool _sound = true;
const BOMB_DEFUSED = 1001,
    BOMB_PLANTED = 1002,
    EXPLODED = 1003,
    GAME_STARTING = 1006,
    WAITING = 0,
    GO = 1000;
List<int> possibleStates = [
  0,
  1,
  2,
  3,
  10,
  30,
  45,
  60,
  120,
  300,
  600,
  900,
  1000,
  1001,
  1002,
  1003,
  1006
];

void _PlayMusic(String music) {
  if (!_sound) return;
  if (possibleStates.contains(music)) {
    PlayMusic(music + '.mp3');
  }
}

// function given gamestate or sound return text
String getTextPlaySound(int gameState, bool sound) {
  _sound = sound;

  switch (gameState) {
    case 10:
      _PlayMusic('10second');
      return "10 seconds";
    case 0:
      return "Waiting";
    case 1:
      _PlayMusic('1');
      return "1";
    case 2:
      _PlayMusic('2');
      return "2";
    case 3:
      _PlayMusic('3');
      return "3";
    case 30:
      _PlayMusic('30second');
      return "30 seconds";
    case 45:
      _PlayMusic('45second');
      return "45 seconds";
    case 60:
      _PlayMusic('1minute');
      return "1 minute";
    case 120:
      _PlayMusic('2minute');
      return "2 minutes";
    case 300:
      _PlayMusic('5minute');
      return "5 minutes";
    case 600:
      _PlayMusic('10minute');
      return "10 minutes";
    case 900:
      _PlayMusic('15minute');
      return "15 minutes";
    case 1000:
      _PlayMusic('go');
      return "GO!";
    case 1001:
      _PlayMusic('BombDefused');
      return "Bomb Defused";
    case 1002:
      _PlayMusic('BombPlanted');
      return "Bomb Planted";
    case 1003:
      _PlayMusic('explosion');
      return "Explosion";
    case 1006:
      return "Game Starting";
    default:
      return "Waiting";
  }
}
