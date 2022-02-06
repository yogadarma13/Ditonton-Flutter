import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'top_rated_event.dart';
part 'top_rated_state.dart';

class TopRatedBloc extends Bloc<TopRatedEvent, TopRatedState> {
  final GetTopRatedMoviesUseCase _getTopRatedMovies;
  final GetTopRatedTvSeriesUseCase _getTopRatedTvSeries;

  TopRatedBloc(this._getTopRatedMovies, this._getTopRatedTvSeries)
      : super(TopRatedEmpty()) {
    on<OnTopRatedRequest>((event, emit) async {
      final category = event.category;

      emit(TopRatedLoading());

      final result = category == CategoryMovie.Movies
          ? await _getTopRatedMovies.execute()
          : await _getTopRatedTvSeries.execute();

      result.fold(
        (failure) {
          emit(TopRatedError(failure.message));
        },
        (data) {
          emit(TopRatedHasData(data));
        },
      );
    });
  }
}
