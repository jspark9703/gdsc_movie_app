import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gdsc_movie_app/apis/tmdb_apis.dart';
import 'package:gdsc_movie_app/bloc/now_playing_bloc.dart';
import 'package:gdsc_movie_app/bloc/popular_bloc.dart';
import 'package:gdsc_movie_app/bloc/top_rated_bloc.dart';
import 'package:gdsc_movie_app/bloc/upcoming_bloc.dart';
import 'package:gdsc_movie_app/screens/detail.dart';
import 'package:gdsc_movie_app/screens/home.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (constext, state) => MultiBlocProvider(
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
      ),
      routes: [
        GoRoute(
          path: 'detail/:movieId',
          name: "detail",
          builder: (context, state) =>
              DetailScreen(movieId: state.pathParameters["movieId"].toString()),
        ),
        GoRoute(
          path: 'sign-in',
          builder: (context, state) {
            return SignInScreen(
              actions: [
                ForgotPasswordAction(((context, email) {
                  final uri = Uri(
                    path: '/sign-in/forgot-password',
                    queryParameters: <String, String?>{
                      'email': email,
                    },
                  );
                  context.push(uri.toString());
                })),
                AuthStateChangeAction(((context, state) {
                  final user = switch (state) {
                    SignedIn state => state.user,
                    UserCreated state => state.credential.user,
                    _ => null
                  };
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/');
                })),
              ],
            );
          },
          routes: [
            GoRoute(
              path: 'forgot-password',
              builder: (context, state) {
                final arguments = state.pathParameters;
                return ForgotPasswordScreen(
                  email: arguments['email'],
                  headerMaxExtent: 200,
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'profile',
          builder: (context, state) {
            return ProfileScreen(
              providers: const [],
              actions: [
                SignedOutAction((context) {
                  context.pushReplacement('/');
                }),
              ],
            );
          },
        ),
      ],
    ),
  ],
);
