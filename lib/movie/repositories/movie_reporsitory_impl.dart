import 'package:cinema_app/movie/models/movie_detail_model.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:cinema_app/movie/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository{
  final Dio _dio;

  MovieRepositoryImpl(this._dio);

  @override
  Future<Either<String, MoviesResponseModels>> getDiscover({int page = 1}) async {
    try {
      final result = await _dio.get('/discover/movie', queryParameters: {'page' : page});
      
      if (result.statusCode == 200 && result.data != null) {
        final model = MoviesResponseModels.fromMap(result.data);
        return Right(model);
      }

      return const Left('Error get discover model');
    } on DioError catch(e) {
      if (e.response != null) {
      return left(e.response.toString());
      }
      return Left('Another error on get discover movies');

      throw e.toString();
    }

  }
  
  @override
  Future<Either<String, MoviesResponseModels>> getTopRated({int page = 1}) async {
    try {
    final result = await _dio.get(
      '/movie/top_rated', 
      queryParameters: {'page': page},);

    if (result.statusCode == 200 && result.data != null) {
      final model = MoviesResponseModels.fromMap(result.data);
      return Right(model);
    }

    return Left('Error get top rated movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return Left('another error on get top rated movies');
    }
  }
  
  @override
  Future<Either<String, MoviesResponseModels>> getNowPlaying({int page = 1}) async {
    try {
      final result = await _dio.get(
        '/movie/now_playing', 
        queryParameters: {'page': page}
      );

      
    if (result.statusCode == 200 && result.data != null) {
      final model = MoviesResponseModels.fromMap(result.data);
      return Right(model);
    }

    return Left('Error get now playing movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return Left('another error on get now playing movies');
    }
  }

  @override
  Future<Either<String, MovieDetailModel>> getDetail({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id'
      );

      
    if (result.statusCode == 200 && result.data != null) {
      final model = MovieDetailModel.fromMap(result.data);
      return Right(model);
    }

    return Left('Error get detail movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return Left('another error on get detail movies');
    }
  }
}