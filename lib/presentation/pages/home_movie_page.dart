import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home_movie/playing_today_bloc.dart';
import 'package:ditonton/presentation/bloc/home_movie/playing_today_event.dart';
import 'package:ditonton/presentation/bloc/popular/popular_bloc.dart';
import 'package:ditonton/presentation/bloc/popular/popular_event.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/top_rated/top_rated_event.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/movie';

  final CategoryMovie category;

  HomeMoviePage({required this.category});

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
                SearchPage.ROUTE_NAME,
                arguments: widget.category,
              );
            },
            icon: Icon(Icons.search),
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
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, widget.category);
                  } else if (state is StateError) {
                    return Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              // Consumer<MovieListNotifier>(builder: (context, data, child) {
              //   final state = data.nowPlayingState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(data.nowPlayingMovies, widget.category);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              _buildSubHeading(
                title: 'Popular',
                onTap: () => Navigator.pushNamed(
                  context,
                  PopularMoviesPage.ROUTE_NAME,
                  arguments: widget.category,
                ),
              ),
              BlocBuilder<PopularBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, widget.category);
                  } else if (state is StateError) {
                    return Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              // Consumer<MovieListNotifier>(builder: (context, data, child) {
              //   final state = data.popularMoviesState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(data.popularMovies, widget.category);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () => Navigator.pushNamed(
                  context,
                  TopRatedMoviesPage.ROUTE_NAME,
                  arguments: widget.category,
                ),
              ),
              BlocBuilder<TopRatedBloc, BlocState>(
                builder: (context, state) {
                  if (state is StateLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is StateHasData) {
                    final result = state.result;
                    return MovieList(result, widget.category);
                  } else if (state is StateError) {
                    return Text('Failed');
                  } else {
                    return Container();
                  }
                },
              ),
              // Consumer<MovieListNotifier>(builder: (context, data, child) {
              //   final state = data.topRatedMoviesState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(data.topRatedMovies, widget.category);
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
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
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

  MovieList(this.movies, this.category);

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  MovieDetailPage.ROUTE_NAME,
                  arguments:
                      DetailScreenArguments(id: movie.id, category: category),
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
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
