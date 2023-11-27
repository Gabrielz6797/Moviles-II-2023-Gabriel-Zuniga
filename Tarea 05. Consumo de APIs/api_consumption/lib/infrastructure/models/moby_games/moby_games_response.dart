class MobyGamesResponse {
  List<MobyGame> games;

  MobyGamesResponse({
    required this.games,
  });

  factory MobyGamesResponse.fromJson(Map<String, dynamic> json) =>
      MobyGamesResponse(
        games:
            List<MobyGame>.from(json["games"].map((x) => MobyGame.fromJson(x))),
      );
}

class MobyGame {
  List<AlternateTitle> alternateTitles;
  String description;
  int gameId;
  List<Genre> genres;
  double? mobyScore;
  String mobyUrl;
  int numVotes;
  dynamic officialUrl;
  List<Platform> platforms;
  Sample sampleCover;
  List<Sample> sampleScreenshots;
  String title;

  MobyGame({
    required this.alternateTitles,
    required this.description,
    required this.gameId,
    required this.genres,
    required this.mobyScore,
    required this.mobyUrl,
    required this.numVotes,
    required this.officialUrl,
    required this.platforms,
    required this.sampleCover,
    required this.sampleScreenshots,
    required this.title,
  });

  factory MobyGame.fromJson(Map<String, dynamic> json) => MobyGame(
        alternateTitles: List<AlternateTitle>.from(
            json["alternate_titles"].map((x) => AlternateTitle.fromJson(x))),
        description: json["description"],
        gameId: json["game_id"],
        genres: List<Genre>.from(json["genres"].map((x) => Genre.fromJson(x))),
        mobyScore: json["moby_score"]?.toDouble(),
        mobyUrl: json["moby_url"],
        numVotes: json["num_votes"],
        officialUrl: json["official_url"],
        platforms: List<Platform>.from(
            json["platforms"].map((x) => Platform.fromJson(x))),
        sampleCover: Sample.fromJson(json["sample_cover"]),
        sampleScreenshots: List<Sample>.from(
            json["sample_screenshots"].map((x) => Sample.fromJson(x))),
        title: json["title"],
      );
}

class AlternateTitle {
  String description;
  String title;

  AlternateTitle({
    required this.description,
    required this.title,
  });

  factory AlternateTitle.fromJson(Map<String, dynamic> json) => AlternateTitle(
        description: json["description"],
        title: json["title"],
      );
}

class Genre {
  String genreCategory;
  int genreCategoryId;
  int genreId;
  String genreName;

  Genre({
    required this.genreCategory,
    required this.genreCategoryId,
    required this.genreId,
    required this.genreName,
  });

  factory Genre.fromJson(Map<String, dynamic> json) => Genre(
        genreCategory: json["genre_category"],
        genreCategoryId: json["genre_category_id"],
        genreId: json["genre_id"],
        genreName: json["genre_name"],
      );
}

class Platform {
  String firstReleaseDate;
  int platformId;
  String platformName;

  Platform({
    required this.firstReleaseDate,
    required this.platformId,
    required this.platformName,
  });

  factory Platform.fromJson(Map<String, dynamic> json) => Platform(
        firstReleaseDate: json["first_release_date"],
        platformId: json["platform_id"],
        platformName: json["platform_name"],
      );
}

class Sample {
  int height;
  String image;
  List<String>? platforms;
  String thumbnailImage;
  int width;
  String? caption;

  Sample({
    required this.height,
    required this.image,
    this.platforms,
    required this.thumbnailImage,
    required this.width,
    this.caption,
  });

  factory Sample.fromJson(Map<String, dynamic> json) => Sample(
        height: json["height"],
        image: json["image"],
        platforms: json["platforms"] == null
            ? []
            : List<String>.from(json["platforms"]!.map((x) => x)),
        thumbnailImage: json["thumbnail_image"],
        width: json["width"],
        caption: json["caption"],
      );
}
