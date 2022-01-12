import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  final GetNowPlayingMoviesUseCase getNowPlayingMovies;

  HomeNotifier({required this.getNowPlayingMovies});

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {},
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
