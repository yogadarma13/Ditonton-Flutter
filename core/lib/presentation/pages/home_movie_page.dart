import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/movie.dart';
import '../../styles/text_styles.dart';
import '../../utils/constants.dart';
import '../../utils/state_enum.dart';
import '../bloc/bloc_state.dart';
import '../bloc/home_movie/playing_today_bloc.dart';
import '../bloc/home_movie/playing_today_event.dart';
import '../bloc/popular/popular_bloc.dart';
import '../bloc/popular/popular_event.dart';
import '../bloc/top_rated/top_rated_bloc.dart';
import '../bloc/top_rated/top_rated_event.dart';
import 'movie_detail_page.dart';

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
          context.read<PopularBloc>().add(OnPopularRequest(widget.category)),
          context.read<TopRatedBloc>().add(OnTopRatedRequest(widget.category)),
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
            icon: const Icon(Icons.search),
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
                    return MovieList(result, widget.category);
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
              BlocBuilder<PopularBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, widget.category);
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
              BlocBuilder<TopRatedBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, widget.category);
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

class MovieList extends StatelessWidget {
  final List<Movie> movies;
  final CategoryMovie category;

  const MovieList(this.movies, this.category);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  DETAIL_ROUTE,
                  arguments:
                      DetailScreenArguments(id: movie.id, category: category),
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
