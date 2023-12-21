import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/constants/api_keys/api_keys.dart';
import 'package:gdsc_movie_app/models/filtered_movies.dart';
import 'package:go_router/go_router.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final SearchController _searchController = SearchController();
  List<FilteredMovie> filteredMovies = [];
  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      searchController: _searchController,
      suggestionsBuilder: (context, controller) async {
        await TmdbApis()
            .queryMovies(controller.text, ApiKey.tmbd)
            .then((value) {
          setState(() {
            filteredMovies = value;
          });
        });

        Iterable<Widget> suggestions =
            getSuggestion(filteredMovies, controller);

        return suggestions.toList();
      },
      barHintText: "영화를 검색하세요",
    );
  }

  Iterable<Widget> getSuggestion(
      List<FilteredMovie> filteredMovies, SearchController controller) {
    return filteredMovies.map((e) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextButton(
            onPressed: () {
              context.goNamed("detail",
                  pathParameters: {"movieId": e.id.toString()});

              setState(() {
                controller.text = e.title;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.network(
                  TmdbApis().getImageUrl(300, e.posterPath),
                  height: 110,
                ),
                SizedBox(
                  width: 200,
                  child: Text(
                    e.title,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text("평점 : ${e.voteAverage}")
              ],
            )),
      );
    });
  }
}
