import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home/airing_today/airing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/home/home_event.dart';
import 'package:ditonton/presentation/bloc/home/now_playing/now_playing_bloc.dart';
import 'package:ditonton/presentation/bloc/home/popular_movies/popular_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/home/popular_tv_series/popular_tv_series_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_movie_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          context.read<NowPlayingBloc>().add(OnHomeRequest()),
          context.read<AiringTodayBloc>().add(OnHomeRequest()),
          context.read<PopularMoviesBloc>().add(OnHomeRequest()),
          context.read<PopularTvSeriesBloc>().add(OnHomeRequest())
        });
    // Provider.of<HomeNotifier>(context, listen: false)
    //   ..fetchNowPlayingMovies()
    //   ..fetchAiringTodayTvSeries()
    //   ..fetchPopularMovies()
    //   ..fetchPopularTvSeries());
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
              BlocBuilder<NowPlayingBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.Movies);
                  } else if (state is StateError) {
                    return Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              // Consumer<HomeNotifier>(builder: (context, data, child) {
              //   final state = data.nowPlayingState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(data.nowPlayingMovies, CategoryMovie.Movies);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              SizedBox(
                height: 10,
              ),
              Text(
                'Airing Today TV Series',
                style: kHeading6,
              ),
              BlocBuilder<AiringTodayBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.TvSeries);
                  } else if (state is StateError) {
                    return Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              // Consumer<HomeNotifier>(builder: (context, data, child) {
              //   final state = data.airingTodayState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(
              //         data.airingTodayTvSeries, CategoryMovie.TvSeries);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              SizedBox(
                height: 10,
              ),
              Text(
                'Popular Movies',
                style: kHeading6,
              ),
              BlocBuilder<PopularMoviesBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.Movies);
                  } else if (state is StateError) {
                    return Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              // Consumer<HomeNotifier>(builder: (context, data, child) {
              //   final state = data.popularMoviesState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(data.popularMovies, CategoryMovie.Movies);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              SizedBox(
                height: 10,
              ),
              Text(
                'Popular TV Series',
                style: kHeading6,
              ),
              BlocBuilder<PopularTvSeriesBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.TvSeries);
                  } else if (state is StateError) {
                    return Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              // Consumer<HomeNotifier>(builder: (context, data, child) {
              //   final state = data.popularTvSeriesState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(
              //         data.popularTvSeries, CategoryMovie.TvSeries);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
            ],
          ),
        ),
      ),
    );
  }
}
