import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_movie_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<HomeNotifier>(context, listen: false)
      ..fetchNowPlayingMovies()
      ..fetchAiringTodayTvSeries()
      ..fetchPopularMovies()
      ..fetchPopularTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu),
        title: Text('Ditonton'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing Movies',
                style: kHeading6,
              ),
              Consumer<HomeNotifier>(builder: (context, data, child) {
                final state = data.nowPlayingState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.nowPlayingMovies);
                } else {
                  return Text('Failed');
                }
              }),
              SizedBox(
                height: 10,
              ),
              Text(
                'Airing Today TV Series',
                style: kHeading6,
              ),
              Consumer<HomeNotifier>(builder: (context, data, child) {
                final state = data.airingTodayState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.airingTodayTvSeries);
                } else {
                  return Text('Failed');
                }
              }),
              SizedBox(
                height: 10,
              ),
              Text(
                'Popular Movies',
                style: kHeading6,
              ),
              Consumer<HomeNotifier>(builder: (context, data, child) {
                final state = data.popularMoviesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.popularMovies);
                } else {
                  return Text('Failed');
                }
              }),
              SizedBox(
                height: 10,
              ),
              Text(
                'Popular TV Series',
                style: kHeading6,
              ),
              Consumer<HomeNotifier>(builder: (context, data, child) {
                final state = data.popularTvSeriesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return MovieList(data.popularTvSeries);
                } else {
                  return Text('Failed');
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}
