import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
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

  var _popularMovies = <Movie>[];

  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.Empty;

  RequestState get popularMoviesState => _popularMoviesState;

  RequestState _popularTvSeriesState = RequestState.Empty;

  RequestState get popularTvSeriesState => _popularTvSeriesState;

  final GetNowPlayingMoviesUseCase getNowPlayingMovies;
  final GetAiringTodayTvSeriesUseCase getAiringTodayTvSeries;
  final GetPopularMoviesUseCase getPopularMovies;
  final GetPopularTvSeriesUseCase getPopularTvSeries;

  HomeNotifier({
    required this.getNowPlayingMovies,
    required this.getAiringTodayTvSeries,
    required this.getPopularMovies,
    required this.getPopularTvSeries,
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

  Future<void> fetchPopularMovies() async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = await getPopularMovies.execute();
    result.fold(
      (failure) {
        _popularMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _popularMoviesState = RequestState.Loaded;
        _popularMovies = moviesData;
        notifyListeners();
      },
    );
  }

  void fetchPopularTvSeries() {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();

    getPopularTvSeries.execute();
  }
}
