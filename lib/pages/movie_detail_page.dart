import 'package:cinema_app/movie/providers/movie_get_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => MovieGetDetailProvider(_movieRepository),
    builder: (_, __) => const Scaffold(),
    );
  }
}