import 'package:cinema_app/movie/models/movie_detail_model.dart';
import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:cinema_app/movie/models/movie_video_model.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<String, MoviesResponseModels>>  getDiscover({int page = 1});
  Future<Either<String, MoviesResponseModels>>  getTopRated({int page = 1});
  Future<Either<String, MoviesResponseModels>>  getNowPlaying({int page = 1});
  Future<Either<String, MovieDetailModel>>  getDetail({required int id});
  Future<Either<String, MovieVideoModel>>  getVideos({required int id});
}