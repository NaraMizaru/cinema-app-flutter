import 'package:cinema_app/movie/models/movie_detail_model.dart';
import 'package:cinema_app/movie/models/movie_video_model.dart';
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
      return const Left('Another error on get discover movies');

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

    return const Left('Error get top rated movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('another error on get top rated movies');
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

    return const Left('Error get now playing movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('another error on get now playing movies');
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

    return const Left('Error get detail movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('another error on get detail movies');
    }
  }

  @override
  Future<Either<String, MovieVideoModel>> getVideos({required int id}) async {
    try {
      final result = await _dio.get(
        '/movie/$id/videos'
      );

      
    if (result.statusCode == 200 && result.data != null) {
      final model = MovieVideoModel.fromMap(result.data);
      return Right(model);
    }

    return const Left('Error get video movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('another error on get video movies');
    }
  }
  
  @override
  Future<Either<String, MoviesResponseModels>> searchMovies({
    required String query,
  }) async {
    try {
      final result = await _dio.get(
        '/search/movie',
        queryParameters: {"query" : query}
      );

      
    if (result.statusCode == 200 && result.data != null) {
      final model = MoviesResponseModels.fromMap(result.data);
      return Right(model);
    }

    return const Left('Error search movies');

    } on DioError catch (e) {
      if (e.response != null) {
        return Left(e.response.toString());
      }

      return const Left('another error on search movies');
    }
  
  }
}