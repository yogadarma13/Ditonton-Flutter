import 'package:core/presentation/bloc/bloc_event.dart';
import 'package:core/presentation/bloc/bloc_state.dart';
import 'package:core/utils/state_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

import '../../domain/search_movies.dart';
import '../../domain/search_tv_series.dart';
import 'search_event.dart';

class SearchBloc extends Bloc<BlocEvent, BlocState> {
  final SearchMoviesUseCase _searchMovies;
  final SearchTvSeriesUseCase _searchTvSeries;

  SearchBloc(this._searchMovies, this._searchTvSeries) : super(StateEmpty()) {
    on<OnResetData>((event, emit) async {
      emit(const StateHasData([]));
    });

    on<OnQueryChanged>((event, emit) async {
      final query = event.query;
      final category = event.category;

      emit(StateLoading());
      final result = category == CategoryMovie.Movies
          ? await _searchMovies.execute(query)
          : await _searchTvSeries.execute(query);

      result.fold(
        (failure) {
          emit(StateError(failure.message));
        },
        (data) {
          emit(StateHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }
}
