import 'package:cinema_app/injector.dart';
import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_now_playing_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_toprated_provider.dart';
import 'package:cinema_app/movie/providers/movie_search_provider.dart';
import 'package:cinema_app/movie/repositories/movie_reporsitory_impl.dart';
import 'package:cinema_app/movie/repositories/movie_repository.dart';
import 'package:cinema_app/pages/movie_page.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:cinema_app/api_constants.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  setup();

  runApp(const App());
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key});


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => sL<MovieGetDiscoverProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sL<MovieGetTopRatedProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sL<MovieGetNowPlayingProvider>(),
        ),
        ChangeNotifierProvider(
          create: (_) => sL<MovieSearchProvider>(),
        ),
      ],

      child: MaterialApp(
        title: 'Zola Movie',
        theme: ThemeData.dark(
),
        home: const MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}