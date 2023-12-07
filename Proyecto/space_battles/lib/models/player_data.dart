import 'package:space_battles/models/spaceship.dart';

class PlayerData {
  static late Spaceship spaceship;

  static void initialize() {
    spaceship = Spaceship.fromMap(Spaceship.defaultData);
  }
}
