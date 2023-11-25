import 'package:flutter/material.dart';
import 'package:gdsc_movie_app/widgets/home/movieListCard.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool toggleMoreButton = true;
  final SearchController _searchController = SearchController();
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
              color: Theme.of(context).colorScheme.inversePrimary,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
                child: SearchBar(
                    controller: _searchController,
                    leading: const Icon(Icons.search)),
              ),
            ),
            Expanded(
              child: ListView(
                children: const [
                  MovieListCard(
                    title: "나는 바보다",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MovieListCard(
                    title: "나는 바보다",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MovieListCard(
                    title: "나는 바보다",
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  MovieListCard(
                    title: "나는 바보다",
                  ),
                  SizedBox(
                    height: 20,
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
