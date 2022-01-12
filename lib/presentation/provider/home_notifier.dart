import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  final GetNowPlayingMoviesUseCase getNowPlayingMovies;

  HomeNotifier({required this.getNowPlayingMovies});

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    // result.fold(
    //   (failure) {
    //     _nowPlayingState = RequestState.Error;
    //     notifyListeners();
    //   },
    //   (moviesData) {
    //     _nowPlayingState = RequestState.Loaded;
    //     notifyListeners();
    //   },
    // );
  }
}
