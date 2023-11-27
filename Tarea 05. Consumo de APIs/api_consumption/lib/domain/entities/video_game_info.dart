class VideoGameInfo {
  String description;
  int gameId;
  List<EntityGenre> genres;
  double? score;
  String url;
  int votes;
  List<EntityPlatform> platforms;
  EntitySample sampleCover;
  String title;

  VideoGameInfo({
    required this.description,
    required this.gameId,
    required this.genres,
    required this.score,
    required this.url,
    required this.votes,
    required this.platforms,
    required this.sampleCover,
    required this.title,
  });
}

class EntityGenre {
  String genreCategory;
  int genreCategoryId;
  int genreId;
  String genreName;

  EntityGenre({
    required this.genreCategory,
    required this.genreCategoryId,
    required this.genreId,
    required this.genreName,
  });
}

class EntityPlatform {
  String firstReleaseDate;
  int platformId;
  String platformName;

  EntityPlatform({
    required this.firstReleaseDate,
    required this.platformId,
    required this.platformName,
  });
}

class EntitySample {
  int height;
  String image;
  String thumbnailImage;
  int width;
  String? caption;

  EntitySample({
    required this.height,
    required this.image,
    required this.thumbnailImage,
    required this.width,
    this.caption,
  });
}
