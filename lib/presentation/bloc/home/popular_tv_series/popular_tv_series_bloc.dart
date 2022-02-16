import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home/popular_tv_series/popular_tv_series_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularTvSeriesBloc extends Bloc<BlocEvent, BlocState> {
  final GetPopularTvSeriesUseCase _getPopularTvSeriesUseCase;

  PopularTvSeriesBloc(this._getPopularTvSeriesUseCase) : super(StateEmpty()) {
    on<OnPopularTvSeriesRequest>((event, emit) async {
      emit(StateLoading());

      final result = await _getPopularTvSeriesUseCase.execute();

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
