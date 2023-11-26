import 'package:flutter/material.dart';
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
  final List<Movie> movieList = [];
  final SearchController _searchController = SearchController();

  @override
  void initState() {
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
                children: const [
                  MovieListCard(
                    title: "현재 상영중",
                    apiType: "now_playing",
                  ),
                  MovieListCard(
                    title: "인기순위",
                    apiType: "popular",
                  ),
                  MovieListCard(
                    title: "평점 높은 순",
                    apiType: "top_rated",
                  ),
                  MovieListCard(
                    title: "신작 영화",
                    apiType: "upcoming",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
