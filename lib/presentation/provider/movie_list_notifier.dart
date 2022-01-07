import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_airing_today_tv_series.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/material.dart';

class MovieListNotifier extends ChangeNotifier {
  var _nowPlayingMovies = <Movie>[];

  List<Movie> get nowPlayingMovies => _nowPlayingMovies;

  RequestState _nowPlayingState = RequestState.Empty;

  RequestState get nowPlayingState => _nowPlayingState;

  var _popularMovies = <Movie>[];

  List<Movie> get popularMovies => _popularMovies;

  RequestState _popularMoviesState = RequestState.Empty;

  RequestState get popularMoviesState => _popularMoviesState;

  var _topRatedMovies = <Movie>[];

  List<Movie> get topRatedMovies => _topRatedMovies;

  RequestState _topRatedMoviesState = RequestState.Empty;

  RequestState get topRatedMoviesState => _topRatedMoviesState;

  String _message = '';

  String get message => _message;

  MovieListNotifier(
      {required this.getNowPlayingMovies,
      required this.getAiringTodayTvSeries,
      required this.getPopularMovies,
      required this.getTopRatedMovies,
      required this.getPopularTvSeries,
      required this.getTopRatedTvSeries});

  final GetNowPlayingMoviesUseCase getNowPlayingMovies;
  final GetAiringTodayTvSeriesUseCase getAiringTodayTvSeries;
  final GetPopularMoviesUseCase getPopularMovies;
  final GetTopRatedMoviesUseCase getTopRatedMovies;
  final GetPopularTvSeriesUseCase getPopularTvSeries;
  final GetTopRatedTvSeriesUseCase getTopRatedTvSeries;

  Future<void> fetchNowPlayingMovies(CategoryMovie category) async {
    _nowPlayingState = RequestState.Loading;
    notifyListeners();

    final result = category == CategoryMovie.Movies
        ? await getNowPlayingMovies.execute()
        : await getAiringTodayTvSeries.execute();
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

  Future<void> fetchPopularMovies(CategoryMovie category) async {
    _popularMoviesState = RequestState.Loading;
    notifyListeners();

    final result = category == CategoryMovie.Movies
        ? await getPopularMovies.execute()
        : await getPopularTvSeries.execute();

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

  Future<void> fetchTopRatedMovies(CategoryMovie category) async {
    _topRatedMoviesState = RequestState.Loading;
    notifyListeners();

    final result = category == CategoryMovie.Movies
        ? await getTopRatedMovies.execute()
        : await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        _topRatedMoviesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _topRatedMoviesState = RequestState.Loaded;
        _topRatedMovies = moviesData;
        notifyListeners();
      },
    );
  }
}
