import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';

class DatailScreen extends StatefulWidget {
  DatailScreen({required this.movie, super.key});
  Movie movie;
  @override
  State<DatailScreen> createState() => _DatailScreenState();
}

class _DatailScreenState extends State<DatailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.movie.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(children: [
          Image.network(
            TmdbApis().getImageUrl(300, widget.movie.posterPath),
          ),
          Text(widget.movie.title,
              style:
                  const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
          Row(
            children: [const Text("개봉일자: "), Text(widget.movie.releaseDate)],
          ),
          Row(
            children: [
              const Text("평점: "),
              Text("${widget.movie.voteAverage.toString()}/10.0")
            ],
          ),
          Row(
            children: [
              widget.movie.adult == true
                  ? const Text("청소년 관람 불가")
                  : const Text("청소년 관람 가능")
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Text(widget.movie.overview),
          const SizedBox(
            height: 20,
          ),
        ]),
      ),
    );
  }
}
