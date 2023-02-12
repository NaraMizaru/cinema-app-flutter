import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:cinema_app/movie/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieSearchProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieSearchProvider(this._movieRepository);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  final List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  void search(BuildContext context, {required String query}) async {
    _isLoading = true;
    notifyListeners();

    final result = await _movieRepository.searchMovies(query: query);
    result.fold(
      (errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(errorMessage)));
        
        _isLoading = false;
        notifyListeners();
        return;

      }, 
      (response) {
        _movies.clear();
        _movies.addAll(response.results);
        
        _isLoading = false;
        notifyListeners();
        
        return;
      },
    );
  }
}