import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home/airing_today/airing_today_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AiringTodayBloc extends Bloc<BlocEvent, BlocState> {
  final GetAiringTodayTvSeriesUseCase _getAiringTodayTvSeries;

  AiringTodayBloc(this._getAiringTodayTvSeries) : super(StateEmpty()) {
    on<OnAiringTodayRequest>((event, emit) async {
      emit(StateLoading());

      final result = await _getAiringTodayTvSeries.execute();

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
