import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_popular_tv_series.dart';
import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'popular_movie_event.dart';

class PopularMovieBloc extends Bloc<BlocEvent, BlocState> {
  final GetPopularMoviesUseCase _getPopularMovies;
  final GetPopularTvSeriesUseCase _getPopularTvSeries;

  PopularMovieBloc(this._getPopularMovies, this._getPopularTvSeries)
      : super(StateEmpty()) {
    on<OnPopularRequest>((event, emit) async {
      final category = event.category;

      emit(StateLoading());

      final result = category == CategoryMovie.Movies
          ? await _getPopularMovies.execute()
          : await _getPopularTvSeries.execute();

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
