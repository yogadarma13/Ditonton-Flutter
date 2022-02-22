import 'package:core/common/utils.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/tv_series/watchlist_tv_series_bloc.dart';
import '../bloc/watchlist_event.dart';

class WatchlistTvSeriesPage extends StatefulWidget {
  @override
  _WatchlistTvSeriesPageState createState() => _WatchlistTvSeriesPageState();
}

class _WatchlistTvSeriesPageState extends State<WatchlistTvSeriesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistTvSeriesBloc>().add(const OnWatchlistRequest()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(const OnWatchlistRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistTvSeriesBloc, BlocState>(
          builder: (context, state) {
            if (state is StateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateHasData) {
              final result = state.result;
              return result.isNotEmpty
                  ? ListView.builder(
                      key: const Key('tv_watchlist_list'),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(
                          key: Key('item_$index'),
                          movie: movie,
                          category: CategoryMovie.TvSeries,
                        );
                      },
                      itemCount: result.length,
                    )
                  : Center(
                      key: const Key('empty_message'),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empty.png',
                            width: 240,
                            height: 240,
                          ),
                          const Text(
                            'No Data',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    );
            } else if (state is StateError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
