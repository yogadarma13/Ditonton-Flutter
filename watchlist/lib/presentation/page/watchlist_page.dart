import 'package:flutter/material.dart';
import 'package:watchlist/presentation/page/watchlist_movies_page.dart';
import 'package:watchlist/presentation/page/watchlist_tv_series_page.dart';

class WatchlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Watchlist'),
          bottom: const TabBar(
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
