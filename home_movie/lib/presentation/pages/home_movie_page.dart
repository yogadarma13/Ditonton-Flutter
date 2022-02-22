import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/widgets/movie_list.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/playing_today/playing_today_bloc.dart';
import '../bloc/playing_today/playing_today_event.dart';
import '../bloc/popular/popular_movie_bloc.dart';
import '../bloc/popular/popular_movie_event.dart';
import '../bloc/top_rated/top_rated_movie_bloc.dart';
import '../bloc/top_rated/top_rated_movie_event.dart';

class HomeMoviePage extends StatefulWidget {
  final CategoryMovie category;

  const HomeMoviePage({required this.category});

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => {
          context
              .read<PlayingTodayBloc>()
              .add(OnPlayingTodayRequest(widget.category)),
          context
              .read<PopularMovieBloc>()
              .add(OnPopularRequest(widget.category)),
          context
              .read<TopRatedMovieBloc>()
              .add(OnTopRatedRequest(widget.category)),
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            widget.category == CategoryMovie.Movies ? 'Movies' : 'TV Series'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                SEARCH_ROUTE,
                arguments: widget.category,
              );
            },
            icon: const Icon(
              Icons.search,
              key: Key('search'),
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<PlayingTodayBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList('now_playing', result, widget.category);
                  } else if (state is StateError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  POPULAR_ROUTE,
                  arguments: widget.category,
                ),
              ),
              BlocBuilder<PopularMovieBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList('popular', result, widget.category);
                  } else if (state is StateError) {
                    return const Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TOP_RATED_ROUTE,
                  arguments: widget.category,
                ),
              ),
              BlocBuilder<TopRatedMovieBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList('top_rated', result, widget.category);
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

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}
