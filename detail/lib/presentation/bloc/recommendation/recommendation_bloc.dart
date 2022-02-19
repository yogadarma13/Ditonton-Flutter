import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/get_movie_recommendations.dart';
import '../../../domain/usecases/get_tv_series_recommendations.dart';
import 'recommendation_event.dart';

class RecommendationBloc extends Bloc<BlocEvent, BlocState> {
  final GetMovieRecommendationsUseCase _getMovieRecommendations;
  final GetTvSeriesRecommendationsUseCase _getTvSeriesRecommendations;

  RecommendationBloc(
      this._getMovieRecommendations, this._getTvSeriesRecommendations)
      : super(StateEmpty()) {
    on<OnRecommendationRequest>((event, emit) async {
      final category = event.category;
      final id = event.id;

      emit(StateLoading());

      final result = category == CategoryMovie.Movies
          ? await _getMovieRecommendations.execute(id)
          : await _getTvSeriesRecommendations.execute(id);

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
