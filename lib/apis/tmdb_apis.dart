import 'package:dio/dio.dart';
import 'package:gdsc_movie_app/models/filtered_movies.dart';
import 'package:gdsc_movie_app/models/movie_detail.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';

final dio = Dio();

class TmdbApis {
//apiType : now_playing, popular, top_rated, upcoming
  Future<MoviesData> getData(String apiType, String apikey) async {
    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/$apiType?api_key=$apikey&language=en-US&page=1',
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;

      return MoviesData.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<MovieDetail> getDatailData(String movieId, String apikey) async {
    final response = await dio.get(
      'https://api.themoviedb.org/3/movie/$movieId?api_key=$apikey&language=en-US',
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = response.data;

      return MovieDetail.fromJson(data);
    } else {
      throw Exception('Failed to load data');
    }
  }

  String getImageUrl(int size, String path) {
    return "https://image.tmdb.org/t/p/w$size$path";
  }

  Future<List<FilteredMovie>> queryMovies(String movie, String apikey) async {
    Map<String, String> queryparm = {"query": movie};
    List<FilteredMovie> filteredMovies = [];

    final response = await dio.request(
        "https://api.themoviedb.org/3/search/movie?api_key=$apikey&language=en-US",
        queryParameters: queryparm);
    final List<dynamic> data = response.data["results"];

    filteredMovies = data.map((e) => FilteredMovie.fromJson(e)).toList();
    return filteredMovies;
  }
}
