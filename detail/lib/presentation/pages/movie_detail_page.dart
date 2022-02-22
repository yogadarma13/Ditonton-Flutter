import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/styles/colors.dart';
import 'package:core/styles/text_styles.dart';
import 'package:core/utils/routes.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../bloc/detail_movie/detail_bloc.dart';
import '../bloc/detail_movie/detail_event.dart';
import '../bloc/recommendation/recommendation_bloc.dart';
import '../bloc/recommendation/recommendation_event.dart';
import '../bloc/watchlist/watchlist_bloc.dart';
import '../bloc/watchlist/watchlist_event.dart';
import '../widgets/season_tv_card_list.dart';

class MovieDetailPage extends StatefulWidget {
  final DetailScreenArguments arguments;

  const MovieDetailPage({required this.arguments});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<DetailBloc>()
          .add(OnDetailRequest(widget.arguments.category, widget.arguments.id));
      context.read<RecommendationBloc>().add(OnRecommendationRequest(
          widget.arguments.category, widget.arguments.id));
      context
          .read<WatchlistBloc>()
          .add(OnWatchlistStatusRequest(widget.arguments.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, BlocState>(
        builder: (context, state) {
          if (state is StateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is StateHasData) {
            final result = state.result;
            return SafeArea(
              child: DetailContent(result, widget.arguments.category),
            );
          } else if (state is StateError) {
            return Text(state.message);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final CategoryMovie category;

  const DetailContent(
    this.movie,
    this.category,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          key: const Key('image_detail'),
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.title,
                              style: kHeading5,
                              key: const Key('title_detail'),
                            ),
                            BlocBuilder<WatchlistBloc, WatchlistStatusState>(
                                builder: (context, state) {
                              return ElevatedButton(
                                key: const Key('watchlist_button'),
                                onPressed: () async {
                                  if (!state.isAddedToWatchlist) {
                                    context.read<WatchlistBloc>().add(
                                          OnSaveWatchlistRequest(
                                              movie, category.name),
                                        );
                                  } else {
                                    context.read<WatchlistBloc>().add(
                                          OnRemoveWatchlistRequest(movie),
                                        );
                                  }
                                  ScaffoldMessenger.of(context)
                                      .hideCurrentSnackBar();

                                  await Future.delayed(
                                      const Duration(milliseconds: 50));

                                  final message = context
                                      .read<WatchlistBloc>()
                                      .watchlistMessage;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                },
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    state.isAddedToWatchlist
                                        ? const Icon(Icons.check)
                                        : const Icon(Icons.add),
                                    const Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            Text(
                              _showGenres(movie.genres),
                              key: const Key('genres'),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                              key: const Key('duration'),
                            ),
                            Row(
                              key: const Key('rating'),
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                              key: const Key('overview_value'),
                            ),
                            if (category == CategoryMovie.TvSeries ||
                                movie.seasons != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 16),
                                  Text(
                                    'Seasons',
                                    style: kHeading6,
                                  ),
                                  SizedBox(
                                    height: 210,
                                    child: ListView.builder(
                                      key: const Key('seasons_list'),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final season = movie.seasons![index];
                                        return SeasonTvCardList(season);
                                      },
                                      itemCount: movie.seasons?.length,
                                    ),
                                  ),
                                ],
                              ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationBloc, BlocState>(
                              builder: (context, state) {
                                if (state is StateLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is StateHasData) {
                                  final result = state.result;
                                  return SizedBox(
                                    height: 150,
                                    child: ListView.builder(
                                      key: const Key('recommendation_list'),
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                DETAIL_ROUTE,
                                                arguments:
                                                    DetailScreenArguments(
                                                        id: movie.id,
                                                        category: category),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else if (state is StateError) {
                                  return Text(state.message);
                                } else {
                                  return Container();
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              key: const Key('back_button_detail'),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}

class DetailScreenArguments {
  final int id;
  final CategoryMovie category;

  DetailScreenArguments({required this.id, required this.category});
}
