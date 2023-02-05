import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_app/api_constants.dart';
import 'package:cinema_app/movie/models/movie_models.dart';
import 'package:cinema_app/movie/providers/movie_get_discover_provider.dart';
import 'package:cinema_app/widget/image_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                  'Popcorn Movie'
                ),
              ],
            ),
            backgroundColor: Colors.black87,
            foregroundColor: Colors.white70,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Temukan Film',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0
                    ),
                  ),
                  OutlinedButton(onPressed: () {}, 
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.black,
                    shape: const StadiumBorder(),
                    side: const BorderSide(
                      color: Colors.black54,
                    )
                  ),

                  child: Text(
                    'Lihat Semua'
                  ))
                ],
              ),
            ),
          ),
          WidgetCarouselMovie(),
        ],
      )
    );
  }
}

class WidgetCarouselMovie extends StatefulWidget {
  const WidgetCarouselMovie({super.key});

  @override
  State<WidgetCarouselMovie> createState() => _WidgetCarouselMovieState();
}

class _WidgetCarouselMovieState extends State<WidgetCarouselMovie> {
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
                color: Colors.black26,
                borderRadius: BorderRadius.circular(12), 
              ),
            );
          }

          if (provider.movies.isNotEmpty) {
            return CarouselSlider.builder(
            itemCount: provider.movies.length, 
            itemBuilder: (_, index, __) {
              final movie = provider.movies[index];
              return ItemMovie(movie);
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

class ItemMovie extends Container {
  
  final MovieModel movie;
  ItemMovie(this.movie, {super.key});

  @override
  Clip get clipBehavior => Clip.hardEdge;

  @override
  Decoration? get decoration => BoxDecoration(
    borderRadius: BorderRadius.circular(15),
  );

  @override
  Widget? get child => Stack(
    children: [
      ImageNetworkWidget(
        imageSrc: '${movie.backdropPath}',
        height: 300.0,
        width: double.infinity,
      ),
      Container(
        height: 300.0,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black87,
          ]),
        ),
      ),
      Positioned(
        bottom: 16.0,
        left: 16.0,
        right: 16.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageNetworkWidget(
              imageSrc: '${movie.posterPath}',
              height: 160,
              width: 120,
              radius: 15,
            ),
            const SizedBox(
              height: 8,
            ),
            Text
              (movie.title, 
              style: const TextStyle(
                fontSize: 16.0 ,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.amber,),
                Text
                  ('${movie.voteAverage} (${movie.voteCount})', 
                  style: const TextStyle(
                    fontSize: 16.0 ,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ]
        ),
      )
    ],
  );
}