import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_watchlist_movies.dart';
import '../watchlist_event.dart';

class WatchlistTvSeriesBloc extends Bloc<BlocEvent, BlocState> {
  final GetWatchlistMoviesUseCase _getWatchlistMovies;

  WatchlistTvSeriesBloc(this._getWatchlistMovies) : super(StateEmpty()) {
    on<OnWatchlistRequest>((event, emit) async {
      emit(StateLoading());

      final result =
          await _getWatchlistMovies.execute(CategoryMovie.TvSeries.name);

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
