import 'package:cinema_app/movie/models/movie_video_model.dart';
import 'package:cinema_app/movie/repositories/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieGetVideoProvider with ChangeNotifier {
  final MovieRepository _movieRepository;

  MovieGetVideoProvider(this._movieRepository);

  MovieVideoModel? _videos;
  MovieVideoModel? get videos => _videos;

  void getDetail(BuildContext context, {required int id}) async {
    _videos = null;
    notifyListeners();
    final result = await _movieRepository.getVideos(id: id);
    result.fold(
    (errorMessage) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage))
      );
      _videos = null;
      notifyListeners();
      return;
    }, 
    (response) {
      _videos = response;
      notifyListeners();
      return ;
    });
  }

  getVideos(BuildContext context, {required int id}) {}
}