import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_tv_series_page.dart';
import 'package:flutter/material.dart';

class WatchlistPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Watchlist'),
          bottom: TabBar(
            tabs: [
              Tab(
                text: "Movies",
              ),
              Tab(
                text: "TV Series",
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            WatchlistMoviesPage(),
            WatchlistTvSeriesPage(),
          ],
        ),
      ),
    );
  }
}
