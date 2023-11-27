import 'package:api_consumption/domain/entities/video_game_info.dart';

abstract class VideoGamesDatasource {
  Future<List<VideoGameInfo>> getAllVideoGames(
      {int limit = 20, int offset = 0});
}
