import 'package:gdsc_movie_app/constants/api_keys/api_keys.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';

// Define Events
abstract class MoviesEvent {}

class LoadMoviesEvent extends MoviesEvent {
  final String apiKey = ApiKey.tmbd;
  final String apiType;

  LoadMoviesEvent(this.apiType);
}

// Define States
abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

//apiType : now_playing, popular, top_rated, upcoming
class MoviesLoadedState extends MoviesState {
  final String apiType;
  final MoviesData moviesData;

  MoviesLoadedState({
    required this.apiType,
    required this.moviesData,
  });
}

class MoviesErrorState extends MoviesState {
  final String error;

  MoviesErrorState(this.error);
}
