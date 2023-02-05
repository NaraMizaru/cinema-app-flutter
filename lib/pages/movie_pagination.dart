import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
import 'package:cinema_app/widget/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:provider/provider.dart';

class MoviePaginationPage extends StatefulWidget {
  const MoviePaginationPage({super.key});

  @override
  State<MoviePaginationPage> createState() => _MoviePaginationPageState();
}

class _MoviePaginationPageState extends State<MoviePaginationPage> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      context.read<MovieGetDiscoverProvider>().getDiscoverWithPaging(
        context, 
        pagingController: _pagingController, 
        page: pageKey);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Temukan Film',
        ),
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white70,
        elevation: 0.5,
      ),
      body: PagedListView.separated(
      padding: EdgeInsets.all(16),
      pagingController: _pagingController, 
      builderDelegate: PagedChildBuilderDelegate<MovieModel>(itemBuilder: (context, item, index) => ItemMovieWidget(
        movie: item, 
        heightBackdrop: 260, 
        widthBackdrop: double.infinity, 
        heightPoster: 140, 
        widthPoster: 80
      )), 
      separatorBuilder: (context, index) => SizedBox(height: 10,)),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}