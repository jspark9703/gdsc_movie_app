import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/bloc/movies_bloc.dart';
import 'package:gdsc_movie_app/constants/api_keys/api_keys.dart';

class PopMoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final TmdbApis tmdbApis;

  PopMoviesBloc(this.tmdbApis) : super(MoviesInitialState()) {
    on<LoadMoviesEvent>(_loadMoviesEventHandler);
  }

  void _loadMoviesEventHandler(
    LoadMoviesEvent event,
    Emitter<MoviesState> emit,
  ) async {
    try {
      emit(MoviesLoadingState());

      final moviesData = await tmdbApis.getData(event.apiType, ApiKey.tmbd);
      MoviesLoadedState(apiType: event.apiType, moviesData: moviesData);
      print(moviesData);
      //apiType : now_playing, popular, top_rated, upcoming
      emit(MoviesLoadedState(apiType: event.apiType, moviesData: moviesData));
    } catch (e) {
      emit(MoviesErrorState('Failed to load movies: $e'));
    }
  }
}
