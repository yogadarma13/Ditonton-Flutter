import 'package:core/domain/usecases/get_airing_today_tv_series.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'playing_today_event.dart';

class PlayingTodayBloc extends Bloc<BlocEvent, BlocState> {
  final GetNowPlayingMoviesUseCase _getNowPlayingMovies;
  final GetAiringTodayTvSeriesUseCase _getAiringTodayTvSeriesUseCase;

  PlayingTodayBloc(
      this._getNowPlayingMovies, this._getAiringTodayTvSeriesUseCase)
      : super(StateEmpty()) {
    on<OnPlayingTodayRequest>((event, emit) async {
      final category = event.category;

      emit(StateLoading());

      final result = category == CategoryMovie.Movies
          ? await _getNowPlayingMovies.execute()
          : await _getAiringTodayTvSeriesUseCase.execute();

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
