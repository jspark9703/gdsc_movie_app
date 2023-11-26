import 'package:dio/dio.dart';
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

  String getImageUrl(int size, String path) {
    return "https://image.tmdb.org/t/p/w$size$path";
  }
}
