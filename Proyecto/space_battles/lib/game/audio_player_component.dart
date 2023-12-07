import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:space_battles/models/bgm.dart';

class AudioPlayerComponent extends Component {
  @override
  Future<void>? onLoad() async {
    FlameAudio.bgm.initialize();

    final audios = [
      'laser1.ogg',
      'laserSmall_000.ogg',
      'laserSmall_001.ogg',
      ...BGM.getNames(BGM.bgms),
    ];

    await FlameAudio.audioCache.loadAll(audios);

    return super.onLoad();
  }

  void playBGM(String fileName) {
    FlameAudio.bgm.play(fileName);
  }

  void playSFX(String fileName) {
    FlameAudio.play(fileName);
  }

  void stopBGM() {
    FlameAudio.bgm.stop();
  }
}
