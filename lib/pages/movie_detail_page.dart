import 'package:cinema_app/injector.dart';
import 'package:cinema_app/movie/providers/movie_get_detail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => sL<MovieGetDetailProvider>()..getDetail(context, id: id),
    builder: (_, __) =>  Scaffold(
        body: CustomScrollView(
          slivers: [
            Consumer<MovieGetDetailProvider>(
              builder: (__, provider, ___) {
                return SliverAppBar(
                  title: Text(
                    provider.movie != null ? provider.movie!.title : '',
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}