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

}