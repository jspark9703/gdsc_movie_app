import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/constants/api_keys/api_keys.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';

// Define Events
abstract class MoviesEvent {}

class LoadMoviesEvent extends MoviesEvent {
  final String apiKey = ApiKey.tmbd;

  LoadMoviesEvent();
}

// Define States
abstract class MoviesState {}

class MoviesInitialState extends MoviesState {}

class MoviesLoadingState extends MoviesState {}

class MoviesLoadedState extends MoviesState {
  final MoviesData movies;

  MoviesLoadedState(this.movies);
}

class MoviesErrorState extends MoviesState {
  final String error;

  MoviesErrorState(this.error);
}

// Define BLoC
class PopularMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final TmdbApis tmdbApis;

  PopularMoviesBloc(this.tmdbApis) : super(MoviesInitialState()) {
    on<LoadMoviesEvent>(_loadMoviesEventHandler);
  }

  void _loadMoviesEventHandler(
    LoadMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      emit(MoviesLoadingState());

      final moviesData = await tmdbApis.getData("popular", ApiKey.tmbd);

      emit(MoviesLoadedState(moviesData));
    } catch (e) {
      emit(MoviesErrorState('Failed to load movies: $e'));
    }
  }
}
