import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<String, MoviesResponseModels>>  getDiscover({int page = 1});
}