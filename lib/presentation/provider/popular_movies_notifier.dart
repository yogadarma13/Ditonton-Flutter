import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter/foundation.dart';

class PopularMoviesNotifier extends ChangeNotifier {
  final GetPopularMoviesUseCase getPopularMovies;
  final GetPopularTvSeriesUseCase getPopularTvSeries;

  PopularMoviesNotifier(this.getPopularMovies, this.getPopularTvSeries);

  RequestState _state = RequestState.Empty;

  RequestState get state => _state;

  List<Movie> _movies = [];

  List<Movie> get movies => _movies;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularMovies(CategoryMovie category) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = category == CategoryMovie.Movies
        ? await getPopularMovies.execute()
        : await getPopularTvSeries.execute();

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
