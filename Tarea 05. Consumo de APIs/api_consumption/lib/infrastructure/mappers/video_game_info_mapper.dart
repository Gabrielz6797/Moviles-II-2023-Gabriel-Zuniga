import 'package:api_consumption/domain/entities/video_game_info.dart';
import 'package:api_consumption/infrastructure/models/moby_games/moby_games_response.dart';

class VideoGameInfoMapper {
  static VideoGameInfo mobyGameToEntity(MobyGame mobyGame) => VideoGameInfo(
      description: mobyGame.description,
      gameId: mobyGame.gameId,
      genres: mobyGame.genres
          .map((genre) => EntityGenre(
              genreCategory: genre.genreCategory,
              genreCategoryId: genre.genreCategoryId,
              genreId: genre.genreId,
              genreName: genre.genreName))
          .toList(),
      score: mobyGame.mobyScore,
      url: mobyGame.mobyUrl,
      votes: mobyGame.numVotes,
      platforms: mobyGame.platforms
          .map((platform) => EntityPlatform(
              firstReleaseDate: platform.firstReleaseDate,
              platformId: platform.platformId,
              platformName: platform.platformName))
          .toList(),
      sampleCover: EntitySample(
          height: mobyGame.sampleCover.height,
          image: mobyGame.sampleCover.image,
          thumbnailImage: mobyGame.sampleCover.thumbnailImage,
          width: mobyGame.sampleCover.width,
          caption: mobyGame.sampleCover.caption),
      title: mobyGame.title);
}
