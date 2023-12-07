import 'package:space_battles/game/audio_player_component.dart';
import 'package:space_battles/models/bgm.dart';
import 'package:space_battles/models/spaceship.dart';

class PlayerData {
  static late Spaceship spaceship;
  static late BGM bgm;
  static late AudioPlayerComponent audioPlayerComponent;

  static void initialize() {
    spaceship = Spaceship.fromMap(Spaceship.defaultData);
    bgm = BGM.fromMap(BGM.defaultData);
    audioPlayerComponent = AudioPlayerComponent();
  }
}
