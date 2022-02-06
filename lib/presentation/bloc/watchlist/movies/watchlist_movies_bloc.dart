import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../watchlist_event.dart';
import '../watchlist_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistMoviesUseCase _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies) : super(WatchlistEmpty()) {
    on<OnWatchlistRequest>((event, emit) async {
      emit(WatchlistLoading());

      final result =
          await _getWatchlistMovies.execute(CategoryMovie.Movies.name);

      result.fold(
        (failure) {
          emit(WatchlistError(failure.message));
        },
        (data) {
          emit(WatchlistHasData(data));
        },
      );
    });
  }
}
