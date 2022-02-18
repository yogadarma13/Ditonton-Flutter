import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_airing_today_tv_series.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';
import 'airing_today_event.dart';

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
