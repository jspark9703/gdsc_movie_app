import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/bloc/popular_bloc.dart';
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
        home: BlocProvider(
          create: (context) => PopMoviesBloc(TmdbApis()),
          child: const MyHomePage(title: "GDSC MOVIE"),
        ));
  }
}
