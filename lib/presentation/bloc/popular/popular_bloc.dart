import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'popular_event.dart';
part 'popular_state.dart';

class PopularBloc extends Bloc<PopularEvent, PopularState> {
  final GetPopularMoviesUseCase _getPopularMovies;
  final GetPopularTvSeriesUseCase _getPopularTvSeries;

  PopularBloc(this._getPopularMovies, this._getPopularTvSeries)
      : super(PopularEmpty()) {
    on<OnPopularRequest>((event, emit) async {
      final category = event.category;

      emit(PopularLoading());

      final result = category == CategoryMovie.Movies
          ? await _getPopularMovies.execute()
          : await _getPopularTvSeries.execute();

      result.fold(
        (failure) {
          emit(PopularError(failure.message));
        },
        (data) {
          emit(PopularHasData(data));
        },
      );
    });
  }
}
