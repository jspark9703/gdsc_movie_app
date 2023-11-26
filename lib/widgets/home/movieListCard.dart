import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/models/movie_list.dart';

class MovieListCard extends StatefulWidget {
  const MovieListCard({required this.title, required this.movieList, Key? key})
      : super(key: key);

  final List<Movie> movieList;
  final String title;

  @override
  State<MovieListCard> createState() => _MovieListCardState();
}

class _MovieListCardState extends State<MovieListCard> {
  bool isImageLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: widget.movieList.length,
                  itemBuilder: (context, index) => SizedBox(
                    width: 160,
                    height: 400,
                    child: Column(
                      children: [
                        Image.network(
                          TmdbApis().getImageUrl(
                              200, widget.movieList[index].posterPath),
                        ),
                        Text(widget.movieList[index].title),
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
  }
}
