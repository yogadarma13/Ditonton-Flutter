import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist/tv_series/watchlist_tv_series_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_state.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistTvSeriesBloc>().add(OnWatchlistRequest()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(OnWatchlistRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvSeriesBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is WatchlistHasData) {
            final result = state.result;
            return ListView.builder(
              itemBuilder: (context, index) {
                final movie = result[index];
                return MovieCard(movie, CategoryMovie.TvSeries);
              },
              itemCount: result.length,
            );
          } else if (state is WatchlistError) {
            return Center(
              key: Key('error_message'),
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
      // Consumer<WatchlistMovieNotifier>(
      //   builder: (context, data, child) {
      //     if (data.watchlistTvState == RequestState.Loading) {
      //       return Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     } else if (data.watchlistTvState == RequestState.Loaded) {
      //       return ListView.builder(
      //         itemBuilder: (context, index) {
      //           final movie = data.watchlistTvSeries[index];
      //           return MovieCard(movie, CategoryMovie.TvSeries);
      //         },
      //         itemCount: data.watchlistTvSeries.length,
      //       );
      //     } else {
      //       return Center(
      //         key: Key('error_message'),
      //         child: Text(data.message),
      //       );
      //     }
      //   },
      // ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
