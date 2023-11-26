import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/bloc/popular_movies_bloc.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';

class MovieListCard extends StatefulWidget {
  const MovieListCard({required this.title, required this.apiType, Key? key})
      : super(key: key);

  final String apiType;
  final String title;

  @override
  State<MovieListCard> createState() => _MovieListCardState();
}

//apiType : now_playing, popular, top_rated, upcoming
class _MovieListCardState extends State<MovieListCard> {
  bool isImageLoading = true;
  @override
  void initState() {
    final moviesBloc = BlocProvider.of<PopularMoviesBloc>(context);
    moviesBloc.add(LoadMoviesEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PopularMoviesBloc, MoviesState>(
      buildWhen: (prev, curr) => prev != curr,
      builder: (context, state) {
        if (state is MoviesLoadedState) {
          final List<Movie> movies = state.movies.results;
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 335,
                child: Column(
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Expanded(
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: movies.length,
                        itemBuilder: (context, index) => SizedBox(
                          width: 160,
                          height: 400,
                          child: Column(
                            children: [
                              Image.network(
                                TmdbApis()
                                    .getImageUrl(200, movies[index].posterPath),
                              ),
                              Text(movies[index].title),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is MoviesLoadingState) {
          return const Center(
              child: CircularProgressIndicator()); // Show loading indicator
        } else if (state is MoviesErrorState) {
          return Text('Error: ${state.error}'); // Show error message
        } else {
          return const Text('No data available'); // Show a default message
        }
      },
    );
  }
}
