import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/bloc/movies_bloc.dart';
import 'package:gdsc_movie_app/bloc/now_playing_bloc.dart';
import 'package:gdsc_movie_app/bloc/popular_bloc.dart';
import 'package:gdsc_movie_app/bloc/top_rated_bloc.dart';
import 'package:gdsc_movie_app/bloc/upcoming_bloc.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';
import 'package:gdsc_movie_app/widgets/home/movieListCard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggleMoreButton = true;
  List<Movie> popMovieList = [];
  List<Movie> upMovieList = [];
  List<Movie> topMovieList = [];
  List<Movie> nowMovieList = [];
  final SearchController _searchController = SearchController();

  @override
  void initState() {
    final popMoviesBloc = BlocProvider.of<PopMoviesBloc>(context);
    popMoviesBloc.add(LoadMoviesEvent('popular'));
    final nowMoviesBloc = BlocProvider.of<NowMoviesBloc>(context);
    nowMoviesBloc.add(LoadMoviesEvent('now_playing'));
    final upMoviesBloc = BlocProvider.of<UpMoviesBloc>(context);
    upMoviesBloc.add(LoadMoviesEvent('upcoming'));
    final topMoviesBloc = BlocProvider.of<TopMoviesBloc>(context);
    topMoviesBloc.add(LoadMoviesEvent('top_rated'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text("data")),
              const PopupMenuItem(
                child: Text("data"),
              ),
              const PopupMenuItem(
                child: Text("data"),
              ),
              const PopupMenuItem(
                child: Text("data"),
              )
            ],
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              height: 65,
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  borderRadius:
                      const BorderRadius.vertical(bottom: Radius.circular(5))),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: SearchBar(
                    controller: _searchController,
                    leading: const Icon(Icons.search)),
              ),
            ),
            //apiType : now_playing, popular, top_rated, upcoming
            Expanded(
              child: ListView(
                children: [
                  BlocBuilder<NowMoviesBloc, MoviesState>(
                      builder: (context, state) {
                    if (state is MoviesLoadedState) {
                      nowMovieList = state.moviesData.results;
                      return MovieListCard(
                        title: "현재 상영중",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    } else if (state is MoviesErrorState) {
                      return Text(
                          'Error: ${state.error}'); // Show error message
                    } else {
                      return const Text(
                          'No data available'); // Show a default message
                    }
                  }),
                  // popular
                  BlocBuilder<PopMoviesBloc, MoviesState>(
                      builder: (context, state) {
                    if (state is MoviesLoadedState) {
                      nowMovieList = state.moviesData.results;
                      return MovieListCard(
                        title: "인기 순위",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    } else if (state is MoviesErrorState) {
                      return Text(
                          'Error: ${state.error}'); // Show error message
                    } else {
                      return const Text(
                          'No data available'); // Show a default message
                    }
                  }),
                  //top
                  BlocBuilder<TopMoviesBloc, MoviesState>(
                      builder: (context, state) {
                    if (state is MoviesLoadedState) {
                      nowMovieList = state.moviesData.results;
                      return MovieListCard(
                        title: "평점 높은 순",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    } else if (state is MoviesErrorState) {
                      return Text(
                          'Error: ${state.error}'); // Show error message
                    } else {
                      return const Text(
                          'No data available'); // Show a default message
                    }
                  }),
                  //up

                  BlocBuilder<UpMoviesBloc, MoviesState>(
                      builder: (context, state) {
                    if (state is MoviesLoadedState) {
                      nowMovieList = state.moviesData.results;
                      return MovieListCard(
                        title: "개봉 예정",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const CircularProgressIndicator(); // Show loading indicator
                    } else if (state is MoviesErrorState) {
                      return Text(
                          'Error: ${state.error}'); // Show error message
                    } else {
                      return const Text(
                          'No data available'); // Show a default message
                    }
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
