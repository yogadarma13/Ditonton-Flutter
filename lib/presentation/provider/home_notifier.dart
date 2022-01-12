import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  final GetNowPlayingMoviesUseCase getNowPlayingMovies;

  HomeNotifier({required this.getNowPlayingMovies});
}
