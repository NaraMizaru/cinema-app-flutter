import 'package:cinema_app/injector.dart';
import 'package:cinema_app/movie/providers/movie_get_detail_provider.dart';
import 'package:cinema_app/widget/item_movie_widget.dart';
import 'package:dartz/dartz.dart';
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
            _WidgetAppBar(context),
            _WidgetSummary(),
          ],
        ),
      ),
    );
  }
}

class _WidgetAppBar extends SliverAppBar {
  final BuildContext context;

  _WidgetAppBar(this.context);

  @override
  Color? get backgroundColor => Colors.black;

  @override
  Color? get foregroundColor => Colors.white;

  @override
  Widget? get leading =>  Padding(
    padding: EdgeInsets.all(8.0),
    child: CircleAvatar(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        }, 
        icon: Icon(
          Icons.arrow_back
        ),
      ),
    ),
  );

  @override
  List<Widget>? get actions => [
      Padding(
      padding: EdgeInsets.all(8.0),
      child: CircleAvatar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: IconButton(
          onPressed: () {}, 
          icon: Icon(
            Icons.public
          ),
        ),
      ),
    )
  ];

  @override
  double? get expandedHeight => 300;

  @override
  Widget? get flexibleSpace =>   Consumer<MovieGetDetailProvider>(
    builder: (__, provider, ___) {
      final movie = provider.movie;
      
      if (movie != null) {
        return ItemMovieWidget(
          movieDetail: movie, 
          heightBackdrop: double.infinity,
          widthBackdrop: double.infinity, 
          heightPoster: 160.0, 
          widthPoster: 100.0,
          radius: 0,
        );
      }

      return Container(
        color: Colors.white10,
        height: double.infinity,
        width: double.infinity,
      );
    },
  );
}

class _WidgetSummary extends SliverToBoxAdapter {

  Widget _content({ required String title, required Widget body }) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 8.0),
      body,
      const SizedBox(height: 12.0),
    ],
  );


  TableRow _tableContent({ required String title, required String content }) => TableRow(
    children: [
      Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(content),
      )
    ]
  );

  @override
  Widget? get child => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Consumer<MovieGetDetailProvider>(
      builder: (_, provider, ___) {
        final movie = provider.movie;
  
        if (movie != null) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _content(
                title: 'Release Date', 
                body: Row(
                  children: [
                    const Icon(
                      Icons.calendar_month_rounded,
                      size: 32.0,
                    ),
                    const SizedBox(width: 6.0),
                    Text(
                      movie.releaseDate.toString().split(' ').first,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  ],
                ),
              ),
              _content(
                title: 'Genres',
                body: Wrap(
                  spacing: 6,
                  children: movie.genres
                    .map((genre) => Chip(label: Text(genre.name)))
                    .toList(),
                ),
              ),
              _content(
                title: 'Overview',
                body: Text(movie.overview)
              ),
              _content(
                title: 'Summary',
                body: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  children: [
                    _tableContent(
                      title: "Adult", 
                      content: movie.adult ? "Yes" : "No",
                    ),
                    _tableContent(
                      title: "Popularity", 
                      content: '${movie.popularity}',
                    ),
                    _tableContent(
                      title: "Status", 
                      content: movie.status,
                    ),
                    _tableContent(
                      title: "Budget", 
                      content: '${movie.budget}',
                    ),
                    _tableContent(
                      title: "Revenue", 
                      content: '${movie.revenue}',
                    ),
                    _tableContent(
                      title: "Tagline", 
                      content: '${movie.tagline}',
                    ),
                  ],
                )
              ),
            ],
          );
        }
  
        return Container();
      },
    ),
  );
}