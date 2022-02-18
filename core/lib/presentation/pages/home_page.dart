import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../styles/text_styles.dart';
import '../../utils/state_enum.dart';
import '../bloc/bloc_state.dart';
import '../bloc/home/airing_today/airing_today_bloc.dart';
import '../bloc/home/airing_today/airing_today_event.dart';
import '../bloc/home/now_playing/now_playing_bloc.dart';
import '../bloc/home/now_playing/now_playing_event.dart';
import '../bloc/home/popular_movies/popular_movies_bloc.dart';
import '../bloc/home/popular_movies/popular_movies_event.dart';
import '../bloc/home/popular_tv_series/popular_tv_series_bloc.dart';
import '../bloc/home/popular_tv_series/popular_tv_series_event.dart';
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
          context.read<NowPlayingBloc>().add(OnNowPlayingRequest()),
          context.read<AiringTodayBloc>().add(OnAiringTodayRequest()),
          context.read<PopularMoviesBloc>().add(OnPopularMoviesRequest()),
          context.read<PopularTvSeriesBloc>().add(OnPopularTvSeriesRequest())
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu),
        title: const Text('Ditonton'),
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
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.Movies);
                  } else if (state is StateError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Airing Today TV Series',
                style: kHeading6,
              ),
              BlocBuilder<AiringTodayBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.TvSeries);
                  } else if (state is StateError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Popular Movies',
                style: kHeading6,
              ),
              BlocBuilder<PopularMoviesBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.Movies);
                  } else if (state is StateError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Popular TV Series',
                style: kHeading6,
              ),
              BlocBuilder<PopularTvSeriesBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, CategoryMovie.TvSeries);
                  } else if (state is StateError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
