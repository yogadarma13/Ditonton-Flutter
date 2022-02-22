import 'package:core/common/utils.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/presentation/widgets/movie_card_list.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/movies/watchlist_movies_bloc.dart';
import '../bloc/watchlist_event.dart';

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<WatchlistMoviesBloc>().add(const OnWatchlistRequest()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(const OnWatchlistRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, BlocState>(
          builder: (context, state) {
            if (state is StateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateHasData) {
              final result = state.result;
              return result.isNotEmpty
                  ? ListView.builder(
                      key: const Key('movie_watchlist_list'),
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(
                          key: Key('item_$index'),
                          movie: movie,
                          category: CategoryMovie.Movies,
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
