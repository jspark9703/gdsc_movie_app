class MovieDetail {
  final bool adult;
  final String? backdropPath;
  final int budget;
  final List<Genre> genres;
  final String homepage;
  final int id;
  final String imdbId;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompany> productionCompanies;
  final List<ProductionCountry> productionCountries;
  final String releaseDate;
  final int revenue;
  final int runtime;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  MovieDetail({
    required this.adult,
    this.backdropPath,
    required this.budget,
    required this.genres,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.productionCompanies,
    required this.productionCountries,
    required this.releaseDate,
    required this.revenue,
    required this.runtime,
    required this.spokenLanguages,
    required this.status,
    required this.tagline,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    final genresList =
        (json['genres'] as List).map((genre) => Genre.fromJson(genre)).toList();

    final productionCompaniesList = (json['production_companies'] as List)
        .map((company) => ProductionCompany.fromJson(company))
        .toList();

    final productionCountriesList = (json['production_countries'] as List)
        .map((country) => ProductionCountry.fromJson(country))
        .toList();

    final spokenLanguagesList = (json['spoken_languages'] as List)
        .map((language) => SpokenLanguage.fromJson(language))
        .toList();

    return MovieDetail(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      budget: json['budget'] as int,
      genres: genresList,
      homepage: json['homepage'] as String,
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      popularity: json['popularity'] as double,
      posterPath: json['poster_path'] as String,
      productionCompanies: productionCompaniesList,
      productionCountries: productionCountriesList,
      releaseDate: json['release_date'] as String,
      revenue: json['revenue'] as int,
      runtime: json['runtime'] as int,
      spokenLanguages: spokenLanguagesList,
      status: json['status'] as String,
      tagline: json['tagline'] as String,
      title: json['title'] as String,
      video: json['video'] as bool,
      voteAverage: json['vote_average'] as double,
      voteCount: json['vote_count'] as int,
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class ProductionCompany {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;

  ProductionCompany({
    required this.id,
    this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] as int,
      logoPath: json['logo_path'] as String?,
      name: json['name'] as String,
      originCountry: json['origin_country'] as String,
    );
  }
}

class ProductionCountry {
  final String iso_3166_1;
  final String name;

  ProductionCountry({
    required this.iso_3166_1,
    required this.name,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) {
    return ProductionCountry(
      iso_3166_1: json['iso_3166_1'] as String,
      name: json['name'] as String,
    );
  }
}

class SpokenLanguage {
  final String englishName;
  final String iso_639_1;
  final String name;

  SpokenLanguage({
    required this.englishName,
    required this.iso_639_1,
    required this.name,
  });

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) {
    return SpokenLanguage(
      englishName: json['english_name'] as String,
      iso_639_1: json['iso_639_1'] as String,
      name: json['name'] as String,
    );
  }
}
