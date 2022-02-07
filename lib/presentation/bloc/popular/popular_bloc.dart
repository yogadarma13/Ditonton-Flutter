import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/popular/popular_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
