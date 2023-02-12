import 'package:cinema_app/api_constants.dart';
import 'package:cinema_app/movie/providers/movie_get_detail_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_now_playing_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_toprated_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_video_provider.dart';
import 'package:cinema_app/movie/repositories/movie_reporsitory_impl.dart';
import 'package:cinema_app/movie/repositories/movie_repository.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final sL = GetIt.instance;

void setup() {

  // Register Provider
  sL.registerFactory<MovieGetDiscoverProvider>(
    () => MovieGetDiscoverProvider(sL()),
  );
  sL.registerFactory<MovieGetTopRatedProvider>(
    () => MovieGetTopRatedProvider(sL()),
  );
  sL.registerFactory<MovieGetNowPlayingProvider>(
    () => MovieGetNowPlayingProvider(sL()),
  );
  sL.registerFactory<MovieGetDetailProvider>(
    () => MovieGetDetailProvider(sL()),
  );
  sL.registerFactory<MovieGetVideoProvider>(
    () => MovieGetVideoProvider(sL()),
  );

  
  // Register Repository
  sL.registerLazySingleton<MovieRepository>(() => MovieRepositoryImpl(sL()),);


  // Register Http Client (DIO)
  sL.registerLazySingleton<Dio>(
    () => Dio(
    BaseOptions(
      baseUrl: ApiConstant.baseUrl,
      queryParameters: {'api_key': ApiConstant.apiKey},
    ),
  ));
}