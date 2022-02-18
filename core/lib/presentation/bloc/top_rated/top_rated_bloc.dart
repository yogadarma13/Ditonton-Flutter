import 'package:core/presentation/bloc/top_rated/top_rated_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_top_rated_movies.dart';
import '../../../domain/usecases/get_top_rated_tv_series.dart';
import '../../../utils/state_enum.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class TopRatedBloc extends Bloc<BlocEvent, BlocState> {
  final GetTopRatedMoviesUseCase _getTopRatedMovies;
  final GetTopRatedTvSeriesUseCase _getTopRatedTvSeries;

  TopRatedBloc(this._getTopRatedMovies, this._getTopRatedTvSeries)
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
