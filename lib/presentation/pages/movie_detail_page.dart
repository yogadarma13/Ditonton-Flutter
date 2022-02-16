import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/detail/detail_movie/detail_bloc.dart';
import 'package:ditonton/presentation/bloc/detail/detail_movie/detail_event.dart';
import 'package:ditonton/presentation/bloc/detail/recommendation/recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/detail/recommendation/recommendation_event.dart';
import 'package:ditonton/presentation/bloc/detail/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/bloc/detail/watchlist/watchlist_event.dart';
import 'package:ditonton/presentation/widgets/season_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final DetailScreenArguments arguments;

  MovieDetailPage({required this.arguments});

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
      // Provider.of<MovieDetailNotifier>(context, listen: false)
      //     .loadWatchlistStatus(widget.arguments.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailBloc, BlocState>(
        builder: (context, state) {
          if (state is StateLoading) {
            return Center(
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
      // Consumer<MovieDetailNotifier>(
      //   builder: (context, provider, child) {
      //     if (provider.movieState == RequestState.Loading) {
      //       return Center(
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (provider.movieState == RequestState.Loaded) {
      //       final movie = provider.movie;
      //       return SafeArea(
      //         child: DetailContent(
      //           movie,
      //           widget.arguments.category,
      //           provider.movieRecommendations,
      //           provider.isAddedToWatchlist,
      //         ),
      //       );
      //     } else {
      //       return Text(provider.message);
      //     }
      //   },
      // ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final CategoryMovie category;

  // final List<Movie> recommendations;
  // final bool isAddedWatchlist;

  DetailContent(
    this.movie,
    this.category,
    // this.recommendations,
    // this.isAddedWatchlist,
  );

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
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
                            ),
                            BlocBuilder<WatchlistBloc, WatchlistStatusState>(
                                builder: (context, state) {
                              return ElevatedButton(
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
                                  await Future.delayed(
                                      Duration(milliseconds: 50));

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
                                        ? Icon(Icons.check)
                                        : Icon(Icons.add),
                                    Text('Watchlist'),
                                  ],
                                ),
                              );
                            }),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     if (!isAddedWatchlist) {
                            //       context.read<WatchlistBloc>().add(
                            //           OnAddWatchlistRequest(
                            //               movie, category.name, movie.id));
                            //       // await Provider.of<MovieDetailNotifier>(
                            //       //         context,
                            //       //         listen: false)
                            //       //     .addWatchlist(movie, category.name);
                            //     } else {
                            //       // await Provider.of<MovieDetailNotifier>(
                            //       //         context,
                            //       //         listen: false)
                            //       //     .removeFromWatchlist(movie);
                            //       context.read<WatchlistBloc>().add(
                            //           OnRemoveWatchlistRequest(
                            //               movie, movie.id));
                            //     }
                            //
                            //     final message =
                            //         Provider.of<MovieDetailNotifier>(context,
                            //                 listen: false)
                            //             .watchlistMessage;
                            //
                            //     if (message ==
                            //             MovieDetailNotifier
                            //                 .watchlistAddSuccessMessage ||
                            //         message ==
                            //             MovieDetailNotifier
                            //                 .watchlistRemoveSuccessMessage) {
                            //       ScaffoldMessenger.of(context).showSnackBar(
                            //           SnackBar(content: Text(message)));
                            //     } else {
                            //       showDialog(
                            //           context: context,
                            //           builder: (context) {
                            //             return AlertDialog(
                            //               content: Text(message),
                            //             );
                            //           });
                            //     }
                            //   },
                            //   child: Row(
                            //     mainAxisSize: MainAxisSize.min,
                            //     children: [
                            //       isAddedWatchlist
                            //           ? Icon(Icons.check)
                            //           : Icon(Icons.add),
                            //       Text('Watchlist'),
                            //     ],
                            //   ),
                            // ),
                            Text(
                              _showGenres(movie.genres),
                            ),
                            Text(
                              _showDuration(movie.runtime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: movie.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${movie.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              movie.overview,
                            ),
                            if (category == CategoryMovie.TvSeries ||
                                movie.seasons != null)
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 16),
                                  Text(
                                    'Seasons',
                                    style: kHeading6,
                                  ),
                                  Container(
                                    height: 200,
                                    child: ListView.builder(
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
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationBloc, BlocState>(
                              builder: (context, state) {
                                if (state is StateLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state is StateHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                MovieDetailPage.ROUTE_NAME,
                                                arguments:
                                                    DetailScreenArguments(
                                                        id: movie.id,
                                                        category: category),
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
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
                            // Consumer<MovieDetailNotifier>(
                            //   builder: (context, data, child) {
                            //     if (data.recommendationState ==
                            //         RequestState.Loading) {
                            //       return Center(
                            //         child: CircularProgressIndicator(),
                            //       );
                            //     } else if (data.recommendationState ==
                            //         RequestState.Error) {
                            //       return Text(data.message);
                            //     } else if (data.recommendationState ==
                            //         RequestState.Loaded) {
                            //       return Container(
                            //         height: 150,
                            //         child: ListView.builder(
                            //           scrollDirection: Axis.horizontal,
                            //           itemBuilder: (context, index) {
                            //             final movie = recommendations[index];
                            //             return Padding(
                            //               padding: const EdgeInsets.all(4.0),
                            //               child: InkWell(
                            //                 onTap: () {
                            //                   Navigator.pushReplacementNamed(
                            //                     context,
                            //                     MovieDetailPage.ROUTE_NAME,
                            //                     arguments:
                            //                         DetailScreenArguments(
                            //                             id: movie.id,
                            //                             category: category),
                            //                   );
                            //                 },
                            //                 child: ClipRRect(
                            //                   borderRadius: BorderRadius.all(
                            //                     Radius.circular(8),
                            //                   ),
                            //                   child: CachedNetworkImage(
                            //                     imageUrl:
                            //                         'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            //                     placeholder: (context, url) =>
                            //                         Center(
                            //                       child:
                            //                           CircularProgressIndicator(),
                            //                     ),
                            //                     errorWidget:
                            //                         (context, url, error) =>
                            //                             Icon(Icons.error),
                            //                   ),
                            //                 ),
                            //               ),
                            //             );
                            //           },
                            //           itemCount: recommendations.length,
                            //         ),
                            //       );
                            //     } else {
                            //       return Container();
                            //     }
                            //   },
                            // ),
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
              icon: Icon(Icons.arrow_back),
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
