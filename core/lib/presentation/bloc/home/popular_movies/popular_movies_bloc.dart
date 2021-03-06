import 'package:core/presentation/bloc/home/popular_movies/popular_movies_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_popular_movies.dart';
import '../../bloc_event.dart';
import '../../bloc_state.dart';

class PopularMoviesBloc extends Bloc<BlocEvent, BlocState> {
  final GetPopularMoviesUseCase _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(StateEmpty()) {
    on<OnPopularMoviesRequest>((event, emit) async {
      emit(StateLoading());

      final result = await _getPopularMovies.execute();

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
