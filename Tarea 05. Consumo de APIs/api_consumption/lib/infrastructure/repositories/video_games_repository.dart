import 'package:api_consumption/domain/datasources/video_games_datasource.dart';
import 'package:api_consumption/domain/entities/video_game_info.dart';
import 'package:api_consumption/domain/repositories/video_games_repository.dart';

class VideoGamesRepositoryImpl extends VideoGameRepository {
  final VideoGamesDatasource datasource;

  VideoGamesRepositoryImpl({required this.datasource});

  @override
  Future<List<VideoGameInfo>> getAllVideoGames(
      {int limit = 20, int offset = 0}) {
    return datasource.getAllVideoGames(limit: limit, offset: offset);
  }
}
