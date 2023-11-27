import 'package:api_consumption/domain/datasources/video_games_datasource.dart';
import 'package:api_consumption/domain/entities/video_game_info.dart';
import 'package:api_consumption/infrastructure/mappers/video_game_info_mapper.dart';
import 'package:api_consumption/infrastructure/models/moby_games/moby_games_response.dart';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MobyVideoGameDatasource extends VideoGamesDatasource {
  @override
  Future<List<VideoGameInfo>> getAllVideoGames(
      {int limit = 20, int offset = 0}) async {
    final dio = Dio(BaseOptions(baseUrl: 'https://api.mobygames.com/v1'));

    final apiKey = dotenv.env["KEY"];

    final response =
        await dio.get('/games?api_key=$apiKey&limit=$limit&offset=$offset');

    final mobyResponse = MobyGamesResponse.fromJson(response.data).games;
    final List<VideoGameInfo> games = mobyResponse
        .map((mobyGame) => VideoGameInfoMapper.mobyGameToEntity(mobyGame))
        .toList();

    return games;
  }
}

// https://api.mobygames.com/v1/games?api_key=moby_4HuZDQODgsPGt5rMmx4CN1UxUeS&limit=20&offset=0