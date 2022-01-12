import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _airingTodayTvSeries = <Movie>[];

  List<Movie> get airingTodayTvSeries => _airingTodayTvSeries;

  RequestState _airingTodayState = RequestState.Empty;

  RequestState get airingTodayState => _airingTodayState;

  final GetNowPlayingMoviesUseCase getNowPlayingMovies;
  final GetAiringTodayTvSeriesUseCase getAiringTodayTvSeries;

  HomeNotifier({
    required this.getNowPlayingMovies,
    required this.getAiringTodayTvSeries,
  });

  String _message = '';

  String get message => _message;

  Future<void> fetchNowPlayingMovies() async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) {
        _nowPlayingState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _nowPlayingState = RequestState.Loaded;
        _nowPlayingMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchAiringTodayTvSeries() async {
    _airingTodayState = RequestState.Loading;
    notifyListeners();

    final result = await getAiringTodayTvSeries.execute();
    result.fold(
      (failure) {
        _airingTodayState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (tvSeriesData) {
        _airingTodayState = RequestState.Loaded;
        _airingTodayTvSeries = tvSeriesData;
        notifyListeners();
      },
    );
  }
}
