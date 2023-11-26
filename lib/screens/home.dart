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
    var key1 = GlobalKey();
    var key2 = GlobalKey();
    var key3 = GlobalKey();
    var key4 = GlobalKey();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              List<GlobalKey> keys = [key1, key2, key3, key4];
              List<String> apiTypes = [
                "now_playing",
                "popular",
                "top_rated",
                "upcoming"
              ];
              List<PopupMenuItem> items = [];
              for (int i = 1; i <= 4; i++) {
                items.add(
                  PopupMenuItem(
                    child: TextButton(
                      onPressed: () {
                        Scrollable.ensureVisible(
                          keys[i - 1].currentContext!,
                        );
                      },
                      child: Text(apiTypes[i - 1]),
                    ),
                  ),
                );
              }
              return items;
            },
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
                        key: key1,
                        title: "현재 상영중",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Show loading indicator
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
                        key: key2,
                        title: "인기 순위",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Show loading indicator
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
                        key: key3,
                        title: "평점 높은 순",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Show loading indicator
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
                        key: key4,
                        title: "개봉 예정",
                        movieList: nowMovieList,
                      );
                    } else if (state is MoviesLoadingState) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Show loading indicator
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
