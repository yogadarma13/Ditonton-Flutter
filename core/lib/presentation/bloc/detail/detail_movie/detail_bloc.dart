import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_movie_detail.dart';
import '../../../../domain/usecases/get_tv_series_detail.dart';
import '../../../../utils/state_enum.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';
import 'detail_event.dart';

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
