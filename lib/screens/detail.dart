import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/apis/firebase.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/constants/api_keys/api_keys.dart';
import 'package:gdsc_movie_app/models/movie_detail.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';
import 'package:gdsc_movie_app/widgets/commons/movieListCard.dart';
import 'package:gdsc_movie_app/widgets/detail/detail_comment.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/commons/auth_func.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({required this.movieId, super.key});
  String movieId;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final List<MovieDetail> detail = [];
  late List<Movie> similarMovies = [];
  bool isLoading = true;
  bool hasSimilar = true;
  @override
  void initState() {
    try {
      TmdbApis().getDatailData(widget.movieId, ApiKey.tmbd).then((value) {
        setState(() {
          isLoading = false;
          detail.add(value);
        });
      });
    } catch (e) {
      Logger().e(e);
    }
    try {
      TmdbApis().getSimilarMovies(widget.movieId, ApiKey.tmbd).then(
        (value) {
          Logger().d(value.results);
          setState(() {
            if (value.results.isEmpty) hasSimilar = false;
            similarMovies = value.results;
          });
        },
      );
    } catch (e) {
      Logger().e(e);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Logger().d(similarMovies);
    return !isLoading
        ? Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.inversePrimary,
              title: Text(detail[0].title),
              actions: [
                Consumer<ApplicationState>(
                  builder: (context, appState, _) => AuthFunc(
                      loggedIn: appState.loggedIn,
                      signOut: () {
                        FirebaseAuth.instance.signOut();
                      }),
                ),
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView(children: [
                Image.network(
                  TmdbApis().getImageUrl(300, detail[0].posterPath),
                  height: 500,
                ),
                Text(detail[0].title,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold)),
                Row(
                  children: [const Text("개봉일자: "), Text(detail[0].releaseDate)],
                ),
                Row(
                  children: [
                    const Text("상영시간: "),
                    Text("${detail[0].runtime.toString()}분")
                  ],
                ),
                Row(
                  children: [
                    const Text("평점: "),
                    Text("${detail[0].voteAverage}/10.0")
                  ],
                ),
                Row(
                  children: [
                    detail[0].adult == true
                        ? const Text("청소년 관람 불가")
                        : const Text("청소년 관람 가능")
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(detail[0].overview),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      launchUrl(Uri.parse(detail[0].homepage));
                    },
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white),
                    child: const Text(
                      "홈페이지 방문하기",
                    )),
                const SizedBox(
                  height: 20,
                ),
                similarMovies.isNotEmpty
                    ? MovieListCard(
                        movieList: similarMovies,
                        title: "Similar movies",
                      )
                    : const Center(
                        child: Text("Similar movies are not founded")),
                const Divider(
                  height: 20,
                ),
                DetailComment(movieId: widget.movieId.toString()),
              ]),
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
          );
  }
}
