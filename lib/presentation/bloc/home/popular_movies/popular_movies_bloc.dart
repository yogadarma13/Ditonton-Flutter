import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home/home_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesBloc extends Bloc<BlocEvent, BlocState> {
  final GetPopularMoviesUseCase _getPopularMovies;

  PopularMoviesBloc(this._getPopularMovies) : super(StateEmpty()) {
    on<OnHomeRequest>((event, emit) async {
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
