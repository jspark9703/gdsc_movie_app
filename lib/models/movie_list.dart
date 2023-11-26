class Movie {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String posterPath;
  final String releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      adult: json['adult'] as bool,
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List).map((e) => e as int).toList(),
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String,
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      popularity: json['popularity'] as double,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
      title: json['title'] as String,
      video: json['video'] as bool,
      voteAverage: json['vote_average'] as double,
      voteCount: json['vote_count'] as int,
    );
  }
}

class MoviesData {
  final int page;
  final List<Movie> results;
  final int totalPages;
  final int totalResults;

  MoviesData({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesData.fromJson(Map<String, dynamic> json) {
    final results =
        (json['results'] as List).map((e) => Movie.fromJson(e)).toList();

    return MoviesData(
      page: json['page'] as int,
      results: results,
      totalPages: json['total_pages'] as int,
      totalResults: json['total_results'] as int,
    );
  }
}
