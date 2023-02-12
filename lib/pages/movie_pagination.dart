import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_now_playing_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_toprated_provider.dart';
import 'package:cinema_app/pages/movie_detail_page.dart';
import 'package:cinema_app/widget/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

enum TypeMovie {discover, top_rated, now_playing}

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key, required this.type});

  final TypeMovie type;

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {

      switch (widget.type) {
        case TypeMovie.discover:
          context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(
            context, 
            pagingController: _pagingController, 
            page: pageKey
            );
          break;
        case TypeMovie.top_rated:
        context.read<MovieGetTopRatedProvider>().getTopRatedWithPaging(
            context, 
            pagingController: _pagingController, 
            page: pageKey
            );
          break;
          case TypeMovie.now_playing:
        context.read<MovieGetNowPlayingProvider>().getNowPlayingWithPaging(
            context, 
            pagingController: _pagingController, 
            page: pageKey
            );
          break;
      }


    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Builder(
          builder: (_) {
            switch (widget.type) {
              case TypeMovie.discover:
                return const Text(
                  'Temukan Film',
                );
              case TypeMovie.top_rated:
                return const Text(
                  'Film Rating Tertinggi',
                );
                case TypeMovie.now_playing:
                return const Text(
                  'Film Sedang Tayang',
                );
              
            }
          }
        ),
        elevation: 0.5,
      ),
      body: PagedListView.separated(
      padding: const EdgeInsets.all(16),
      pagingController: _pagingController, 
      builderDelegate: PagedChildBuilderDelegate<MovieModel>(itemBuilder: (context, item, index) => ItemMovieWidget(
        movie: item, 
        heightBackdrop: 260, 
        widthBackdrop: double.infinity, 
        heightPoster: 140, 
        widthPoster: 80,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return MovieDetailPage(id: item.id);
          }));
        },
      )), 
      separatorBuilder: (context, index) => const SizedBox(height: 10,)),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}