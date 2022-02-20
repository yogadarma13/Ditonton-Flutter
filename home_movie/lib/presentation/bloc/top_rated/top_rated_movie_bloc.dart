import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:core/domain/usecases/get_top_rated_tv_series.dart';
import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'top_rated_movie_event.dart';

class TopRatedMovieBloc extends Bloc<BlocEvent, BlocState> {
  final GetTopRatedMoviesUseCase _getTopRatedMovies;
  final GetTopRatedTvSeriesUseCase _getTopRatedTvSeries;

  TopRatedMovieBloc(this._getTopRatedMovies, this._getTopRatedTvSeries)
      : super(StateEmpty()) {
    on<OnTopRatedRequest>((event, emit) async {
      final category = event.category;

      emit(StateLoading());

      final result = category == CategoryMovie.Movies
          ? await _getTopRatedMovies.execute()
          : await _getTopRatedTvSeries.execute();

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
