import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/constants/api_keys/api_keys.dart';
import 'package:gdsc_movie_app/models/filtered_movies.dart';
import 'package:gdsc_movie_app/screens/movie_detail.dart';

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
      return TextButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DatailScreen(
                  movieId: e.id,
                );
              },
            ));
            setState(() {
              controller.text = e.title;
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                e.title,
                overflow: TextOverflow.clip,
              ),
              Text("평점 : ${e.voteAverage}")
            ],
          ));
    });
  }
}
