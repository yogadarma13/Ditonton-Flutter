import 'package:core/presentation/bloc/popular/popular_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_popular_movies.dart';
import '../../../domain/usecases/get_popular_tv_series.dart';
import '../../../utils/state_enum.dart';
import '../bloc_event.dart';
import '../bloc_state.dart';

class PopularBloc extends Bloc<BlocEvent, BlocState> {
  final GetPopularMoviesUseCase _getPopularMovies;
  final GetPopularTvSeriesUseCase _getPopularTvSeries;

  PopularBloc(this._getPopularMovies, this._getPopularTvSeries)
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
