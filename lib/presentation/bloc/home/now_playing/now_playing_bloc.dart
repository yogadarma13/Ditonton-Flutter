import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/bloc_event.dart';
import 'package:ditonton/presentation/bloc/bloc_state.dart';
import 'package:ditonton/presentation/bloc/home/now_playing/now_playing_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NowPlayingBloc extends Bloc<BlocEvent, BlocState> {
  final GetNowPlayingMoviesUseCase _getNowPlayingMovies;

  NowPlayingBloc(this._getNowPlayingMovies) : super(StateEmpty()) {
    on<OnNowPlayingRequest>((event, emit) async {
      emit(StateLoading());

      final result = await _getNowPlayingMovies.execute();

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
