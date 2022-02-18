import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_watchlist_movies.dart';
import '../../../../utils/state_enum.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';
import '../watchlist_event.dart';

class WatchlistMoviesBloc extends Bloc<BlocEvent, BlocState> {
  final GetWatchlistMoviesUseCase _getWatchlistMovies;

  WatchlistMoviesBloc(this._getWatchlistMovies) : super(StateEmpty()) {
    on<OnWatchlistRequest>((event, emit) async {
      emit(StateLoading());

      final result =
          await _getWatchlistMovies.execute(CategoryMovie.Movies.name);

      result.fold(
        (failure) {
          emit(StateError(failure.message));
        },
        (data) {
          emit(StateHasData(data));
        },
      );
    });
  }
}
