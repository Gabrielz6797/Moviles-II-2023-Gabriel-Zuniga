import 'package:api_consumption/infrastructure/datasources/moby_video_game_datasource.dart';
import 'package:api_consumption/infrastructure/repositories/video_games_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final videoGameRepositoryProvider = Provider(
    (ref) => VideoGamesRepositoryImpl(datasource: MobyVideoGameDatasource()));
