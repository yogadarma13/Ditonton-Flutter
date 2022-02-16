import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/detail/detail_movie/detail_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailBloc extends Bloc<BlocEvent, BlocState> {
  final GetMovieDetailUseCase _getMovieDetail;
  final GetTvSeriesDetailUseCase _getTvSeriesDetail;

  DetailBloc(this._getMovieDetail, this._getTvSeriesDetail)
      : super(StateEmpty()) {
    on<OnDetailRequest>((event, emit) async {
      final category = event.category;
      final id = event.id;

      emit(StateLoading());

      final result = category == CategoryMovie.Movies
          ? await _getMovieDetail.execute(id)
          : await _getTvSeriesDetail.execute(id);

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
