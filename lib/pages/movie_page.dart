import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_app/api_constants.dart';
import 'package:cinema_app/movie/components/movie_now_playing_component.dart';
import 'package:cinema_app/movie/components/movie_toprated_components.dart';
import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
import 'package:cinema_app/movie/providers/movie_get_toprated_provider.dart';
import 'package:cinema_app/pages/movie_pagination.dart';
import 'package:cinema_app/pages/movie_search_page.dart';
import 'package:cinema_app/widget/image_widget.dart';
import 'package:cinema_app/widget/item_movie_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../movie/components/movie_discovery_componets.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Image.asset('assets/images/popcorn.png'),
                  ),
                ),
                const Text(
                  'Zola Movie'
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: () => showSearch(
                    context: context, 
                    delegate: MovieSearchPage()
                  ), 
                icon: const Icon(Icons.search)
              )
            ],
            floating: true,
            snap: true,
          ),
          _WidgetTitle(title: 'Temukan Film', onPressed: () {
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (_) => const MoviePaginationPage(type: TypeMovie.discover,),
            ),
          );
          },),
          const ComponentsCarouselMovie(),
          _WidgetTitle(title: 'Film Rating Tertinggi', onPressed: () {
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (_) => const MoviePaginationPage(type: TypeMovie.top_rated,),
            ),
          );
          },),
          const ComponentsTopRatedMovie(),
          _WidgetTitle(title: 'Film Sedang Tayang', onPressed: () {
            Navigator.push(
            context, 
            MaterialPageRoute(
              builder: (_) => const MoviePaginationPage(type: TypeMovie.now_playing,),
            ),
          );
          },),
          const MovieNowPlayingComponent(),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 20,
            ),
          )
        ],
      )
    );
  }
}

class _WidgetTitle extends SliverToBoxAdapter {
  final title;
  final void Function() onPressed;

  _WidgetTitle({required this.title, required this.onPressed});

  @override
  Widget? get child => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
            color: Colors.white
          ),
        ),
        OutlinedButton(onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: Colors.white,
          shape: const StadiumBorder(),
          side: const BorderSide(
            color: Colors.white70,
          )
        ),

        child: const Text(
          'Lihat Semua'
        ))
      ],
    ),
  );
}
