import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/watchlist/movies/watchlist_movies_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_event.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistMoviesBloc>().add(OnWatchlistRequest()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    context.read<WatchlistMoviesBloc>().add(OnWatchlistRequest());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMoviesBloc, BlocState>(
          builder: (context, state) {
            if (state is StateLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is StateHasData) {
              final result = state.result;
              return result.isNotEmpty
                  ? ListView.builder(
                      itemBuilder: (context, index) {
                        final movie = result[index];
                        return MovieCard(movie, CategoryMovie.Movies);
                      },
                      itemCount: result.length,
                    )
                  : Center(
                      key: Key('empty_message'),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/empty.png',
                            width: 240,
                            height: 240,
                          ),
                          Text(
                            'No Data',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    );
            } else if (state is StateError) {
              return Center(
                key: Key('error_message'),
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
