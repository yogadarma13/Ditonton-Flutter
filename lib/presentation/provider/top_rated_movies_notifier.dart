import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tv_series.dart';
import 'package:flutter/foundation.dart';

class TopRatedMoviesNotifier extends ChangeNotifier {
  final GetTopRatedMoviesUseCase getTopRatedMovies;
  final GetTopRatedTvSeriesUseCase getTopRatedTvSeries;

  TopRatedMoviesNotifier(
      {required this.getTopRatedMovies, required this.getTopRatedTvSeries});

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedMovies(CategoryMovie category) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = category == CategoryMovie.Movies
        ? await getTopRatedMovies.execute()
        : await getTopRatedTvSeries.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (moviesData) {
        _movies = moviesData;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
