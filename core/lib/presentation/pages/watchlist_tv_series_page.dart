import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../common/utils.dart';
import '../../utils/state_enum.dart';
import '../bloc/bloc_state.dart';
import '../bloc/watchlist/tv_series/watchlist_tv_series_bloc.dart';
import '../bloc/watchlist/watchlist_event.dart';
import '../widgets/movie_card_list.dart';

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

  @override
  void didPopNext() {
    context.read<WatchlistTvSeriesBloc>().add(OnWatchlistRequest());
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
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie, CategoryMovie.TvSeries);
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
