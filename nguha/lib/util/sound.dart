import 'package:flame_audio/flame_audio.dart';

void PlayMusic(String music) {
  FlameAudio.play(music + '.mp3');
}
