import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/bloc/now_playing_bloc.dart';
import 'package:gdsc_movie_app/bloc/popular_bloc.dart';
import 'package:gdsc_movie_app/bloc/top_rated_bloc.dart';
import 'package:gdsc_movie_app/bloc/upcoming_bloc.dart';
import 'package:gdsc_movie_app/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PopMoviesBloc(TmdbApis()),
            ),
            BlocProvider(
              create: (context) => NowMoviesBloc(TmdbApis()),
            ),
            BlocProvider(
              create: (context) => UpMoviesBloc(TmdbApis()),
            ),
            BlocProvider(
              create: (context) => TopMoviesBloc(TmdbApis()),
            )
          ],
          child: const MyHomePage(title: "GDSC MOVIE"),
        ));
  }
}
