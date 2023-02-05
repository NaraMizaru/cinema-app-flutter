import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
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
  
  final dioOptions = BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    queryParameters: {'api_key': ApiConstant.apiKey},
  );
  final Dio dio = Dio(dioOptions);
  final MovieRepository movieRepository = MovieRepositoryImpl(dio);

  runApp(App(movieRepository: movieRepository));
  FlutterNativeSplash.remove();
}

class App extends StatelessWidget {
  const App({super.key, required this.movieRepository});

  final MovieRepository movieRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieGetDiscoverProvider(movieRepository)), 
      ],

      child: MaterialApp(
        title: 'Popcorn Cinema',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MoviePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}