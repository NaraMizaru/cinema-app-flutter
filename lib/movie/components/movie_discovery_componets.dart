import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
import 'package:cinema_app/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widget/item_movie_widget.dart';

class ComponentsCarouselMovie extends StatefulWidget {
  const ComponentsCarouselMovie({super.key});

  @override
  State<ComponentsCarouselMovie> createState() => _ComponentsCarouselMovieState();
}

class _ComponentsCarouselMovieState extends State<ComponentsCarouselMovie> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MovieGetDiscoverProvider>().getDiscover(context);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Consumer<MovieGetDiscoverProvider>(
        builder: (_, provider, __) {
          if (provider.isLoading) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(12), 
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
            itemCount: provider.movies.length, 
            itemBuilder: (_, index, __) {
              final movie = provider.movies[index];
              return ItemMovieWidget(
                movie: movie, 
                heightBackdrop: 300, 
                widthBackdrop: double.infinity,
                heightPoster: 200,
                widthPoster: 100,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return MovieDetailPage(id: movie.id);
                  }));
                },
              );
            }, 
            options: CarouselOptions(
              height: 300.0,
              viewportFraction: 0.8,
              reverse: false,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              )
            );
          }

          return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              height: 300.0,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12), 
              ),
              child: const Center(
                child: Text(
                  'Not found discover movies',
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                ),
              ),
            );
        },
      ),
    );
  }
}